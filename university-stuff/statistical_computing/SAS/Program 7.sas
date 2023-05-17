/*
9.1 proc sgplot
9.2 proc sgpanel
9.3 proc sgscatter
9.4 proc sgpie
*/


proc import datafile="/home/u63344598/sasuser.v94/Advertising.xlsx" dbms=xlsx out=Advertising replace;
    getnames=yes;
run;

proc contents data=Advertising varnum;
run;

proc print data=Advertising (obs=10) noobs;
run;

/*
Ejemplo 1

Scatter plot 
*/
proc sgplot data=Advertising;
    scatter x=tv y=sales;
    xaxis   label="Publicidad en TV";
    yaxis   label="Ventas";
    title   "Ventas versus inversión en publicidad en TV";
run;

/*
Ejemplo 2
Gráfico de dispersión personalizado de las ventas del producto (sales) versus la inversión en publicidad en televisión para el mismo (TV).
*/

proc sgplot data=Advertising noautolegend;
    scatter x=tv y=sales / markerattrs=(size=8 symbol=circlefilled color=red);
    title   color=black justify=center "Ventas versus inversión en publicidad en TV";
    xaxis   label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
            labelattrs=(color=blue size=9 weight=normal);
    yaxis   label="Ventas" labelpos=center grid values=(0 to 30 by 5)
            labelattrs=(color=blue size=9 weight=normal);
run;

/*
Ejemplo 3
Curva suavizada de tendencia, Regresion polinomial (de grado 3)
Entre mayor el grado es mayor la agresividad
*/

proc sgplot data=Advertising noautolegend;
    reg     x=tv y=sales / degree=3 clm markerattrs=(size=8 symbol=circlefilled color=red)
                         lineattrs=(pattern=mediumdash thickness=1 color=black);
    title   color=black justify=center "Ventas versus inversión en publicidad en TV";
    xaxis   label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
            labelattrs=(color=blue size=8 weight=normal);
    yaxis   label="Ventas" labelpos=center grid values=(0 to 30 by 5)
            labelattrs=(color=blue size=8 weight=normal);
run;

/*
Ejemplo 4
smooth: valor menor (muy agresivo), valor mayor(linea recta)

*/

proc sgplot data=Advertising noautolegend;
    pbspline x=tv y=sales / smooth=3E5 clm markerattrs=(size=8 symbol=circlefilled color=red)
                            lineattrs=(pattern=solid thickness=2 color=black);
    title    color=black justify=center "Ventas versus inversión en publicidad en TV";
    xaxis    label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
             labelattrs=(color=blue size=8 weight=normal);
    yaxis    label="Ventas" labelpos=center grid values=(0 to 30 by 5)
             labelattrs=(color=blue size=8 weight=normal);
run;

/*
Ejemplo 5
Grafico de burbujas
*/

proc sgplot data=Advertising;
    bubble     x=tv y=sales size=radio / colorresponse=radio colormodel=(white 
) dataskin=pressed;
    title      color=bLack justify=center "Ventas versus inversión en publicidad en TV";
    xaxis      label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
               labelattrs=(color=blue size=8 weight=normal);
    yaxis      label="Ventas" labelpos=center grid values=(0 to 30 by 5)
               labelattrs=(color=blue size=8 weight=normal);      
    gradlegend / title="Publicidad en Radio" position=right 
                 titleattrs=(color=blue size=8 style=normal weight=normal);          
run;

/*
Ejemplo 6

*/

%include "/home/u63344598/sasuser.v94/mismacros.sas";
%categories(Advertising,radio,3,radioC);

proc format;
    value bma 1="Baja" 2="Media" 3="Alta";
run;

proc freq data=Advertising;
    table radioC;
    format radioC bma.;
run;

