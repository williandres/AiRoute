*proc sql;

/*Ejemplo 1*/

proc sql;
create table E1 as
    select Departamento, Dep, Depmun, Municipio, Superficie, Poblacion
    from CursoSAS.Municipios
    where Dep in ("05","17") and Poblacion > 20000
    order by Dep asc, Poblacion desc;
quit;

/*Ejemplo 2*/

proc sql;
    create table E2 as
    select    Departamento, Dep, Depmun, Municipio, Superficie, 
              Poblacion, case when denspobl < 30 then "Baja"
                              when denspobl > 85 then "Alta"
                              else "Mediana"
                         end as denspoblC
    from      CursoSAS.Municipios
    where     Dep not in ("15","68") and Superficie < 300
    order by  Dep asc, Poblacion desc;
quit;

/*Ejemplo 3*/

proc sql;
    select   Depmun, count(*) as repeticiones
    from     CursoSAS.Municipios
    group by Depmun
    having   repeticiones > 1;

    select count(*) as total_filas, count(distinct Depmun) as total_depmuns
    from   CursoSAS.Municipios;
quit;

/*Ejemplo 4*/

proc sql outobs=1;
    select   Departamento, Dep, cv(Superficie) as cvar
    from     CursoSAS.Municipios
    group by Departamento, Dep
    having   count(*) > 1
    order by cvar desc;
quit;  

/*Ejemplo 5*/

proc sql outobs=1;
    select   Departamento, Dep, cv(Superficie) as cvar
    from     CursoSAS.Municipios
    group by Departamento, Dep
    having   count(*) > 1
    order by cvar asc;
quit;    

/*Ejemplo 6*/

proc sql;
    create table E6 as
    select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpobl, 
             sum(Superficie) as totsuper, sum(Poblacion)/sum(Superficie) as denspobl,
             sum(Irural*Poblacion)/sum(Poblacion) as Irural,
             case when sum(Poblacion) > 1500000 then "Grande"
                  when sum(Poblacion) < 300000 then "Pequeño"
                  else "Mediano"
             end as totpoblC
    from     CursoSAS.Municipios
    group by Dep, Departamento
    order by totpobl desc;
quit;

%include "/home/u63344598/sasuser.v94/mismacros.sas";
%missings(E6);

/*Ejemplo 7 */
proc sql outobs=1;
    select   Region,  sum(Superficie) as sup
    from     CursoSAS.Municipios
    group by Region
    order by sup desc;
quit;

/*Ejemplo 8*/
proc sql;
    create table E8 as
    select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpobl,
             sum(Superficie) as totsuper, sum(Poblacion)/sum(Superficie) as denspobl
    from     CursoSAS.Municipios
    where    Irural > 60
    group by Dep, Departamento
    order by totpobl desc;
quit;  

/*Ejemplo 9*/

proc sql outobs=1;
    select   Region, count(distinct Dep) as Deps
    from     CursoSAS.Municipios
    group by Region
    order by Deps desc;
quit;

/*Ejemplo 10*/

proc sql;
    create table E10 as
    select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpobl,
             sum(Superficie) as totsuper, sum(Poblacion)/sum(Superficie) as denspobl
    from     CursoSAS.Municipios
    group by Dep, Departamento
    having   totpobl >= 650000 and totsuper >= 10000
    order by denspobl desc;
quit;  

/*Ejemplo 11*/

proc sql;
    create table E11 as
    select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpobl,
             sum(Superficie) as totsuper, sum(Poblacion)/sum(Superficie) as denspobl
    from     CursoSAS.Municipios
    where    Irural > 40
    group by Dep, Departamento
    having   totpobl >= 650000 and totsuper >= 10000
    order by denspobl desc;
quit;

/*Ejemplo 12

Existen dos o más municipios con el mismo nombre? Cuantos? Cuales? En qué departamentos están ubicados?
*/
proc sql;
    create table Repetidos as
    select   Municipio, count(*) as veces
    from     CursoSAS.Municipios
    group by Municipio
    having   count(*) > 1
    order by veces desc;

    create table E12 as
    select   Municipio, Departamento, Dep, Depmun, Region
    from     CursoSAS.Municipios
    where    Municipio in (select Municipio
                           from   Repetidos)
    order by Municipio asc, Departamento asc;
quit;

proc sql;
    create table E12a as
    select   Municipio, Region, Departamento, Dep, Depmun
    from     CursoSAS.Municipios
    where    Municipio in (select   Municipio
                           from     CursoSAS.Municipios
                           group by Municipio
                           having   count(*) > 1)
    order by Municipio asc, Region asc;
quit;

proc compare base=E12 compare=E12a;
run;

/*
Ejemplo 13
Existen dos o más municipios con el mismo nombre que hacen parte de la misma región? 
Cuantos? 
Cuales?

cats: concatenacion
*/

proc sql;
    create table Repetidos as
    select   Region, Municipio, count(*) as veces
    from     CursoSAS.Municipios
    group by Region, Municipio
    having   veces > 1
    order by veces desc;

    create table E13 as
    select   Municipio, Region, Departamento, Dep, Depmun
    from     CursoSAS.Municipios
    where    cats(Region,Municipio) in (select cats(Region,Municipio)
                                        from   Repetidos)
    order by Municipio asc, Region asc;
quit;


*---;

proc sql;
    create table E13a as
    select   Municipio, Region, Departamento, Dep, Depmun
    from     CursoSAS.Municipios
    where    cats(Region,Municipio) in (select   cats(Region,Municipio)
                                        from     CursoSAS.Municipios
                                        group by Region, Municipio
                                        having   count(*) > 1)
    order by Municipio asc, Region asc;
quit;

proc compare base=E13 compare=E13a;
run;

/*
Ejemplo 14
Conjunto de datos con los municipios cuyos nombres inician con "A" o terminan con "o", no importa si llevan tilde o no.
Municipios.* : es un alias que hace referencia al conjunto de datos

*/

proc sql;
    create table E14 as
    select Municipios.*
    from   CursoSAS.Municipios
    where  prxmatch('/(^(A|Á)|(o|ó)$)/',strip(Municipio));
quit; 

/*
Ejemplo 15
Conjunto de datos con los municipios cuyos nombres inician con "A" y terminan con "o", no importa si llevan tilde o no.

Municipios.* : es un alias que hace referencia al conjunto de datos
*/

proc sql;
    create table E15 as
    select Municipios.*
    from   CursoSAS.Municipios
    where  prxmatch('/(^(A|Á).*(o|ó)$)/',strip(Municipio));
quit;

/*
Ejemplo 16
Conjunto de datos con los municipios cuyo nombre tiene a la letra "e" en las posiciones 2 y 4, no importa si llevan tilde o no.


*/
proc sql;
    create table E16 as
    select Dep, Departamento, Municipio, Depmun
    from   CursoSAS.Municipios
    where  prxmatch('/^.{1}(e|é).{1}(e|é)/',strip(lowcase(Municipio)));
quit;

/*
Ejemplo 17
Conjunto de datos con los municipios cuyos nombres constan de más de una palabra.

*/
proc sql;
    create table E17 as
    select Dep, Departamento, Municipio, Depmun
    from   CursoSAS.Municipios
    where  prxmatch('/ /',strip(Municipio));
quit;    