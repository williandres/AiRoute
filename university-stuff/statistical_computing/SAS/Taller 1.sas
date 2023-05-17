/*
Computacion estadistica
UNAL 2023-1

Taller 1
Willian Andrés Cárdenas Sandoval
Diego Alejandro Robayo Molina
*/

*Ejercicio: sashelp.cars;

proc sql;
create table cars as
select *
from sashelp.cars;
quit;
data cars;
set cars;
est = 16850 / (Horsepower**0.1278 * weight**0.7081);
run;
data cars;
set cars;
sobre = abs(est - MPG_Highway);
run;
/*1. Honda Insight 2dr
2. Toyota Prius 4dr
3. Honda civic
4. Volskwagen Jetta
5. Chevrolet Tracker */
data cars;
set cars;
sub = abs(MPG_Highway-est);
run;
/*1. BMW 325
2. Ford Thunderbird
3. Buick Rainer
4. Hyundai Elantra GLS
5. Hyundai Elantra GT */



/*2. punto*/
proc sql;
create table cars as
select *
from sashelp.cars;
quit;

data hyundai_cars;
set sashelp.cars;
where Make = "Hyundai" and prxmatch('/^(Accent.*|Elantra.*|Sonata.*)/', Model);
run;

data hyundai_cars_weight;
set hyundai_cars;
if Weight > 1200 then weight_category = "High";
else weight_category = "Low";
run;
data final_hyundai_cars;
set hyundai_cars_weight (keep=Make Model Origin Weight Horsepower MPG_City weight_category);
run;
proc print data=final_hyundai_cars;
run;





*Ejercicio sashelp.baseball;


/*
1.
Construya un conjunto de datos con los jugadores que no pertenecen ni al equipo de New York ni al equipo de Los Angeles. 
Cree una variable para el apellido y otra para el nombre de los jugadores.
*/
data baseball;
   set sashelp.baseball;
run;

data baseball_filtered;
   set baseball;
   where team not in ('New York', 'Los Angeles');
run;

data baseball_filtered;
   set baseball_filtered;
   nombre = substr(strip(name), index(name, ',') + 1);
   apellido = substr(strip(name), 1, index(name, ',') - 1);
   drop name;
run;

/*
2.
Existen beisbolistas cuyos nombres y apellidos inician con vocales?

R./ SI, 2 beisbolistas
*/

data Vocales;
set baseball_filtered;
    where  substrn(strip(lowcase(nombre)),1,1) in ("a","á","e","é","i","í","o","ó","u","ú")
           and substrn(strip(lowcase(apellido)),1,1) in ("a","á","e","é","i","í","o","ó","u","ú");
    keep nombre apellido team;
run;

/*
3.
Existen beisbolistas cuyos nombres y apellidos inician con la misma vocal?

R./ SI, 2 beisbolistas
*/

data Vocales2;
set Vocales;
    where  substrn(strip(lowcase(nombre)),1,1) = substrn(strip(lowcase(apellido)),1,1);
run;

/*
4.
Existen beisbolistas cuyos nombres y apellidos inician con la misma consonante?

R./ SI, 22 besisbolistas
*/
data Consonantes;
set baseball_filtered;
    where  substrn(strip(lowcase(nombre)),1,1) not in ("a","á","e","é","i","í","o","ó","u","ú")
           and substrn(strip(lowcase(apellido)),1,1) = substrn(strip(lowcase(nombre)),1,1);
    keep nombre apellido team;
run;

/*
5.
Cuales son los 5 jardineros izquieros (LF) con los salarios más altos en la liga nacional?

R./ 
- Jose	Cruz
- Gary	Matthews
- Gary	Redus
- Eric	Davis
- John	Kruk
*/

data salarios_lf;
set baseball_filtered;
	where strip(lowcase(position)) = "lf" and strip(lowcase(league)) = "national" ;
	keep nombre apellido team salary league division;
run;

proc sort data=salarios_lf (obs=5);
    by descending salary ;
run;

/*
6.
Cuales son los 5 beisbolistas con los apellidos más cortos en la liga americana?

R./ 
- Rudy	Law
- Carlton	Fisk
- Donnie	Hill
- Fred	Lynn
- George	Bell
*/

data apellido_corto;
set baseball_filtered;
	largo = length(strip(apellido));
	where strip(lowcase(league)) = "american";
	keep nombre apellido team salary league division largo;
run;

proc sort data=apellido_corto;
    by largo;
run;

/*
7.
Cuales son los 5 paracortos (SS) con el mayor número de nOuts en la división oeste?

R./ 
- Alfredo	Griffin
- Ozzie	Guillen
- Jose	Uribe
- Dick	Schofield
- Greg	Gagne
*/

data out_ss;
set baseball_filtered;
	where strip(lowcase(division)) = "west" and strip(lowcase(position)) = "ss" ;
	keep nombre apellido team salary league division nOuts;
run;

proc sort data=out_ss  (obs=5);
    by descending nOuts;
run;

/*
8.
Cuales son los 5 beisbolistas con el menor número de nError en Chicago?

R./ 
- Jerry	Hairston
- Ron	Kittle
- Bobby	Bonilla
- Bob	Dernier
- Chris	Speier
*/
data chicago_nerror;
set baseball_filtered;
	where strip(lowcase(team)) = "chicago";
	keep nombre apellido team salary league division nError;
run;

proc sort data=chicago_nerror;
    by nError;
run;

/*
9.
Existen variables con más de 5% de valores perdidos (missings)? En caso afirmativo, elimínelas.

R./ Si,existen 2 variables cada una con un 18% de valores perdidos, esas variables son Salary y logSalary 
*/ 
%include "/home/u63344598/sasuser.v94/mismacros.sas";
%missings(baseball_filtered);

data baseball_filtered;
set baseball_filtered;
	drop salary logsalary;
run;

proc print data=baseball_filtered;

*Ejercicio sashelp.heart;

data heart;
   set sashelp.heart;
run;

/*1 punto

El 41% del personas con sobrepeso fallecio
*/
proc freq data=heart order=freq;
	where weight_status = "Overweight";
    table weight_Status*status;
run;