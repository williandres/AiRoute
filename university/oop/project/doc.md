# Documentacion
**Guía para ejecutar el código:**

1. Asegúrate de tener instalado Python en tu sistema. Puedes descargarlo desde el sitio web oficial de Python e instalarlo siguiendo las instrucciones correspondientes a tu sistema operativo.

2. Abre una terminal o línea de comandos en tu sistema operativo.

3. Navega hasta la carpeta donde se encuentra el código que deseas ejecutar. Puedes utilizar el comando cd seguido de la ruta de la carpeta para cambiar al directorio adecuado.

4. Antes de ejecutar el archivo `__init__.py`, asegúrate de instalar las dependencias necesarias. Para ello, ejecuta el siguiente comando en la terminal:

   

    pip install -r requirements.txt

Esto instalará todas las librerías requeridas para el correcto funcionamiento del código. Asegúrate de que estás ejecutando este comando desde la misma ubicación en la que se encuentra el archivo requirements.txt.

5. Una vez instaladas las dependencias, estás listo para ejecutar el código. Para ello, utiliza el siguiente comando:

    python __init__.py

Esto ejecutará el archivo `__init__.py` y pondrá en marcha tu programa.

Es importante destacar que no debes modificar los archivos que se encuentran en la carpeta "assets". Esta carpeta contiene las imágenes y la base de datos necesarias para el funcionamiento del código. Cualquier modificación en estos archivos podría afectar el comportamiento del programa.

Si sigues estos pasos, deberías poder ejecutar el código sin problemas y utilizar todas las funcionalidades proporcionadas por las librerías instaladas.

**Aviso:**

Para evitar problemas con las direcciones al ejecutar el código desde Visual Studio Code (VSCode), te recomendaría abrir el proyecto directamente desde la carpeta "app" en VSCode. Al hacerlo de esta manera, se establecerá el directorio de trabajo adecuado, lo que facilitará el manejo de las rutas de archivo dentro del código.

Al abrir el proyecto desde la carpeta "app" en VSCode, la estructura de archivos y carpetas se mantendrá intacta, incluyendo el archivo `__init__.py` y la carpeta "assets". Esto garantizará que las referencias a las imágenes y la base de datos se realicen correctamente dentro del código.

Recuerda tener precaución al modificar los archivos dentro de la carpeta "assets", ya que estos contienen elementos clave para el funcionamiento del código, como imágenes y la base de datos. Evita modificar accidentalmente o eliminar archivos importantes en esta carpeta.

