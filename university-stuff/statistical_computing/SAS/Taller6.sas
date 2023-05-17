/*Taller 6 SAS*/
/*Willian Andrés Cárdenas Sandoval
Diego Alejandro Robayo Molina
Andres Felipe Rache Espitia
Andrea Catalina Garcia Montoya*/

/***************************OFRECIDOS ESTADÍSTICA*********************************************************/


proc import datafile="/home/u63343323/Curso/ofrecidos.xlsx" out=ofrecidos dbms=xlsx replace;
    getnames=yes;
run;


proc import datafile="/home/u63343323/Curso/cursos.txt" out=cursos dbms=dlm replace;
    delimiter=';'; 
    getnames=yes;
run;


proc import datafile="/home/u63343323/Curso/docentes.csv" out=docentes dbms=csv replace;
    getnames=yes;
run;


proc sql;
    create table ofrecidos2 as
    select ofrecidos.*, nombrecurso
    from ofrecidos left join cursos on cursos.codigocurso = ofrecidos.CodigoCurso;
quit;


proc sql;
    create table ofrecidos3 as
    select ofrecidos2.*, nombredocente
    from ofrecidos2 
    left join docentes
    on ofrecidos2.iddocente = docentes.iddocente;
quit;

proc sql;
    create table Cursos_Ofrecidos as
    select   ofrecidos.*, cursos.NombreCurso
    from     ofrecidos inner join cursos on (ofrecidos.CodigoCurso=cursos.CodigoCurso);

    create table Cursos_Ofrecidos as
    select   Cursos_Ofrecidos.*, Docentes.NombreDocente, Docentes.CorreoElectronico
    from     Cursos_Ofrecidos left join Docentes on (Cursos_Ofrecidos.IdDocente=Docentes.IdDocente);

quit;

/*
1.

En cual semestre del periodo comprendido entre 2014-I y 2016-II hubo más cupos de "Probabilidad y Estadística Fundamental"?

Repuesta: El semestre 2015-II con 1168 cupos

*/


proc sql;
    create table E1 as
    select   semestre,NombreCurso, sum(CuposN) as n_cupos
    from     Cursos_Ofrecidos
    where NombreCurso="Probabilidad y Estadística Fundamental"
    and input(substr(semestre, 1, 4), 4.) >= 2014
    and input(substr(semestre, 1, 4), 4.) <= 2016
    group by semestre, NombreCurso
    order by n_cupos desc;

quit;

proc print data=E1;
run;

/*
2.

En cual semestre del periodo comprendido entre 2014-I y 2016-II hubo más grupos de "Bioestadística Fundamental"?

Repuesta: El semestre 2014-II con 16 grupos

*/

proc sql;
    create table E2 as
    select   semestre,NombreCurso, count(*) as n_grupos
    from     Cursos_Ofrecidos
    where NombreCurso="Bioestadística Fundamental"
    and input(substr(semestre, 1, 4), 4.) >= 2014
    and input(substr(semestre, 1, 4), 4.) <= 2016
    group by semestre, NombreCurso
    order by n_grupos desc;

quit;

proc print data=E2;
run;

/*
3.

En cual semestre del periodo comprendido entre 2014-I y 2016-II hubo mayor 
homogeneidad (de acuerdo al coeficiente de variación) entre los grupos de 
"Estadística Social Fundamental" en relación al número de cupos ofrecidos?

Repuesta: El semestre 2016-I con un coeficiente de variacion 18.8082

*/

proc sql;
    create table E3 as
    select   semestre,NombreCurso, cv(CuposN) as cv_cupos
    from     Cursos_Ofrecidos
    where NombreCurso="Estadística Social Fundamental"
    and input(substr(semestre, 1, 4), 4.) >= 2014
    and input(substr(semestre, 1, 4), 4.) <= 2016
    group by semestre, NombreCurso
    order by cv_cupos asc;

quit;

proc print data=E3;
run;

/*
4.

Cuales cursos del pregrado en Estadística (especifique código y nombre) 
de la agrupación "Complementación" se ofrecieron solo un semestre en el 
periodo comprendido entre 2014-I y 2016-II?

Repuesta: 
-2016334	Análisis de Datos Longitudinales
-2016340	Series de Tiempo Multivariadas

*/

proc sql;
    create table E4 as
    select   Cursos_Ofrecidos.CodigoCurso,Cursos_Ofrecidos.NombreCurso,
    Cursos_Ofrecidos.Semestre, Cursos_Ofrecidos.NombreDocente, 
    Cursos_Ofrecidos.Programa,Cursos_Ofrecidos.Agrupacion,
    count(semestre) as Curso_Semestre
    from     Cursos_Ofrecidos
    where Programa="Pregrado"
    and Agrupacion="Complementación"
    and input(substr(semestre, 1, 4), 4.) >= 2014
    and input(substr(semestre, 1, 4), 4.) <= 2016
    group by NombreCurso
    having Curso_Semestre = 1
    order by Curso_Semestre,NombreCurso;
quit;

proc print data=E4;
run;

/*5 PUNTO*/

proc sql;
       select CodigoCurso, NombreCurso
       from ofrecidos3
       where Programa = 'Pregrado' and Agrupacion='Nucleo'
       group by CodigoCurso, NombreCurso
       having count(distinct Semestre) = 6;
quit;

/*6 PUNTO*/