ods graphics on / attrpriority=none;
proc sgplot data=Advertising noautolegend;
    styleattrs datacontrastcolors=(red black blue)
               datasymbols=(circlefilled squarefilled trianglefilled);
    scatter    x=tv y=sales / group=radioC grouporder=ascending markerattrs=(size=8);
    title      color=black justify=center "Ventas versus inversión en publicidad en TV";
    xaxis      label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
               labelattrs=(color=blue size=8 weight=normal);
    yaxis      label="Ventas" labelpos=center grid values=(0 to 30 by 5)
               labelattrs=(color=blue size=8 weight=normal);
    keylegend  / noborder title="Publicidad en Radio" down=1 location=outside position=bottom;
    format     radioC bma.;
run;
ods graphics on / attrpriority=color;           
run;
/*
Ejemplo 7

*/
ods graphics on / attrpriority=none;
proc sgplot data=Advertising;
      styleattrs datacontrastcolors=(red black blue) datasymbols=(circlefilled squarefilled trianglefilled);
      scatter    x=tv y=sales / group=radioC grouporder=ascending markerattrs=(size=8);
      reg        x=tv y=sales / group=radioC nomarkers degree=3 lineattrs=(pattern=solid thickness=2);
      title      color=black justify=center "Ventas versus inversión en publicidad en TV";
      xaxis      label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
                 labelattrs=(color=blue size=8 weight=normal);
      yaxis      label="Ventas" labelpos=center grid values=(0 to 30 by 5)
                 labelattrs=(color=blue size=8 weight=normal);
      legenditem type=markerline name="B" / label="Baja"  lineattrs=GraphData1 markerattrs=GraphData1; 
      legenditem type=markerline name="M" / label="Media" lineattrs=GraphData2 markerattrs=GraphData2; 
      legenditem type=markerline name="A" / label="Alta"  lineattrs=GraphData3 markerattrs=GraphData3;            
      keylegend  "B" "M" "A" / noborder title="Publicidad en Radio" down=1 location=outside position=bottom;
run;
ods graphics on / attrpriority=color;           
run;

/*
Ejemplo 8

*/

ods graphics on / attrpriority=none;
proc sgplot data=Advertising;
      styleattrs datacontrastcolors=(red black blue) datasymbols=(circlefilled squarefilled trianglefilled);
      scatter    x=tv y=sales / group=radioC grouporder=ascending markerattrs=(size=8);
      pbspline   x=tv y=sales / group=radioC nomarkers smooth=5e5 lineattrs=(pattern=solid thickness=2);
      title      color=black justify=center "Ventas versus inversión en publicidad en TV";
      xaxis      label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
                 labelattrs=(color=blue size=8 weight=normal);
      yaxis      label="Ventas" labelpos=center grid values=(0 to 30 by 5)
                 labelattrs=(color=blue size=8 weight=normal);
      legenditem type=markerline name="B" / label="Baja"  lineattrs=GraphData1 markerattrs=GraphData1; 
      legenditem type=markerline name="M" / label="Media" lineattrs=GraphData2 markerattrs=GraphData2; 
      legenditem type=markerline name="A" / label="Alta"  lineattrs=GraphData3 markerattrs=GraphData3;            
      keylegend  "B" "M" "A" / noborder title="Publicidad en Radio" down=1 location=outside position=bottom;
run;
ods graphics on / attrpriority=color;           
run;

/*
Ejemplo 9

*/

ods graphics on / attrpriority=none;
proc sgplot data=Advertising;
      styleattrs datacontrastcolors=(red black blue) datasymbols=(circlefilled squarefilled trianglefilled);
      scatter    x=tv y=sales / group=radioC grouporder=ascending markerattrs=(size=8);
      loess      x=tv y=sales / group=radioC  lineattrs=(pattern=solid thickness=2) smooth=0.45;
      title      color=black justify=center "Ventas versus inversión en publicidad en TV";
      xaxis      label="Inversión en publicidad en TV" labelpos=center grid values=(0 to 300 by 50)
                 labelattrs=(color=blue size=8 weight=normal);
      yaxis      label="Ventas" labelpos=center grid values=(0 to 30 by 5)
                 labelattrs=(color=blue size=8 weight=normal);
      legenditem type=markerline name="B" / label="Baja"  lineattrs=GraphData1 markerattrs=GraphData1; 
      legenditem type=markerline name="M" / label="Media" lineattrs=GraphData2 markerattrs=GraphData2; 
      legenditem type=markerline name="A" / label="Alta"  lineattrs=GraphData3 markerattrs=GraphData3;            
      keylegend  "B" "M" "A" / noborder title="Publicidad en Radio" down=1 location=outside position=bottom;
