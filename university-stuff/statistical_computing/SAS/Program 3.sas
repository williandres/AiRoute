*Unión vertical de conjuntos de datos;

/*Creamos dos datasets

*/
data ds1;
input age name$;
cards;
32 Messi
35 Cr7
59 Maradona
79 Pele
;
run;

proc print data=ds1 noobs;
run;

data ds2;
input year name$;
cards;
1947 Cruyf
1976 Ronaldo
1972 Zidane
;
run;

proc print data=ds2 noobs;
run;

*----------|||||------------;

/*
Union vertical, añade filas
*/
data uv1;
set ds1 ds2;
run;

proc print data=uv1 noobs;
run;

data uv2;
set ds2 ds1;
run;

proc print data=uv2 noobs;
run;

*Unión horizontal de conjuntos de datos;

*----------|||||------------;

/*
Union horizontal, añade filas
*/

data uh1;
set ds1;
set ds2;
run;

proc print data=uh1 noobs;
run;

data uh2;
set ds2;
set ds1;
run;

proc print data=uh2 noobs;
run;

*-------------------------------------------------------;
/*
	Ejemplo 13
*/



data prdsal2;
set sashelp.prdsal2;
    if _n_ > 10 and _n_ <= 20; *filas de 11 a la 20;
    rename monyr=date;
run;

data prdsal3;
set sashelp.prdsal3;
    if _n_ > 110 and _n_ <= 120;
run;

data prdsal;
set prdsal2 prdsal3;
run;

proc print data=prdsal noobs;
run;

*-------------------------------------------------------;
/*
	Ejemplo 14
	
	Renombrar para cuando se genere la union horizontal no se sobreescriban las variables
*/

data nvst;
set sashelp.nvst1 (rename=(amount=amount1));
set sashelp.nvst2 (rename=(amount=amount2));
set sashelp.nvst3 (rename=(amount=amount3));
set sashelp.nvst4 (rename=(amount=amount4));
set sashelp.nvst5 (rename=(amount=amount5));
run;


proc print data=nvst noobs;
run;

proc contents data=nvst;
run;


data nvstb;
set sashelp.nvst1 (rename=(amount=amount1)) sashelp.nvst2 (rename=(amount=amount2)) sashelp.nvst3 (rename=(amount=amount3)) set sashelp.nvst4 (rename=(amount=amount4)) sashelp.nvst5 (rename=(amount=amount5));
run;