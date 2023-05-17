*proc export: Importación y exportación de datos;

/*Ejemplo 1:
Este código SAS se utiliza para exportar el conjunto de datos "stocks" 
de la biblioteca "sashelp" a un archivo de texto delimitado.

replace: sobreescribir
*/
proc export data=sashelp.stocks dbms=tab outfile="/home/u63344598/sasuser.v94/stocks.txt" replace;
    delimiter=",";
run;

*--------------------------------------------------------------------------------------;

/*Ejemplo 2:
Este programa de SAS se utiliza para leer los datos del archivo de texto 
"/home/u63344598/sasuser.v94/stocks.txt", especificando el formato de entrada 
y salida de las variables, y crear un nuevo conjunto de datos llamado "stockstxt".


informat: tipo de longitud de las variables (https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/leforinforref/n0verk17pchh4vn1akrrv0b5w3r0.htm).
	$10.:el tamaño maximo es de 10
format: especificar el formato de salida de las variables(https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/leforinforref/n0p2fmevfgj470n17h4k9f27qjag.htm).
input: leer los datos de entrada en SAS, da orden a las variables.

infile ->
	"firstobs=2" comienza a leer desde la segunda fila
	"dsd" es una opción de formato de entrada de datos que significa "delimiter sensitive data". Esto indica que los datos de entrada están separados por un delimitador específico (en este caso, una coma) y que los valores pueden incluir comillas dobles que se utilizan para encerrar los valores que contienen el propio delimitador. La opción "dsd" permite que SAS interprete correctamente los valores entre comillas dobles como una única variable, y los valores separados por comas como variables separadas. En resumen, "dsd" es una opción que se utiliza para leer datos en formato CSV (comma-separated values) que pueden contener comillas dobles para delimitar valores que contienen comas.
*/
data stockstxt;
    infile "/home/u63344598/sasuser.v94/stocks.txt" dsd delimiter="," firstobs=2;
    informat Stock $10. Date date. Open High Low Close Volume AdjClose comma.; *Se representan en formato numérico y que los separadores decimales son comas en lugar de puntos;
    format Date ddmmyy. Open High Low Close AdjClose dollar8.2 Volume comma10.0;
    input Stock Date Open High Low Close Volume AdjClose;
run;

/*
CONVERTIR UN VALOR COMO MONEDA A UNO PLENAMENTE NUMERICO
$1,000,000 -> 1000000

La primera línea indica que se está creando un nuevo conjunto de datos llamado "test".

La segunda línea define una variable llamada "value" y le asigna el valor "$1,000,000", que es un valor monetario en formato de cadena con comas.

La tercera línea utiliza la función INPUT para convertir el valor de la variable "value" en un valor numérico y lo almacena en una nueva variable llamada "value2". La especificación "comma10." en la función INPUT indica que se espera que los valores estén separados por comas y que se permiten hasta 10 dígitos antes del punto decimal.

La cuarta línea utiliza la función PUT para imprimir el valor de la variable "value2" en la ventana de registro SAS.

La última línea indica el final del conjunto de datos "test".
*/
data test;                     
   value='$1,000,000';                
   value2=input(value,comma10.);      
   put value2 ;                      
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 3:
*/
proc export data=sashelp.stocks dbms=dlm outfile="/home/u63344598/sasuser.v94/stocks.dat" replace;
    delimiter=";";
run;
*--------------------------------------------------------------------------------------;

/* Ejemplo 4:
*/
data stocksdat;
    infile "/home/u63344598/sasuser.v94/stocks.dat" dsd delimiter=";" firstobs=2;
    informat Stock $10. Date date. Open High Low Close Volume AdjClose comma.;
    format Date ddmmyy. Open High Low Close AdjClose dollar8.2 Volume comma10.0;
    input Stock Date Open High Low Close Volume AdjClose;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 5:
delimiter="09"x; Separado por tabulaciones
*/
proc export data=sashelp.shoes dbms=csv outfile="/home/u63344598/sasuser.v94/shoes.csv" replace;
    delimiter="09"x;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 6:
*/
data shoescsv;
    infile "/home/u63344598/sasuser.v94/shoes.csv" dsd delimiter="09"x firstobs=2;
    informat Region Product Subsidiary $25. Sales Inventory Return comma10.;
    format Sales Inventory Return dollar10.;
    input Region Product Subsidiary Stores Sales Inventory Return;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 7:
*/
proc export data=sashelp.shoes dbms=dlm outfile="/home/u63344598/sasuser.v94/shoes.dlm" replace;
    delimiter="&";
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 8:
*/
data shoesdlm;
    infile "/home/u63344598/sasuser.v94/shoes.dlm" dsd delimiter="&" firstobs=2;
    informat Region Product Subsidiary $25. Sales Inventory Return comma10.;
    format Sales Inventory Return dollar10.;
    input Region Product Subsidiary Stores Sales Inventory Return;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 9:
*/
proc export data=sashelp.shoes dbms=xlsx outfile="/home/u63344598/sasuser.v94/shoes.xlsx" replace;
    sheet="Zapatos";
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 10:
getnames=yes; La primera fila tiene el nombre de las variables
*/
proc import out=shoesxlsx dbms=xlsx datafile="/home/u63344598/sasuser.v94/shoes.xlsx" replace;
    getnames=yes;
    sheet="Zapatos";
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 11:
truncover: es una opción que se utiliza para indicar que SAS debe tratar las líneas incompletas o truncadas como líneas completas.
input Year 5. Month $6. Commercial 7. Passengers 6.; Datos de ancho fijo.

No funciono lo de la URL xd.
*/
filename donde url "https://users.stat.ufl.edu/~winner/data/ukcars.dat";

data ukcars;
    infile "/home/u63344598/sasuser.v94/ukcars.dat.txt" truncover;
    format Commercial Passengers comma10.;
    input Year 5. Month $6. Commercial 7. Passengers 6.;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 12:
*/

filename donde url "http://users.stat.ufl.edu/~winner/data/grunfeld.dat";
data grunfeld;
    infile donde truncover;
    format Investment Value Capital comma10.;
    input Firm $20. Year 5. Investment 8. Value 9. Capital 7.;
run;
*--------------------------------------------------------------------------------------;
*--------------------------------------------------------------------------------------;
*--------------------------------------------------------------------------------------;
*proc print;
*No creamos, ni modificamos. Solo imprimimos;
/* Ejemplo 1
noobs: se utiliza para excluir la numeración de las observaciones en la salida.
var: que variables del conjunto de datos quiero mostrar en el print (si quieres verlas todas no se coloca var).
*/
proc print data=sashelp.iris noobs;
    var Species SepalLength PetalWidth;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 2
where: aplicarle al procedimientos a una seccion especifica del conjunto de datos
*/
proc print data=sashelp.iris noobs;
    where Species in ("Setosa","Versicolor") and PetalLength < 40;
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 3
(firstobs=1 obs=10) mostrar de la fila 1 a la fila 10 segun lo encuentre en el conjunto de datos

*/
proc print data=sashelp.iris (firstobs=1 obs=10) noobs;
    var Species SepalLength SepalWidth PetalLength PetalWidth;
    where Species="Virginica";
run;

*--------------------------------------------------------------------------------------;

/* Ejemplo 4
*/
proc print data=sashelp.iris (firstobs=20 obs=30) noobs;
    where Species="Versicolor";
run;

proc print data=sashelp.iris noobs;
    var Species SepalLength SepalWidth PetalLength PetalWidth;
    where Species in ("Setosa","Versicolor") and PetalLength < 40;
run;

*--------------------------------------------------------------------------------------;
*--------------------------------------------------------------------------------------;
*--------------------------------------------------------------------------------------;

/* proc import
*/
proc import datafile="/home/u63344598/sasuser.v94/Municipios.xlsx" dbms=xlsx out=Municipios replace;
    getnames=yes;
run;

*'proc contents' ver el contenido de un conjunto de datos (como el 'str' de R);
*'varnum'orden de variables segun su creacion;

proc contents data=Municipios varnum;
run;

proc print data=Municipios (obs=10) noobs;
run;