run;
ods graphics on / attrpriority=color;

/*
Ejemplo 10

*/

%categories(Advertising,newspaper,4,newspaperC);

proc format;
    value bmma 1="Baja" 2="Media baja" 3="Media alta" 4="Alta";
run;

proc freq data=Advertising;
    table newspaperC;
    format newspaperC bmma.;
run;

ods graphics on / attrpriority=none;
proc sgpanel data=Advertising;
      styleattrs datacontrastcolors=(red black blue) 
                 datasymbols=(circlefilled squarefilled trianglefilled);
      panelby    newspaperC / layout=panel rows=2 columns=2 uniscale=row novarname 
                              headerattrs=(color=blue size=8 weight=normal);           
      scatter    x=tv y=sales / group=radioC grouporder=ascending markerattrs=(size=8);
      reg        x=tv y=sales / group=radioC nomarkers degree=3 lineattrs=(pattern=solid thickness=2);
      title      color=black justify=center "Inversión en publicidad en periódico";
      colaxis    label="Inversión en publicidad en TV" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      rowaxis    label="Ventas" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      legenditem type=markerline name="B" / label="Baja"  lineattrs=GraphData1 markerattrs=GraphData1; 
      legenditem type=markerline name="M" / label="Media" lineattrs=GraphData2 markerattrs=GraphData2; 
      legenditem type=markerline name="A" / label="Alta"  lineattrs=GraphData3 markerattrs=GraphData3;            
      keylegend  "B" "M" "A" / noborder title="Publicidad en Radio" down=1 position=bottom;
      format     radioC bma. newspaperC bmma.;
run;
ods graphics on / attrpriority=color;

/*
Ejemplo 11

*/

ods graphics on / attrpriority=none;
proc sgpanel data=Advertising;
      styleattrs datacontrastcolors=(red black blue) 
                 datasymbols=(circlefilled squarefilled trianglefilled);
      panelby    newspaperC / layout=panel rows=2 columns=2 uniscale=row novarname 
                              headerattrs=(color=blue size=8 weight=normal);           
      scatter    x=tv y=sales / group=radioC grouporder=ascending markerattrs=(size=8);
      pbspline   x=tv y=sales / group=radioC nomarkers smooth=5e5 lineattrs=(pattern=solid thickness=2);
      title      color=black justify=center "Inversión en publicidad en periódico";
      colaxis    label="Inversión en publicidad en TV" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      rowaxis    label="Ventas" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      legenditem type=markerline name="B" / label="Baja"  lineattrs=GraphData1 markerattrs=GraphData1; 
      legenditem type=markerline name="M" / label="Media" lineattrs=GraphData2 markerattrs=GraphData2; 
      legenditem type=markerline name="A" / label="Alta"  lineattrs=GraphData3 markerattrs=GraphData3;            
      keylegend  "B" "M" "A" / noborder title="Publicidad en Radio" down=1 position=bottom;
      format     radioC bma. newspaperC bmma.;
run;
ods graphics on / attrpriority=color;

/*
Ejemplo 12

*/

proc sgplot data=sashelp.stocks;
    styleattrs datacontrastcolors=(red blue gray);
    series     x=date y=open / markers group=stock markerattrs=(size=4 symbol=squarefilled)
               lineattrs=(pattern=solid thickness=1) ;
    title      color=black justify=center "Evolución de la cotización";
    xaxis      label=" " grid valueattrs=(color=black size=10);
    yaxis      label=" " grid valueattrs=(color=black size=10);
    keylegend  / title=" " noborder down=1 location=inside position=bottomleft;
run;

