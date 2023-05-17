/*
BASES
https://sas2022.netlify.app/

Cada declaración debe terminar con un punto y coma (;).
Los nombres de las variables pueden tener un máximo de 32 caracteres y deben comenzar con una letra o un guión bajo (_).
Los nombres de las variables deben ser únicos dentro de un conjunto de datos.
Las palabras clave, como "if", "else", "proc", "data", deben estar en minúsculas.
Los comentarios en el código comienzan con un asterisco (*) en la primera columna de la línea.
Las comillas dobles ("") se utilizan para especificar valores de caracteres y las comillas simples ('') se utilizan para especificar valores numéricos.
Los operadores matemáticos (+, -, *, /, **) y los operadores lógicos (&, |, ^, ~) se utilizan para realizar cálculos y comparaciones.
Las funciones de SAS se escriben en mayúscula y tienen la sintaxis de una función, seguida de paréntesis que pueden contener argumentos separados por comas.
Las sentencias de DATA se utilizan para crear y manipular conjuntos de datos, mientras que las sentencias de PROC se utilizan para analizar y generar informes a partir de los datos.
La identacion no significa nada.
*/
/*
Comandos: un comando en SAS comienza con una palabra clave reservada,
como "data", "proc" o "run", seguida de un conjunto de opciones y argumentos
que se aplican al comando. Por ejemplo, la sintaxis básica de un comando "data"
se parece a esto:

*/
data nombre_dataset;
	conjunto de instrucciones;
run;

/*
Conjunto de datos: un conjunto de datos en SAS es una tabla que contiene
una o más columnas de datos.
Los conjuntos de datos se pueden crear a través de la lectura de datos existentes,
la creación de nuevos datos o la combinación de conjuntos de datos existentes.
La sintaxis básica para crear un conjunto de datos es la siguiente:
*/
data nombre_dataset;
	conjunto de instrucciones;
run;

/*
Procedimientos: los procedimientos en SAS se utilizan para analizar,
resumir y visualizar los datos. Los procedimientos se inician con
la palabra clave "proc" y terminan con la palabra clave "run".
La sintaxis básica de un procedimiento se ve así:
*/
proc nombre_procedimiento opciones;
	conjunto de instrucciones;
run;

/*
Variables: una variable en SAS es un objeto que almacena un valor o una
serie de valores. Las variables se pueden definir utilizando
una declaración "data" y se pueden modificar y analizar utilizando procedimientos.
La sintaxis básica para definir variables en SAS es la siguiente:
*/
data nombre_dataset;
	input variable_1 variable_2 ... variable_n;
	conjunto de instrucciones;
run;