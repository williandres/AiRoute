/*
Computacion estadistica
UNAL 2023-1

Parcial

Willian Andrés Cárdenas Sandoval
*/

proc import out=Municipios dbms=xlsx datafile="/home/u63344598/sasuser.v94/Brasil.xlsx" replace;
    getnames=yes;
    sheet="Municipios";
run;

proc import out=Estados dbms=xlsx datafile="/home/u63344598/sasuser.v94/Brasil.xlsx" replace;
    getnames=yes;
    sheet="Estados";
run;

proc import out=Costeros dbms=xlsx datafile="/home/u63344598/sasuser.v94/Brasil.xlsx" replace;
    getnames=yes;
    sheet="Costeros";
run;

/*Left join Municipios Estados*/
proc sql;
create table MunEs as
    select Municipios.*, Estados.NOMESTAD,Estados.REGIAO 
    from Municipios left join Estados on (Municipios.CODESTAD = Estados.CODESTAD);
quit;

/*
Punto 1

R: Região Norte con 450

*/
proc sql;
create table P1 as
    select REGIAO, count(*) as numMun 
    from MunEs
    group by REGIAO
	order by numMun; 
quit;

/*
Punto 2

R: Região Sudeste con 89632912

*/

proc sql;
create table P2 as
    select REGIAO, sum(POB) as TotPob 
    from MunEs
    group by REGIAO
	order by TotPob desc; 
quit;

/*
Punto 3

R: Região Sul con 563650.944

*/

proc sql;
create table P3 as
    select REGIAO, sum(SUP) as TotSup 
    from MunEs
    group by REGIAO
	order by TotSup; 
quit;

/*
Punto 4

R: Pará(15) con 129795.031

*/

*Municipios Costeros;
proc sql;
create table MunCos as
    select MunEs.* 
    from MunEs inner join Costeros on (MunEs.CODMUNIC = Costeros.CODMUNIC);
quit;

proc sql;
create table P4 as
    select CODESTAD, NOMESTAD, sum(SUP) as TotSup  
    from MunCos
    group by CODESTAD, NOMESTAD
    order by TotSup desc;
quit;

/*
Punto 5

R: Rio de Janeiro con 14489416

*/
proc sql;
create table P5 as
    select CODESTAD, NOMESTAD, sum(POB) as TotPob  
    from MunCos
    group by CODESTAD, NOMESTAD
    order by TotPob desc;
quit;

/*
Punto 6

R: Pernambuco con 1051.2547335

*/


proc sql;
create table P6 as
    select CODESTAD, NOMESTAD, sum(POB)/sum(SUP) as denspobl
    from MunCos
    group by CODESTAD, NOMESTAD
    order by denspobl desc;
quit;

/*
Punto 7

R:Amapá con 0.5962666221

Superficie del estado de los municipios costeros/Superficie del estado
*/
proc sql;
create table SupEs as
	select CODESTAD, NOMESTAD, sum(SUP) as TotSupES
	from MunEs
	GROUP BY CODESTAD, NOMESTAD;
quit;

proc sql;
create table P7 as
	select  SupEs.*,P4.TotSup, P4.TotSup / SupEs.TotSupES as Proporcion
	from SupEs left join P4 on (SupEs.CODESTAD = P4.CODESTAD)
	order by Proporcion desc;
quit;


/*
Punto 8

R:Amapá con 0.8785546705


*/
proc sql;
create table PobEs as
	select CODESTAD, NOMESTAD, sum(POB) as TotPOBES
	from MunEs
	GROUP BY CODESTAD, NOMESTAD;
quit;

proc sql;
create table P8 as
	select  PobEs.*,P5.TotPob, P5.TotPob / PobEs.TotPOBES as Proporcion
	from PobEs left join P5 on (PobEs.CODESTAD = P5.CODESTAD)
	order by Proporcion desc;
quit;



/*
Punto 9

R:Amazonas con 1559255.883

*/
proc sql;
create table P9 as
    select CODESTAD, NOMESTAD, sum(SUP) as TotSup 
    from MunEs
    where CODESTAD not in (select CODESTAD from MunCos)
    group by CODESTAD, NOMESTAD
    order by TotSup desc; 
quit;

/*
Punto 10

R:Minas Gerais con 21411923


*/
proc sql;
create table P10 as
    select CODESTAD, NOMESTAD, sum(POB) as TotPob 
    from MunEs
    where CODESTAD not in (select CODESTAD from MunCos)
    group by CODESTAD, NOMESTAD
    order by TotPob desc; 
quit;

/*
Punto 11

*/
proc sql;
    create table cons as
    select MunEs.*
    from   MunEs
    where  not prxmatch('/^(A|Á)(E|É)(O|Ó)(Í|Í)(U|Ú)|.*(A|Á)(E|É)(O|Ó)(Í|Í)(U|Ú)$/',compress(compbl(lowcase(propcase(strip(NOMMUNIC))))) and 
    substr(compress(compbl(lowcase(propcase(strip(NOMMUNIC)))))strip(NOMMUNIC), 1, 1) = substr(compress(compbl(lowcase(propcase(strip(NOMMUNIC))))), length(compress(compbl(lowcase(propcase(strip(NOMMUNIC)))))), 1);
quit;


