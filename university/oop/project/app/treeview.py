import tkinter as tk
import tkinter.ttk as ttk
from tkinter import messagebox as mssg
import style as s
import sqlite3

principal= s.style(1)
secondary= s.style(2)
tertiary = s.style(3)
other=s.style(4)
other_2=s.style(5)

def main(self, win):
    #TablaTreeView - Configuracion Inicial
    """
    Se crea una instancia de ttk.Style() para manejar la apariencia del Treeview
    Se configura el estilo "estilo.Treeview" con varios atributos, incluyendo el grosor del resaltado (highlightthickness), el borde (bd), el fondo (background) y la fuente (font).
    Se configura el estilo "estilo.Treeview.Heading" para el encabezado de la tabla con un fondo diferente y una fuente en negrita.
    Se configura la disposición del estilo "estilo.Treeview" con la opción "layout" para que el área de la tabla (treearea) se expanda en todas las direcciones (sticky) con respecto al widget padre (nswe).
    Se crea una instancia del widget Treeview y se le asigna el estilo "estilo.Treeview". Se coloca en una posición específica en la ventana (x,y) y se le da un tamaño específico (height, width).
    """

    anchP=self.win.winfo_screenwidth()
    altoP=self.win.winfo_screenheight()
    #creando estylo personlizado para treeview
    style = ttk.Style()

    # Establecer colores de fondo y texto
    style.theme_use("clam")  # Puedes cambiar el tema aquí
    style.configure("Treeview",
                    background=secondary.get_color(),
                    foreground="black",
                    fieldbackground=secondary.get_color())
    style.map("Treeview",
              background=[('selected', other_2)],
              foreground=[('selected', 'white')])

    # Establecer estilo para las cabeceras de columnas
    style.configure("Treeview.Heading",
                    background=other_2.get_color(),
                    foreground="black",
                    relief="flat",
                    font=("Arial", 11))

    # Establecer estilo para las filas pares e impares
    style.configure("Treeview",
                    rowheight=25,
                    font=("Arial", 10))

    # Establecer estilo de desplazamiento
    style.configure("Treeview",
                    highlightthickness=0,
                    bd=0)

    # Establecer estilo de selección
    style.map("Treeview",
              background=[('selected', other_2.get_color())])

    # Aplicar estilo al Treeview
    self.treeDatos = ttk.Treeview(self.win, height = 10)
    self.treeDatos.config(style="Treeview")
    self.treeDatos.place(anchor="nw", relx=0.29 , rely=0.06, height=altoP*0.45, width = anchP*0.477)

    #Columnas
    #Etiquetas de las columnas
    self.treeDatos['columns']= ("Id", "Nombre","Direccion", "Celular", "Entidad", "Fecha" )

    #Encabezados de las columnas de la pantalla
    self.treeDatos.heading("Id", text="Id")
    self.treeDatos.heading("Nombre", text="Nombre")
    self.treeDatos.heading("Direccion", text="Direccion")
    self.treeDatos.heading("Celular", text="Celular")
    self.treeDatos.heading("Entidad", text="Entidad")
    self.treeDatos.heading("Fecha", text="Fecha")

    #Establece el ancho de cada columna
    for col in self.treeDatos['columns']:
        self.treeDatos.column(col, width=int(anchP*0.080))

    self.treeDatos.column("#0", stretch=0 , width=0)
    self.treeDatos.column("Id", stretch=tk.YES)
    self.treeDatos.column("Nombre", stretch=tk.YES)
    self.treeDatos.column("Direccion", stretch=tk.YES)
    self.treeDatos.column("Celular",  stretch=tk.YES)
    self.treeDatos.column("Entidad", stretch=tk.YES)
    self.treeDatos.column("Fecha", stretch=tk.YES)

    # self.treeDatos.height(6)

    #Establece que columnas se mostraran
    self.treeDatos["displaycolumns"]=("Id", "Nombre", "Direccion", "Celular", "Entidad", "Fecha")

    #Scrollbar en el eje Y de treeDatos
    self.scrollbar=ttk.Scrollbar(self.win, orient='vertical', command=self.treeDatos.yview)
    self.treeDatos.configure(yscroll=self.scrollbar.set)
    self.scrollbar.place(relx=0.95 , rely=0.06, height=altoP*0.45)

    #Carga los datos en treeDatos

    # x = (self.win.winfo_screenwidth() // 2) - (ancho // 2)#Posicion en X
    # y = (self.win.winfo_screenheight() // 2) - (alto // 2)#Posicion en Y

    self.lee_tablaTreeView()
    # self.treeDatos.place(anchor="nw", height="400", rely="0.1", width="700", x="300", y="0")