*proc sort;

*-------------------------------------------------------;
/*
	Ejemplo 1
*/

proc sort data=Cursosas.Municipios;
    by Region Dep Zona descending Poblacion;
run;

*-------------------------------------------------------;
/*
	Ejemplo 2
*/

proc sort data=CursoSAS.Municipios;
    by descending Superficie;
run;

title "Municipios rurales con mayor superficie en la Región Centro Oriente";

proc print data=CursoSAS.Municipios (obs=5) noobs;
    var Departamento Dep Municipio Superficie;
    where Region="Región Centro Oriente" and Zona="Rural";
run;

*-------------------------------------------------------;
/*
	Ejemplo 3
*/

proc sort data=CursoSAS.Municipios;
    by Poblacion;
run;

title "Ciudades capitales con menor población en Colombia";
proc print data=CursoSAS.Municipios (obs=3) noobs;
    var Departamento Dep Municipio Poblacion;
    where Tipo="Capital";
run

*------------------|||||||||||||---------------;
*proc freq;
/*
	Ejemplo 1
*/
proc freq data=CursoSAS.Municipios order= freq;
    table Departamento Zona / nocum; *nocum: no muestra los acumulados de la tabla;
run;

*-------------------------------------------------------;

/*
	Ejemplo 2
*/
proc freq data=CursoSAS.Municipios order=freq;
    table Departamento;
    weight Poblacion; *sumar poblacion;
    ods output OneWayFreqs=TF2;*guardar como en un conjunto de datos (en la libreria WORK);
run;

proc contents data=TF2 varnum;
run;

proc print data=TF2 (obs=10) noobs;
run;

*-------------------------------------------------------;

/*
	Ejemplo 3
*/

proc freq data=CursoSAS.Municipios order=freq;
    where Dep="13";
    table Zona Municipio;
    weight Poblacion; *sumar poblacion;
run;

*-------------------------------------------------------;

/*
	Ejemplo 4
*/

proc freq data=CursoSAS.Municipios order=freq;
    table  Zona Departamento;
    weight Superficie;
run;

*-------------------------------------------------------;

/*
	Ejemplo 5
*/

proc freq data=CursoSAS.Municipios order=freq; *Tabla de contingencia;
    table Departamento*Zona; *tabla bivariada;
    ods output CrossTabFreqs=TF5;
run;

proc contents data=TF5 varnum;
run;

proc print data=TF5 (obs=50) noobs;
run;

*-------------------------------------------------------;

/*
	Ejemplo 6
*/

proc freq data=CursoSAS.Municipios order=freq; *Tabla de contingencia;
    table Departamento*Zona / nocol norow nopercent;
    weight Poblacion;
    ods output CrossTabFreqs=TF6;
run;

proc contents data=TF6 varnum;
run;

proc print data=TF6 (obs=10) noobs;
run;

*proc means;

*-------------------------------------------------------;
/*
Estadisticas descriptivas

	Ejemplo 1
*/
proc means data=CursoSAS.Municipios  n nmiss mean min max stackodsoutput;
    var Poblacion Superficie Irural;
    ods output Summary=ED1;
run;

proc contents data=ED1 varnum;
run;

proc print data=ED1 (obs=10) noobs;
run;

*-------------------------------------------------------;
/*
	Ejemplo 2
*/
proc means data=CursoSAS.Municipios min p25 p50 p75 max stackodsoutput;
    var Poblacion Superficie Irural;
    ods output Summary=ED2;
run;

proc contents data=ED2 varnum;
run;

proc print data=ED2 (obs=10) noobs;
run;

*-------------------------------------------------------;
/*
	Ejemplo 3
*/

proc means data=CursoSAS.Municipios min p25 p50 p75 max stackodsoutput;
    var Poblacion Superficie Irural;
    class Departamento;
    ods output Summary=ED3;
run;

proc contents data=ED3 varnum;
run;

proc print data=ED3 (obs=10) noobs;
run;

*-------------------------------------------------------;
/*
	Ejemplo 4
	
	Ponderacion
*/
proc means data=CursoSAS.Municipios min p25 mean p50 p75 max stackodsoutput;
    var Irural;
    class Departamento / descend;
    weight Poblacion;
run;


*-------------------------------------------------------;
*proc format;
/*
Crear formatos personalizados
Cambiar las visualizaciones, solo las visualizaciones
*/

proc format;
value  cylind   3-5="Cinco o menos cilindros" 
                  6="Seis cilindros" 
               8-12="Siete o más cilindros"; *aplicar formato a varaibles numericas (rangos);
             
value $origen "USA"="Estados Unidos"
              other="Europa y Asia"; *aplicar formato a varaibles nominales;
run;

proc print data=sashelp.cars (obs=10) noobs;
    format cylinders cylind. origin $origen.;
    where type = "Sedan";
run;

proc freq data=sashelp.cars;
    table cylinders origin;
    format cylinders cylind. origin $origen.;
    where type = "Sedan";
run;

proc means data=sashelp.cars min p25 p50 p75 max nolabel noobs;
    var horsepower weight;
    class cylinders;
    format cylinders cylind.;
run;