/*
Ejemplo 13

*/
proc sgplot data=sashelp.stocks;
    series    x=date y=volume / name="a" legendlabel="Volumen"
                                lineattrs=(color=gray pattern=solid thickness=1);
    series    x=date y=open   / name="b" y2axis legendlabel="Cotización"
                                lineattrs=(color=red pattern=solid thickness=1);
    xaxis     label=" " grid valueattrs=(color=black size=10);
    yaxis     label="Cantidad" labelattrs=(color=blue) grid;
    y2axis    label="Valor, en dólares" labelattrs=(color=blue) grid;
    keylegend "a" "b" / noborder down=1 location=outside;
    where     stock="Microsoft";
run;

/*
Ejemplo 14

*/

data cars;
set sashelp.cars;
run;

%include "/home/hvanegasp0/Curso/mismacros.sas";
%categories(cars,weight,2,weightC);

proc format;
    value ba 1="Bajo" 2="Alto";
run;

proc freq data=cars;
    table weightC;
    format weightC ba.;
run;
proc sgscatter data=cars datacontrastcolors=(red blue);
   matrix     mpg_highway horsepower enginesize / group=weightC markerattrs=(size=7 symbol=circlefilled)
                                                  legend=(down=2 noborder position=right title="Peso");
   label      mpg_highway="Millas por galón" horsepower="Caballos de fuerza" enginesize="Tamaño del motor";         
   title      color=black justify=left "Matriz de dispersión";
   format     weightC ba.;
run;

/*
Ejemplo 15

*/

proc sgscatter data=sashelp.cars;
    plot  mpg_highway*(horsepower weight wheelbase enginesize) / rows=2 columns=2
          grid reg=(lineattrs=(thickness=2 color=blue) degree=3) 
          markerattrs=(size=5 symbol=circlefilled color=red);
    label mpg_highway="Millas por galón" horsepower="Caballos de fuerza" weight="Peso"
          wheelbase="Distancia entre ejes" enginesize="Tamaño del motor"; 
    title color=black justify=right "Gráficos de dispersión";
run;

/*
Ejemplo 16

*/

proc sgpie data=CursoSAS.Municipios;
    styleattrs backcolor=white datacolors=(orange blue salmon green yellow aquamarine);
    donut Region / datalabelattrs=(color=black size=11 style=normal weight=bold) 
                   datalabeldisplay=(category percent) ringsize=0.4
                   datalabelloc=outside holelabel="Colombia"
                   holelabelattrs=(color=red style=normal weight=bold);
    title "Distribución del número de municipios por Región";             
run;

/*
Ejemplo 17

*/

proc sgpie data=CursoSAS.Municipios;
    styleattrs backcolor=white datacolors=(orange blue salmon green yellow aquamarine);
    donut Region / datalabelattrs=(color=black size=11 style=normal weight=bold) 
                   datalabeldisplay=(category percent) ringsize=0.4 
                   datalabelloc=outside holelabel="Colombia" response=superficie
                   holelabelattrs=(color=red style=normal weight=bold);
    title "Distribución de la Superficie por Región";             
run;

/*
Ejemplo 18

*/

proc sgpie data=CursoSAS.Municipios;
    styleattrs backcolor=white datacolors=(orange blue salmon green yellow aquamarine);
    pie Region /   datalabelattrs=(color=black size=11 style=normal weight=bold) 
                   datalabeldisplay=(category percent)
                   datalabelloc=outside response=poblacion;
    title "Distribución de la Población por Región";             
run;

/*
Ejemplo 19

*/

proc sgpie data=CursoSAS.Municipios;
    styleattrs backcolor=white datacolors=(orange blue salmon green yellow aquamarine);
    pie Region /   datalabelattrs=(color=black size=11 style=normal weight=bold) 
                   datalabeldisplay=(category percent)
                   datalabelloc=outside response=poblacion;
    title "Distribución de la Población por Región";             
run;

/*
Ejemplo 20

*/

