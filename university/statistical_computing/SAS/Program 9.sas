/*
FUNCIONES IML

*/

/*
Ejemplo 1
*/
proc iml;
    M = {5 1, 1 3};
    a = min(eigval(M));
    if(a > 0) then
      print "La matriz M es definida positiva pues su mínimo valor propio es" a[label=""];  
    else print "La matriz M no es definida positiva";
quit;

/*
Ejemplo 2

*/
proc iml;
    M = {5 1, 1 -3};
    a = det(M);
    if(a ^= 0) then print "La matriz M no es singular pues su determinante es" a[label=""];
    else print "La matriz M es singular";
quit;

/*
Ejemplo 3

*/

proc iml;
    use sashelp.iris (keep=sepallength sepalwidth petallength petalwidth);
    m = contents();
    read all into X;
    mu = mean(X);
    Y = X - mu;
    S = t(Y)*Y/(nrow(Y)-1);
    Z = (X - mu)/std(X);
    R = t(Z)*Z/(nrow(Z)-1);
    print mu[colname=m label="Vector de medias" format=d10.4];
    print  S[rowname=m colname=m label="Matriz de varianzas-covarianzas" format=d10.4];
    print  R[rowname=m colname=m label="Matriz de correlaciones" format=d10.4];
quit;

/*
Ejemplo 4
*/
proc iml;
    use sashelp.iris(keep=sepallength sepalwidth);
    m = contents();
    read all into X;

    Z = (X - mean(X))/std(X);

    create iris2 from Z[colname=m];
    append from Z;
    close iris2;
quit;

*Pegado horizontal;
data iris2;
set sashelp.iris;
set iris2;
run;

proc print data=iris2 (obs=10) noobs;
run;

proc means data=iris2 mean std stackodsoutput;
    var sepallength sepalwidth;
run;

/*
Ejemplo 5
ACP
*/

proc iml;
    use sashelp.iris (keep=_numeric_);
    m = contents();
    read all into X;
    Z = (X - mean(X))/std(X);
    S = t(Z)*Z/(nrow(Z)-1);
    vec = eigvec(S);
    val = eigval(S);
    b = cusum(val);
    val = val||100*val/sum(val)||100*b/sum(val);
    s = do(1,ncol(X),1);
    print val[colname={"Eigenvalue" "Percentage" "Cumulative"}
    label="Eigenvalues of the Correlation Matrix" rowname=s format=d10.4];
    print vec[rowname=m colname=s label="Principal Components" format=d10.4];
quit;

proc princomp data=sashelp.iris;
    var _numeric_;
run;

*cars;}
proc print data=sashelp.cars noobs;
run;

proc iml;
    use sashelp.cars (keep= MPG_City MPG_Highway Weight Horsepower);
    m = contents();
    read all into X;
    Z = (X - mean(X)/std(X));
    S = t(Z)*Z/(nrow(Z)-1);
    vec = eigvec(S);
    val = eigval(S);
    b = cusum(val);
    val = val||100*val/sum(val)||100*b/sum(val);
    s = do(1,ncol(X),1);
    print val[colname={"Eigenvalue" "Percentage" "Cumulative"}
    label="Eigenvalues of the Correlation Matrix" rowname=s format=d10.4];
    print vec[rowname=m colname=s label="Principal Components" format=d10.4];
quit;

proc princomp data=sashelp.cars;
    var MPG_City MPG_Highway Weight Horsepower;
run;

/*
FUNCIONES PERSONALIZADAS USANDO MACROS

bool = 0 -> Z normalizado

*/
%macro acp(vars,data,bool=0);
    proc iml;
      %put NOTE: AAAAAAAAAAAAAAAAAAA;
      use &data (keep=&vars);
      m = contents();
      read all into X;
      Z = X - mean(X);%if &bool=0 %then %do;Z = Z/std(X);%put WARNING: Matriz de correlaciones;%end;
      %else %do;%put WARNING: Matriz de covarianzas;%end;
      S = t(Z)*Z/(nrow(Z) - 1);
      vec = eigvec(S);
      val = eigval(S);
      b = cusum(val);
      val = val||100*val/sum(val)||100*b/sum(val);
      s = do(1,ncol(X),1);
      print val[colname={"Eigenvalue" "Percentage" "Cumulative"}
      label="Eigenvalues of the Correlation Matrix" rowname=s];
      print vec[rowname=m colname=s label="Principal Components"];
    quit;

%mend;

%acp(sepallength sepalwidth petallength petalwidth,sashelp.iris,bool = "heatrghdg");
%acp(sepallength sepalwidth petallength petalwidth,sashelp.iris);

proc princomp data=sashelp.iris;
var _numeric_;
run;

/*
Macro:
Muestreo de Bernoulli (BER)

*/
%macro ber(data,tre,out=mysample);
    %if &tre <= 0 or &tre >= 1 %then %do;
      %put ERROR: TRE debe estar en el intervalo (0,1);
      %return;
    %end;
    data &out;
      set &data;
      u = rand("Uniform",0,1);
      if u > &tre then delete;
      drop u;
    run;
    proc sql noprint;
      select count(*) into:p 
      from &data;
      select count(*) into:s 
      from &out;
    quit;
    %put NOTE: Muestreo de Bernoulli aplicado a &data;
    %put NOTE: Tamaño de la Población = &p;
    %put NOTE: Tamaño Relativo Esperado = &tre;
    %put NOTE: Tamaño de la Muestra = &s;
%mend;

%ber(sashelp.baseball,0.2,out=bersample);

proc contents data=bersample varnum;
run;


/*
Macro:
Muestreo Aleatorio Simple (MAS)
*/

%macro mas(data,size,out=mysample);
    proc sql noprint;
      select count(*) into: p 
      from &data;
    quit;  
    %if &size < 1 or &size > &p or %sysfunc(floor(&size)) ^= &size %then %do;
      %put ERROR: SIZE debe ser un entero en el intervalo [1,N];
      %return;
    %end;
    data &out;
      set &data;
      u = rand("Uniform",0,1);
    run;
    proc sort data=&out;
      by u;
    run;
    data &out;
      set &out;
      if _n_ > &size then delete;
      drop u;
    run;
    %put NOTE: MAS aplicado a &data;
    %put NOTE: Tamaño de la Población = &p;
    %put NOTE: Tamaño de la Muestra = &size;
%mend;

%mas(sashelp.baseball,32,out=massample);

proc contents data=massample varnum;
run;
/*EL FINA' */