/*
Ejemplo 18
Cuantos y cuales municipios tienen al menos una estación de monitoreo climático?
*/

proc import datafile="/home/u63344598/sasuser.v94/Estaciones.xlsx" dbms=xlsx out=Estaciones replace; 
    getnames=yes;
run;

proc contents data=Estaciones;
run;

proc print data=Estaciones (obs=10) noobs;
run;

%include "/home/u63344598/sasuser.v94/mismacros.sas";
%missings(Estaciones);

proc sql;
    select distinct Depmun,count(distinct Depmun) as nmunicipios 
    from   Estaciones;
quit;

/*
Ejemplo 19
Conjunto de datos con todos los municipios del país, que incluye una variable que informa el número de estaciones de monitoreo climático con que cuenta cada municipio.

*/

proc sql;
    create table Emon as
    select   Depmun, count(*) as nem
    from     Estaciones
    group by Depmun;

    create table E19 as
    select Municipios.*, case when nem is null then 0
                             else nem 
                         end as nest
    from   CursoSAS.Municipios as Municipios left join Emon on (Municipios.Depmun = Emon.Depmun);
quit;

/*
Ejemplo 20
Existen municipios que no tienen ninguna estación de monitoreo climático? Cuantos? Cuales?

*/

proc sql;
    create table E20 as
    select   Municipios.*
    from     CursoSAS.Municipios as Municipios left join Emon on (Municipios.Depmun = Emon.Depmun)
    where    nem is NULL
    order by Depmun;

    create table E20a as
    select   Municipios.*
    from     CursoSAS.Municipios as Municipios
    where    Depmun not in (select distinct Depmun
                            from   Estaciones)
    order by Depmun;
quit;

*Usando tabla 19;
proc sql;
	create table illo as
    select   E19.*
    from     E19
    where    nest = 0;
quit;

*Usando emon;

proc sql;
    create table E20a as
    select   Municipios.*
    from     CursoSAS.Municipios as Municipios
    where    Depmun not in (select distinct Depmun
                            from  Emon)
    order by Depmun;
quit;

*Sin el distinct;
proc sql;
    create table E20a as
    select   Municipios.*
    from     CursoSAS.Municipios as Municipios
    where    Depmun not in (select Depmun
                            from  Emon)
    order by Depmun;
quit;

*Comparamos (todos son iguales);
proc compare base=E20 compare=E20a;
run;

/*
Ejemplo 21
*/

proc sql;
    create table E21 as
    select   Estaciones.*, Municipio, Departamento, Dep
    from     CursoSAS.Municipios as Municipios inner join Estaciones on (Municipios.Depmun=Estaciones.Depmun)
    where    elev <= 2000 
    order by depmun, codigo;

    create table E21a as
    select   Estaciones.*, Municipio, Departamento, Dep
    from     CursoSAS.Municipios as Municipios right join Estaciones on (Municipios.Depmun=Estaciones.Depmun)
    where    elev <= 2000 
    order by depmun, codigo;
quit;

proc compare base=E21 compare=E21a;
run;

/* 
Copia, guardandolo en la libreria
*/

libname CursoSAS "/home/u63344598/sasuser.v94/packages/";

data CursoSAS.Estaciones;
set Estaciones;
run;

proc datasets library=CursoSAS memtype=data; *informe de conjuntos de datos dentro de esa libreria;
run;

*Probando...;
proc sql;
    create table E21 as
    select   Estaciones.*, Municipio, Departamento, Dep
    from     CursoSAS.Municipios as Municipios inner join CursoSAS.Estaciones as Estaciones on (Municipios.Depmun=Estaciones.Depmun)
    where    elev <= 2000 
    order by depmun, codigo;

    create table E21a as
    select   Estaciones.*, Municipio, Departamento, Dep
    from     CursoSAS.Municipios as Municipios right join CursoSAS.Estaciones as Estaciones on (Municipios.Depmun=Estaciones.Depmun)
    where    elev <= 2000 
    order by depmun, codigo;
quit;