proc sgplot data=CursoSAS.Municipios;
    styleattrs datacolors=(orange blue) datacontrastcolors=(orange blue);      
    vbar       Region / group=zona response=poblacion groupdisplay=cluster
                        outlineattrs=(thickness=1) clusterwidth=0.85 stat=sum;  
    title      "Distribución de la Población por Región" color=black bcolor=white;    
    xaxis      label="Población" grid valueattrs=(color=black size=10 style=normal weight=normal);
    yaxis      label=" " valueattrs=(color=black size=10 style=normal weight=normal);
    keylegend  / noborder down=2 location=outside position=right title="Zona"
                 valueattrs=(color=black size=9  style=normal weight=normal)
                 titleattrs=(color=black size=10 style=normal weight=normal);
run;

/*
Ejemplo 21

*/

proc sgplot data=CursoSAS.Municipios;
    styleattrs datacolors=(orange blue) datacontrastcolors=(orange blue);      
    hbar       Departamento / group=zona response=superficie groupdisplay=stack
                        outlineattrs=(thickness=1) clusterwidth=0.95 stat=pct; 
    title      "Distribución de la Superficie por Región" color=black bcolor=white;    
    xaxis      label="Superficie" grid valueattrs=(color=black size=10 style=normal weight=normal);
    yaxis      label=" " valueattrs=(color=black size=10 style=normal weight=normal);
    keylegend  / noborder down=2 location=outside position=right title="Zona"
                 valueattrs=(color=black size=9  style=normal weight=normal)
                 titleattrs=(color=black size=10 style=normal weight=normal);
run;


/*
Ejemplo 22

*/

proc sgpanel data=CursoSAS.Municipios noautolegend;
    styleattrs datacolors=(orange blue) datacontrastcolors=(orange blue);      
    vbar       zona / group=zona response=poblacion groupdisplay=cluster 
                      outlineattrs=(thickness=1) clusterwidth=0.85 stat=sum; 
    panelby    Departamento / layout=panel rows=2 columns=3 uniscale=row novarname 
                        headerattrs=(color=blue size=10 weight=normal);           
    title      "Distribución de la Población por Zona" color=black bcolor=white;  
    rowaxis    label="Población" grid valueattrs=(color=black size=10 style=normal weight=normal);
    colaxis    label=" " valueattrs=(color=black size=10 style=normal weight=normal);
run;

/*
Ejemplo 23

*/

data spruce;
    infile "/home/u63344598/sasuser.v94/spruce.txt" dsd delimiter="09"x firstobs=2;
    informat tree treat $15. size comma6.3 days best.;
    input tree days size treat;
run;

proc contents data=spruce varnum;
run;

proc print data=spruce (obs=10) noobs;
run;
proc sgplot data=spruce;
    styleattrs datacontrastcolors=(orange blue) datacolors=(orange blue);      
    vbox       size / category=days group=treat boxwidth=0.8 nooutliers
                      lineattrs=(color=black pattern=solid thickness=1)
                      medianattrs=(color=black pattern=solid thickness=1); 
    title      "Tree size across the time" color=black bcolor=white;    
    xaxis      label="Days" valueattrs=(color=black size=10 style=normal weight=normal);
    yaxis      label="Size" grid values=(0 to 1600 by 200) 
               valueattrs=(color=black size=10 style=normal weight=normal);
    keylegend  / noborder down=1 location=outside position=bottom title="Atmosphere"
                 valueattrs=(color=black size=9  style=normal weight=normal)
                 titleattrs=(color=black size=10 style=normal weight=normal);
run;

/*
Ejemplo 24

*/

data spruce;
    infile "/home/u63344598/sasuser.v94/spruce.txt" dsd delimiter="09"x firstobs=2;
    informat tree treat $15. size comma6.3 days best.;
    input tree days size treat;
run;
proc sgpanel data=spruce;
      styleattrs datacolors=(yellow blue) datacontrastcolors=(yellow blue);
      panelby    days / layout=panel rows=6 columns=2 uniscale=column
                         headerattrs=(color=red size=8 weight=normal) sort=ascending;
      histogram  size / group=treat dataskin=pressed scale=proportion transparency=0.4 nbins=20 ;
      density size / group=treat;
      title      color=black justify=center "Tree size";
      colaxis    label=" " grid values=(0 to 2000 by 500);
      rowaxis    label=" " grid;
      where days ne 674;
run;