proc sql;
       select IdDocente, NombreDocente
       from ofrecidos3
       where IdDocente is not NULL
       group by IdDocente, NombreDocente
       having count(distinct Programa) = 1;
quit;


/*7 PUNTO*/

proc sql;
       select IdDocente, NombreDocente
       from ofrecidos3
       where IdDocente is not NULL
       group by IdDocente, NombreDocente
       having count(distinct Programa) = 4;
quit;

/*8 PUNTO*/

proc sql;
       select IdDocente, NombreDocente, count(distinct CodigoCurso) as cursosdif
       from ofrecidos3
       where Programa in ('Pregrado','Especialización','Maestría','Doctorado')
       group by IdDocente, NombreDocente
       order by cursosdif;
quit;

/*9 PUNTO*/

proc freq data=ofrecidos3;
    where Programa="Pregrado";
    table Agrupacion*Semestre / nopercent norow;
run;

proc freq data=ofrecidos3;
    where Programa="Pregrado";
    table Agrupacion*Semestre / nopercent norow;
    weight CuposN;
run;

/*10 PUNTO*/

data ofrecidos3;
    set ofrecidos3;
     if substrn(Dia,1,2)='LU' then LUNES='Si';
     else LUNES='No';
run;

proc freq data=ofrecidos3;
    where Programa="Especialización" or Programa="Maestría" or Programa="Doctorado";
    table Lunes*Semestre / nopercent norow;
    weight CuposN;
run;

/******************************CASOS COVID 19 **************************************/

proc import out = covid1 dbms =tab datafile ="/home/u63341218/computacion/Taller 1/covid2020.tsv"
replace;
getnames=yes;
delimiter="09"x;
run;

proc import out =covid2 dbms=tab datafile="/home/u63341218/computacion/Taller 1/covid2021.tsv" replace;
getnames=yes;
delimiter="09"x;
run;

data pop; infile "/home/u63341218/computacion/Taller 1/pop.tsv" dsd delimiter ="09"x firstobs = 2 ;
informat iso_code $5. continent location $20.;
input iso_code continent location populaton;
run;

data covid;
set covid1 covid2;
where iso_code in ('ARG' ,'BOL','BRA','CHL','COL','ECU','GUY','PRY','PER','SUR','URY','VEN');
run;

proc sort data =covid;
by iso_code date;
run;

/*1. Cual fue el país (iso_code y location) de América del Sur con el mayor número de días, consecutivos o no, sin nuevos casos de Covid-19 entre el 1 de junio de 2020 y el 31 de mayo de 2021*/

data covid_nuevos;
set covid;
by iso_code;
if first.iso_code then dias_sin_nuevos =0;
else if new_cases>0 then dias_sin_nuevos =0;
else dias_sin_nuevos +1;
run;

proc summary data =covid_nuevos;
by iso_code;
var dias_sin_nuevos;
output out =covid_max_dias_sin_nuevos(drop=_type_ _freq_)max(dias_sin_nuevos)=max_dias_sin_nuevos;
run;

proc sort data = covid_max_dias_sin_nuevos;
by descending max_dias_sin_nuevos ;
run;
/* Perú fue el país con el mayor número de días sin nuevos casos de Covid19 con 64*/


/* 2. Cual fue el día (date) de 2021 con mayor número de paises de América del Sur sin nuevos casos de Covid-19?*/

data covid ;
set covid1 covid2;
run;

data covid_sa;
set covid;
where iso_code in ('ARG','BOL','BRA','CHL','COL','ECU','GUF','GUY','PRY','PER','SUR','URY','VEN')and new_cases=0;
run;

proc sql;
create table covid_sa_counts as select date ,
count (*) as num_countries from covid_sa
group by date order by num_countries desc ;
quit;

/*fue el 23/07/2021 */


/*3. Cual fue el país (iso_code y location) de Africa con el mayor número de días, consecutivos o no, 
sin nuevas muertes*/

proc sql OUTOBS=1;
select iso_code, location,  count(*) as sinmuertes
from covid3
where new_deaths=0 and continent='Africa' and date >= '01MAY2020'd and date<= '30APR2021'd
group by location
order by sinmuertes desc;
quit;

/* Tanzania*/

/* 4. Cual fue el día (date) de 2020 con mayor número de paises de Africa sin nuevas muertes por Covid-19?*/

proc sql OUTOBS=1;
select iso_code, location,  count(*) as sinmuertes
from covid3
where new_deaths=0 and continent='Africa' and date >= '01MAY2020'd and date<= '30APR2021'd
group by location
order by sinmuertes desc;
quit;

 /*21/04/2020*/

/* 5. Cual fue el país (iso_code y location) de Europa con el mayor número de casos de Covid-19 por 100 mil habitantes (
 durante 2021?*/


proc sql OUTOBS=1;
select iso_code, location,  100000*Sum(new_cases)/avg(population) as ti
from covid3
where continent='Europe' and date >= '01JAN2021'd
group by iso_code, location
order by ti desc;
quit;

/*Czechia*/

/*7. Cual fue el país (iso_code y location) de Asia con el mayor número de días consecutivos sin nuevos casos de Covid-19 en 2020?*/

data covid ;
merge covid1 covid2 ;
by iso_code date ;
run ;

data covid_pop ;
merge covid pop ;
by iso_code ;
run;

data africa ;
set covid_pop ;
where continent='Asia';
