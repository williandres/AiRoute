/*
Output Delivery System (ODS)
https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/odsug/p06w67748n6ms6n1nfhcbg9emn7z.htm

*/

/*
Ejemplo 1

a Excel
*/
proc sort data=CursoSAS.Municipios;
    by Departamento descending Poblacion;
run;

ods excel file='/home/u63344598/sasuser.v94/ods1.xlsx' options(sheet_name='#byval1');

options nodate nonumber nobyline;
proc print data=CursoSAS.Municipios noobs nosumlabel;
    var Depmun Municipio Poblacion Superficie;
    by Departamento;
    sum Poblacion Superficie;
run;

ods excel close;

/*
Ejemplo 2

a PDF
*/

proc sort data=CursoSAS.Municipios;
    by Region Departamento;
run;

ods pdf file='/home/u63344598/sasuser.v94/ods.pdf';
ods noproctitle;
options nodate nonumber nobyline;

proc sgplot data=CursoSAS.Municipios noautolegend pctlevel=by;
    hbar       Departamento / response=poblacion groupdisplay=cluster 
                              clusterwidth=0.45 stat=pct fillattrs=(color=blue); 
    yaxis      label=" ";
    xaxis      label="(%) Población";
    title      '#byval1';             
    by         Region;
run;

ods pdf close;

/*
Ejemplo 3

a PowerPoint

*/

ods powerpoint file='/home/u63344598/sasuser.v94/ods.pptx';
ods noproctitle;
options nodate nonumber nobyline;

proc sgplot data=CursoSAS.Municipios noautolegend pctlevel=by;
    hbar       Departamento / response=superficie groupdisplay=cluster 
                              clusterwidth=0.45 stat=pct fillattrs=(color=red); 
    yaxis      label=" ";
    xaxis      label="(%) Superficie";
    title      '#byval1';             
    by         Region;
    where      Dep ne "11";
run;

ods powerpoint close;

/*
Ejemplo 4

a Word
*/
ods word file='/home/u63344598/sasuser.v94/ods.docx';
ods noproctitle;
options nodate nonumber nobyline;

proc means data=CursoSAS.Municipios n min p25 p50 p75 max nolabels;
    var Poblacion Superficie Irural;
    by Region;
    title '#byval1';
run;

proc sgplot data=CursoSAS.Municipios noautolegend pctlevel=by;
    hbar       Departamento / response=superficie groupdisplay=cluster 
                              clusterwidth=0.45 stat=pct fillattrs=(color=red); 
    yaxis      label=" ";
    xaxis      label="(%) Superficie";
    title      '#byval1';             
    by         Region;
    where      Dep ne "11";
run;


ods word close;


/*
PROBABILIDAD
*/

/*
Ejemplo 1
For loop
needle:aguja
*/
data binom;
    do i=0 to 10 by 1;
       pdf = pdf("binomial",i,0.45,10);
       output;
    end;
run;

proc sgplot data=binom noautolegend;
    needle  x=i y=pdf / baseline=-1
            lineattrs=(pattern=solid color=red thickness=1);
    scatter x=i y=pdf / markerattrs=(symbol=circlefilled color=red);      
    text    x=i y=pdf text=pdf/textattrs=(weight=bold) position=topleft;
    title   justify=center color=blue "Distribución Binomial(10,0.45)";
    xaxis   label="x" labelattrs=(color=blue) values=(0 to 10 by 1);
    yaxis   label="P(X=x)" labelattrs=(color=blue) grid min=0;
run;

/*
Ejemplo 2

Distribucion acumulada
*/     
data binom;
set binom;
    cdf = cdf("binomial",i,0.4,10);
    j = i + 1;
run;

proc sgplot data=binom noautolegend;
    vector  x=i y=cdf / xorigin=j yorigin=cdf noarrowheads
                        lineattrs=(color=red thickness=1);
    scatter x=i y=cdf / markerattrs=(symbol=circlefilled color=red);
    text    x=i y=cdf text=cdf/textattrs=(weight=bold) position=topleft;
    title   justify=center color=blue "Distribución Binomial(10,0.4)";
    xaxis   label="x" labelattrs=(color=blue) values=(0 to 10 by 1);
    yaxis   label="P(X<=x)" labelattrs=(color=blue) grid;
run;

/*
Ejemplo 3
*/

data beta;
    do i=0 to 1 by 0.01;
       pdf = pdf("beta",i,1.5,9.0);
       cdf = cdf("beta",i,1.5,9.0);
       output;
    end;
run;

proc sgplot data=beta;
    series    x=i y=pdf / lineattrs=(pattern=solid color=black thickness=2)
                       name="a" legendlabel="Probability density function";
    series    x=i y=cdf / lineattrs=(pattern=solid color=blue thickness=2) y2axis
                       name="b" legendlabel="Cumulative distribution function";
    title     justify=center color=red "Distribution Beta(1.5,9.0)";
    xaxis     label="x" labelattrs=(color=red size=12) grid;
    yaxis     label="f(x)" labelattrs=(color=black size=12) grid;
    y2axis    label="F(x)" labelattrs=(color=blue size=12) grid;
    keylegend "a" "b" / noborder position=bottomleft down=2;
run;

/*
Ejemplo 4
Interactive
Matrix
Language
*/

proc IML;
	A = {7 5 3,4 2 9,1 8 6};
	b = {6,2,8};
	c = {5 3 9};
	D = j{3,2,7.1};
	print(5);