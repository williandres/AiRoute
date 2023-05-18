/*
https://sas2022.netlify.app/


*/


/*
EXPORTAR
*/
proc export data=datos* dbms=tab outfile="/home/u63344598/sasuser.v94/archivo*" replace;
    delimiter=",";
run;


/*
IMPORTAR
*/
*EXCEL;
proc import out=NOMBRE_DF dbms=xlsx datafile="/home/u63344598/sasuser.v94/archivo*" replace;
    getnames=yes;
    sheet="nombre_de_hoja";
run;
/*
DLM
firstobs: Indica el número de observación desde donde se empezará a leer el archivo.
informat: Especifica los formatos de entrada de los datos.
format: Define los formatos de visualización de los datos.
input: Indica las variables que se van a leer desde el archivo de entrada.
*/
data nombre_dataset;
    infile "/home/u63344598/sasuser.v94/archivo*" dsd delimiter="&" firstobs=2;
    informat variable1 variable2 variable3 $25. variable4 variable5 variable6 comma10.;
    format variable4 variable5 variable6 dollar10.;
    input variable1 variable2 variable3 variable4 variable5 variable6;
run;


/*
MISCELANEOS
*/
*Breve descripcion de un df;
proc contents data=Municipios varnum; *varnum: únicamente el número de variables sin mostrar los detalles adicionales de cada variable;
run;
*Imprimir;
proc print data=nombre_del_conjunto_de_datos noobs;
    var variable1 variable2 variable3; *Opcional;
run;
*Imprimir con condiciones;
proc print data=nombre_del_conjunto_de_datos (obs=10) noobs;
    var variable1 variable2 variable3 variable4 variable5;
    where variable5="valor_condicion";
run;

/*
Missings
*/
%include "/home/u63344598/sasuser.v94/mismacros.sas";
%missings(DataSet);


/*
LIMPIEZA
Se eliminan caracteres especiales.

Se eliminan espacios al inicio y al final.

Se reemplazan espacios múltiples por sencillos.

Se escriben en letras minúsculas excepto en la inicial de cada palabra.
*/

data nombre_del_conjunto_de_datos;
set nombre_del_conjunto_de_datos;
    variable_nueva1 = lowcase(variable_existente);
    variable_nueva1 = compress(variable_nueva1, "abcdefghijklmnopqrstuvwxyzáéíóúüñ ", "k");
    variable_nueva1 = strip(variable_nueva1);
    variable_nueva1 = compbl(variable_nueva1);
    variable_nueva1 = propcase(variable_nueva1);
run;


data nombre_del_conjunto_de_datos;
set nombre_del_conjunto_de_datos;
    variable_existente = variable_nueva1;
    drop variable_nueva1;
run;

/*
CONDICIONALES
IF ELSE

*/

data nombre_del_conjunto_de_datos;
set nombre_del_conjunto_de_datos;
    variable_nueva = variable_existente1 / variable_existente2;
    if condicion then variable_nueva2 = "valor_verdadero";
    else variable_nueva2 = "valor_falso";
run;

/*
EXPRESIONES REGULARES
*/
data nombre_del_conjunto_de_datos_salida;
set nombre_del_conjunto_de_datos_entrada;
    where prxmatch('/(^a.*a$)|(^e.*e$)|(^i.*i$)|(^o.*o$)|(^u.*u$)/', strip(variable_existente2));
    keep variable_existente1 variable_existente2 variable_existente3 variable_existente4;
run;

/*
SUBSTR
*/
data nombre_del_conjunto_de_datos_salida;
set nombre_del_conjunto_de_datos_entrada;
    where substr(strip(variable_existente2), 1, 1) = substr(strip(variable_existente2), length, 1)
          and substr(strip(variable_existente2), 1, 1) in ("a", "e", "i", "o", "u");
    keep variable_existente1 variable_existente2 variable_existente3 variable_existente4;
run;


/*
CREAR NUEVAS VARIABLES
*/

data nombre_del_conjunto_de_datos;
set nombre_del_conjunto_de_datos;
    variable_existente = variable_nueva1;
run;

/*
UNION VERTICAL
*/

data nombre_del_conjunto_de_datos_salida;
set nombre_del_conjunto_de_datos_entrada1 nombre_del_conjunto_de_datos_entrada2;
run;

/*
UNION HORIZONTAL
*/

data nombre_del_conjunto_de_datos_salida;
set nombre_del_conjunto_de_datos2;
set nombre_del_conjunto_de_datos1;
run;

/*
FILAS ESPECIFICAS	
*/

data nombre_del_conjunto_de_datos_salida;
set nombre_del_conjunto_de_datos1;
    if _n_ <= 10 or _n_ > 20 then delete;
run;

/*
ORDENANDO
Region (alfabéticamente), 
Dep (alfanuméricamente), 
Zona (alfabéticamente) y 
Poblacion (de mayor a menor).
*/

proc sort data=CursoSAS.Municipios;
    by Region Dep Zona descending Poblacion;
run;


/*
SQL
*/

/*Consulta normal*/
proc sql;
create table nombre_tabla_salida as
    select variable1, variable2, variable3, variable4, variable5, variable6
    from nombre_del_conjunto_de_datos
    where variable2 in ("valor1", "valor2") and variable6 > 20000
    order by variable2 asc, variable6 desc;
quit;

/*Creando una nueva variable en el select*/
proc sql;
create table nombre_tabla_salida as
    select variable1, variable2, variable3, variable4, variable5, variable6,
           case when denspobl < 30 then "Baja"
                when denspobl > 85 then "Alta"
                else "Mediana"
           end as variable_nueva
    from nombre_del_conjunto_de_datos
    where variable2 not in ("valor1", "valor2") and variable5 < 300
    order by variable2 asc, variable6 desc;
quit;

/*Usando:
GROUP BY: Es una cláusula utilizada en consultas SQL para agrupar filas 
con base en una o más columnas. Permite realizar 
cálculos y resúmenes de datos por grupos. 
Se utiliza junto con funciones de agregación como SUM, COUNT, AVG, etc.

HAVING: Es una cláusula utilizada en consultas SQL que se aplica 
después de la cláusula GROUP BY para filtrar grupos específicos 
de resultados. Se utiliza para establecer condiciones en los grupos 
resultantes, similar a la cláusula WHERE, pero actúa a nivel de grupo en 
lugar de a nivel de fila.

COUNT(*): Es una función de agregación en SQL que cuenta el número total 
de filas en un conjunto de datos o en un grupo. 
Se utiliza para contar todas las filas, incluyendo las que contienen 
valores nulos.

DISTINCT: Es una palabra clave utilizada en consultas SQL para seleccionar 
valores únicos de una columna. Elimina duplicados y muestra solo los 
valores distintos en el resultado de la consulta. 
Se utiliza con la cláusula SELECT para obtener valores únicos en lugar 
de todos los valores repetidos.
*/

proc sql;
    select   variable1, count(*) as variable2
    from     nombre_del_conjunto_de_datos
    group by variable1
    having   variable2 > 1;

    select count(*) as total_filas, count(distinct variable1) as total_valores_unicos
    from   nombre_del_conjunto_de_datos;
quit;