/*Taller 7 SAS*/
/* Willian Andrés Cárdenas Sandoval
Diego Alejandro Robayo Molina
Andres Felipe Rache Espitia
Andrea Catalina Garcia Montoya */


/************************************* PRIMER PUNTO ****************************************/


proc import datafile="/home/u63343323/Curso/species.xlsx" dbms=xlsx out=species replace;
    getnames=yes;
run;



ods graphics on / attrpriority=none;
proc sgplot data=species;
      styleattrs datacontrastcolors=(red black blue) datasymbols=(circlefilled squarefilled trianglefilled);
      reg        x=Biomass y=Species / group=pH degree=1 markerattrs=(size=8) 
                                       lineattrs=(pattern=solid thickness=2);
      title      color=black justify=center "Especies VS Biomasa por pH";
      xaxis      label="Biomasa" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      yaxis      label="Número de especies" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      keylegend  / title="Nivel pH" down=3 location=outside position=right noborder;
run;
ods graphics on / attrpriority=color;           


ods graphics on / attrpriority=none;
proc sgpanel data=species;
      styleattrs datacontrastcolors=(red black blue) 
                 datasymbols=(circlefilled squarefilled trianglefilled);
      panelby    pH / layout=panel rows=1 columns=3 uniscale=row novarname 
                              headerattrs=(color=blue size=8 weight=normal);           
      scatter    x=Biomass y=Species / group=pH grouporder=ascending markerattrs=(size=8);
      pbspline   x=Biomass y=Species / group=pH  nomarkers smooth=5e5 lineattrs=(pattern=solid thickness=2);
      title      color=black justify=center "Especies VS Biomasa por pH";
      colaxis    label="Biomasa" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
      rowaxis    label="Número de especies" labelpos=center grid
                 labelattrs=(color=blue size=8 weight=normal);
run;
ods graphics on / attrpriority=color;



/******************************* SEGUNDO PUNTO ***************************************/



proc import datafile="/home/u63343323/Curso/mcycle.xlsx" dbms=xlsx out=mcycle replace;
    getnames=yes;
run;


proc sgplot data=mcycle noautolegend;
      pbspline x=times y=accel / markerattrs=(symbol=circlefilled size=8 color=red) 
                                 lineattrs=(pattern=solid thickness=2 color=blue);
      title    color=black justify=center "Aceleración VS Tiempo";
      xaxis    label="Tiempo, en milisegundos" labelpos=center grid
               labelattrs=(color=blue size=8 weight=normal);
      yaxis    label="Aceleración de la cabeza del piloto" labelpos=center grid
               labelattrs=(color=blue size=8 weight=normal);
run;


/************************************ TERCER PUNTO ************************************************/


proc sgplot data=sashelp.citimon;
    series    x=date y=fspcap / name="a" legendlabel="Índice de precios: Capital"
                                lineattrs=(color=blue pattern=solid thickness=1);
    series    x=date y=fspcom / name="b" legendlabel="Índice de precios: Compuesto"
                                lineattrs=(color=red pattern=solid thickness=1);
    series    x=date y=fspcon / name="c" legendlabel="Índice de precios: Consumidor"
                                lineattrs=(color=black pattern=solid thickness=1);
    series    x=date y=lhur   / name="d" y2axis legendlabel="Tasa de desempleo"
                                lineattrs=(color=green pattern=solid thickness=1);
    xaxis     label=" " grid valueattrs=(color=black size=10);
    yaxis     label="Índice de precios" labelattrs=(color=blue) grid;
    y2axis    label="Índice de precios" labelattrs=(color=blue) grid;
    keylegend "a" "b" "c" "d"/ noborder down=2 location=outside;
run;


/******************************************** CUARTO PUNTO ***************************************************/

proc print data=sashelp.bmt;

proc sgplot data=sashelp.bmt noautolegend;
 vbox  T / category=group boxwidth=0.8 nooutliers fillattrs=(color=blue)   
              lineattrs=(color=black pattern=solid thickness=1)
              medianattrs=(color=black pattern=solid thickness=1)
              meanattrs=(symbol=circlefilled color=black) ; 
  title 'Distribución del tiempo de sobrevivencia por grupo de riesgo' color=red bcolor=white;
  xaxis label="Grupo de riesgo" labelattrs=(color=red size=10 style=normal weight=normal);
  yaxis label='Tiempo de sobrevivencia' grid values=(0 to 1200 by 200) 
          labelattrs=(color=red size=10 style=normal weight=normal);
       where status=1;        
 run;


proc sgplot data=sashelp.bmt noautolegend;
  histogram T / group=group binwidth=100 transparency=0.4;
  /*density T / type=kernel group=group;*/
  keylegend / location=inside position=topright across=1;
  title 'Distribución del tiempo de sobrevivencia por grupo de riesgo' color=red bcolor=white;
  xaxis label="Tiempo de sobrevivencia" labelattrs=(color=red size=10 style=normal weight=normal);
  yaxis label='Porcentaje' grid labelattrs=(color=red size=10 style=normal weight=normal);
  where status=1;  
run;


