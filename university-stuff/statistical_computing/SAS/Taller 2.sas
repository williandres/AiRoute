/*
Computacion estadistica
UNAL 2023-1

Taller 2

Willian Andrés Cárdenas Sandoval
Diego Alejandro Robayo Molina
Andres Felipe Rache Espitia
Andrea Catalina Garcia Montoya
*/

*Ejercicio: Cursos ofrecidos por el departamento de Estadística;

proc import datafile="/home/u63344598/sasuser.v94/ofrecidos.xlsx" dbms=xlsx out=Ofrecidos replace;
    getnames=yes;
run;

proc import datafile="/home/u63344598/sasuser.v94/cursos.txt" dbms=dlm out=Cursos replace;
    getnames=yes;
    delimiter=';';
run;

proc import datafile="/home/u63344598/sasuser.v94/docentes.csv" dbms=csv out=Docentes replace;
    getnames=yes;
run;

proc sql;
    create table Cursos_Ofrecidos as
    select   Ofrecidos.*, Cursos.NombreCurso
    from     Ofrecidos inner join Cursos on (Ofrecidos.CodigoCurso=Cursos.CodigoCurso);

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