proc import datafile="/home/u63344598/sasuser.v94/Municipios.xlsx" dbms=xlsx out=Municipios replace;
    getnames=yes;
run;

*'proc contents' ver el contenido de un conjunto de datos (como el 'str' de R);
*'varnum'orden de variables segun su creacion;

proc contents data=Municipios varnum;
run;

proc print data=Municipios (obs=10) noobs;
run;


*data step;
*como el within  de R;
/* proc import
*/

/* Ejemplo 1:
Usando una macro para encontrar los valores perdidos
*/
%include "/home/u63344598/sasuser.v94/mismacros.sas";
%missings(Municipios);

*--------------------------------------------------------------------------------------;

/* Ejemplo 2:
Copia de municipios llamada municipios2
*/

data Municipios2;
set Municipios;
run;

/*
Crea un dataset llamado "Municipios" que es una copia de otro dataset también llamado "Municipios".
Crea una nueva variable llamada "Municipio2" que contiene el valor de la variable "Municipio" pero en minúsculas, sin acentos ni caracteres especiales, sin espacios en blanco innecesarios y con la primera letra de cada palabra en mayúsculas.
Imprime las primeras 10 observaciones de las variables "Municipio" y "Municipio2" utilizando el procedimiento PRINT. La opción "noobs" se utiliza para excluir la numeración de las observaciones en la salida.
Crea una nueva variable llamada "Municipio" que contiene el valor de la variable "Municipio2".
Elimina la variable "Municipio2" del dataset "Municipios".

compress : lo que no sea lo borra
strip: quita espacio al principio al final
propcase: transforma la incial de cada palabra a una Mayuscula
*/


data Municipios;
set Municipios;
    Municipio2 = lowcase(Municipio);*Miniscula;
    Municipio2 = compress(Municipio2,"abcdefghijklmnopqrstuvwxyzáéíóúüñ ","k");
    Municipio2 = strip(Municipio2); *Quita espacios al principio y al final de cada nombre;
    Municipio2 = compbl(Municipio2);
    Municipio2 = propcase(Municipio2);*Mayuscula;
run;

proc print data=Municipios (obs=10) noobs;
    var Municipio Municipio2;
run;

data Municipios;
set Municipios;
    Municipio = Municipio2;
    drop Municipio2;*keep;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 3 
Limpiando Departamento
*/

data Municipios;
set Municipios;
    Departamento2 = lowcase(Departamento);
    Departamento2 = compress(Departamento2,"abcdefghijklmnopqrstuvwxyzáéíóúüñ ","k");
    Departamento2 = strip(Departamento2);
    Departamento2 = compbl(Departamento2);
    Departamento2 = propcase(Departamento2);
run;

proc print data=Municipios (obs=10) noobs;
    var Departamento Departamento2;
run;

data Municipios;
set Municipios;
    Departamento = Departamento2;
    drop Departamento2;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 4
Limpiando region sobreescribiendo
*/

data Municipios;
set Municipios;
    Region = compress(lowcase(Region),"abcdefghijklmnopqrstuvwxyzáéíóúüñ ","k");* Funcion dentro de funcion;
    Region = strip(Region);
    Region = compbl(Region);
    Region = propcase(Region);
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 5
cats: concatenar
substrn: extraer porcion de una cadena substrn(cadena,pocision incial, numero de caracteres a extraer apartir de la pocision inicial)
*/
data Municipios2;
set Municipios;
    if substrn(Depmun,3,3) = "001" then Tipo = "Capital";
    else Tipo = "Otro";
    if Depmun="25001" then Tipo = "Otro";
run;

data Municipios3;
set Municipios;
    if Depmun = cats(Dep,"001") then Tipo = "Capital";
    else Tipo = "Otro";
    if Depmun="25001" then Tipo = "Otro";
run;

proc compare base=Municipios2 compare=Municipios3;*comparar 2 de dataset, genera un reporte;
run;

data Municipios;*sobre escribir al dataset original;
set Municipios2;
run;

proc print data=Municipios (obs=50) noobs;
    var Dep Departamento Depmun Municipio Tipo;
    where Tipo="Capital";
run;
*--------------------------------------------------------------------------------------;
/* Ejemplo 6
*/

data Municipios;
set Municipios;
    Denspobl = Poblacion/Superficie;
    if Irural >= 40 then Zona = "Rural";
    else Zona = "Urbano"; 
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 7
*/
data sintildes;
set Municipios;
    Municipio2 = ktranslate(lowcase(Municipio),"aeiou","áéíóú");*En minisculas y sin tildes;
    largo = length(strip(Municipio2));
run;

data Santos;
set sintildes;
    where prxmatch('/(^| )san( |ta |to )/',strip(Municipio2));
    keep Departamento Depmun Municipio;      
run;

proc print data=Santos noobs;
run;

proc contents data=Santos varnum;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 8
Inician y terminan con la vocal
*/
data Vocales;
set sintildes;
    where prxmatch('/(^a.*a$)|(^e.*e$)|(^i.*i$)|(^o.*o$)|(^u.*u$)/',strip(Municipio2));
    keep Dep Departamento Depmun Municipio;      
run;

proc print data=Vocales noobs;
run;

data Vocales2;
set sintildes;
    where substr(strip(Municipio2),1,1)=substr(strip(Municipio2),length(strip(Municipio2)),1)
          and substr(strip(Municipio2),1,1) in ("a","e","i","o","u");
    keep Dep Departamento Depmun Municipio;      
run;

proc compare base=Vocales compare=Vocales2;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 9
Inician y terminan con la misma consonante
*/

data Consonantes;
set sintildes;
    where substrn(strip(Municipio2),1,1)=substrn(strip(Municipio2),largo,1)
          and substrn(strip(Municipio2),1,1) not in ("a","e","i","o","u");
    keep Dep Departamento Depmun Municipio;      
run;

proc print data=Consonantes noobs;
    var Dep Departamento Depmun Municipio;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 10

*/
data Aes;
set sintildes;
    where prxmatch('/^a.{2}e/',strip(Municipio2));
    drop Poblacion Superficie Irural;
run;

proc print data=Aes noobs;
    var Dep Departamento Depmun Municipio;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 11
*/
libname CursoSAS "/home/u63344598/sasuser.v94/packages/";

data CursoSAS.Municipios;
set Municipios;
run;

proc datasets library=CursoSAS memtype=data; *informe de conjuntos de datos dentro de esa libreria;
run;

*--------------------------------------------------------------------------------------;
/* Ejemplo 12
*/

proc datasets library=Work memtype=data;
run;

proc datasets library=Work memtype=data;
    delete Municipios Municipios2 Municipios3;
run;

proc datasets library=Work memtype=data;
run;