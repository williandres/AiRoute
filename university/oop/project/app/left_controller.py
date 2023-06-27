import tkinter as tk
import tkinter.ttk as ttk
from tkinter import messagebox as mssg
import sqlite3
import style as s
from datetime import date

principal= s.style(1)
secondary= s.style(1)
tertiary = s.style(7)
other=s.style(4)
other_2=s.style(6)

dia_actual = date.today().strftime("%d/%m/%Y")

def main(self, win):
    # Intanciando la clase para los colores
    self.configs_labels={
        "font":"Roboto",
        "width":"12",
        "anchor":"center",
        "border":0,
        "background":other.get_color()

    }

    anchP=self.win.winfo_screenwidth()
    altoP=self.win.winfo_screenheight()
    #Label Frame
    self.lblfrm_Datos = tk.LabelFrame(self.win, width= anchP*0.1, height= altoP*0.2, labelanchor= "n", background=secondary.get_color(),
                                font= ("Roboto", 20,"bold"))
    """1. Se ajustan el diseño del label, fuente de letra, tamaño de letra, tamaño de cuadro y grosor del texto principal de datos"""

    #Labels & Entrys
    entry(self)

    #Configuración del Label Frame
    self.lblfrm_Datos.configure(height="350", relief="groove", text=" Inscripción", width="330", borderwidth=0, background=tertiary.get_color(),fg="#000000")
    self.lblfrm_Datos.place(anchor="nw", relx=0.03 , rely=0.06,width=anchP*0.18, height=altoP*0.45 )
    self.lblfrm_Datos.grid_propagate(0)
    """2. Se ajustan el diseño del label, fuente de letra, tamaño de letra, tamaño de cuadro y grosor del texto principal de datos """

    #Botones
    botones(self)

def entry(self):

    anchP=self.win.winfo_screenwidth()
    altoP=self.win.winfo_screenheight()
    #Label Id
    self.lblId = ttk.Label(self.lblfrm_Datos)
    self.lblId.configure(  justify="left", text="Idenficación", border=2, underline=12, background=self.configs_labels["background"], width=self.configs_labels["width"], anchor=self.configs_labels["anchor"], font=self.configs_labels["font"])
    self.lblId.grid(column="0", padx="5", pady="15", row="0", sticky="w")
    """3. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Entry Id
    self.entryId = tk.Entry(self.lblfrm_Datos)#creacion de la entrada
    self.entryId.configure(exportselection="false", justify="left",relief="groove", takefocus=True, width=int(anchP*0.014))#caracterisricas de la entrada
    self.entryId.grid(column="1", row="0", sticky="w", padx=10)#posicion
    self.entryId.bind("<Key>", lambda event: self.valida_Length(self.entryId, 15,event,True))#valida  el maximo tamaño del input y si es un numero
    self.entryId.bind("<FocusIn>", self.evaluate)
    #self.entryId.bind("<BackSpace>", lambda _:self.entryId.delete(len(self.entryId.get()),'end'))
    """4. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Label Nombre
    self.lblNombre = ttk.Label(self.lblfrm_Datos)
    self.lblNombre.configure(background=self.configs_labels["background"], width=self.configs_labels["width"], anchor=self.configs_labels["anchor"], font=self.configs_labels["font"], justify="left", text="Nombre")
    self.lblNombre.grid(column="0", padx="5", pady="15", row="1", sticky="w")
    """5. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Entry Nombre
    self.entryNombre = tk.Entry(self.lblfrm_Datos)
    self.entryNombre.configure(exportselection="true", justify="left",relief="groove", width=int(anchP*0.014))
    self.entryNombre.grid(column="1", row="1", sticky="w", padx=10)#posicion
    self.entryNombre.bind("<Key>", lambda event: self.valida_Length(self.entryNombre, 50,event))#valida  el maximo tamaño del input.bind("<Key>", lambda event: self.valida_Length(self.entryId, 255))#valida  el maximo tamaño del input
    self.entryNombre.bind("<FocusIn>", self.evaluate)
    """6. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""


    #Label Direccion
    self.lblDireccion = ttk.Label(self.lblfrm_Datos)
    self.lblDireccion.configure(background=self.configs_labels["background"], width=self.configs_labels["width"], anchor=self.configs_labels["anchor"], font=self.configs_labels["font"], justify="left", text="Direccion")
    self.lblDireccion.configure(width="12")
    self.lblDireccion.grid(column="0", padx="5", pady="15", row="2", sticky="w")
    """7. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Entry Direccion
    self.entryDireccion = tk.Entry(self.lblfrm_Datos)
    self.entryDireccion.configure(exportselection="true", justify="left",relief="groove", width=int(anchP*0.014))
    self.entryDireccion.grid(column="1", row="2", sticky="w", padx=10)#posicion
    self.entryDireccion.bind("<Key>", lambda event: self.valida_Length(self.entryDireccion, 150,event))#valida  el maximo tamaño del input.bind("<Key>", lambda event: self.valida_Length(self.entryId, 255))#valid.bind("<Key>", lambda event: self.valida_Length(self.entryNombre, 255))#valida  el maximo tamaño del input.bind("<Key>", lambda event: self.valida_Length(self.entryId, 255))#valida  el maximo tamaño del input
    self.entryDireccion.bind("<FocusIn>", self.evaluate)
    """8. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""


    #Label Celular
    self.lblCelular = ttk.Label(self.lblfrm_Datos)
    self.lblCelular.configure(background=self.configs_labels["background"], width=self.configs_labels["width"], anchor=self.configs_labels["anchor"], font=self.configs_labels["font"], justify="left", text="Celular")
    self.lblCelular.configure(width="12")
    self.lblCelular.grid(column="0", padx="5", pady="15", row="4", sticky="w",)
    """9. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Entry Celular
    self.entryCelular = tk.Entry(self.lblfrm_Datos)
    self.entryCelular.configure(exportselection="false", justify="left",relief="groove", width=int(anchP*0.014))
    self.entryCelular.grid(column="1", row="4", sticky="w",padx=10)
    self.entryCelular.bind("<Key>", lambda event: self.valida_Length(self.entryCelular, 10,event,True))
    self.entryCelular.bind("<FocusOut>", lambda event: self.fecha_celu(event,1))
    self.entryCelular.bind("<Return>", self.valida_Celular)
    self.entryCelular.bind("<FocusIn>", self.evaluate)
    """10. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Label Entidad
    self.lblEntidad = ttk.Label(self.lblfrm_Datos)
    self.lblEntidad.configure(background=self.configs_labels["background"], width=self.configs_labels["width"], anchor=self.configs_labels["anchor"], font=self.configs_labels["font"], justify="left", text="Entidad")
    self.lblEntidad.configure(width="12")
    self.lblEntidad.grid(column="0", padx="5", pady="15", row="5", sticky="w")
    """11. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Entry Entidad
    self.entryEntidad = tk.Entry(self.lblfrm_Datos)
    self.entryEntidad.configure(exportselection="true", justify="left",relief="groove", width=int(anchP*0.014))
    self.entryEntidad.grid(column="1", row="5", sticky="w", padx=10)#posicion
    self.entryEntidad.bind("<Key>", lambda event: self.valida_Length(self.entryEntidad, 50,event))#valida  el maximo tamaño del input.bind("<Key>", lambda event: self.valida_Length(self.entryId, 255))#valida.bind("<Key>", lambda event: self.valida_Length(self.entryNombre, 255))#valida  el maximo tamaño del input.bind("<Key>", lambda event: self.valida_Length(self.entryId, 255))#valida  el maximo tamaño del input
    self.entryEntidad.bind("<FocusIn>", self.evaluate)
    """12. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""


    #Label Fecha
    self.lblFecha = ttk.Label(self.lblfrm_Datos)
    self.lblFecha.configure(background=self.configs_labels["background"], width=self.configs_labels["width"], anchor=self.configs_labels["anchor"], font=self.configs_labels["font"], justify="left", text="Fecha")
    self.lblFecha.configure(width="12")
    self.lblFecha.grid(column="0", padx="5", pady="15", row="3", sticky="w")
    """13. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro"""

    #Entry Fecha
    self.entryFecha = tk.Entry(self.lblfrm_Datos)
    self.entryFecha.configure(exportselection="true", justify="center",relief="groove", width=int(anchP*0.014),foreground="#000000")
    self.entryFecha.grid(column="1", row="3", sticky="w",padx=10)
    self.entryFecha.bind("<Key>", self.valida_FormatoFecha)
    self.entryFecha.bind("<Return>", self.valida_Fecha)
    self.entryFecha.bind("<FocusIn>", self.evaluate)
    self.entryFecha.bind("<FocusOut>", lambda event: self.fecha_celu(event,2))
    """14. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro, ancho de cuadro, y se evalua
    que sea correcta, para que se ingrese la correcta"""

def botones(self):

    #Botón Grabar
    self.configs_bottons={
        "bg":other_2.get_color(),
        "font":"Roboto",
        "width":"7",
        "fg":"white",
        "activebackground":secondary.get_color(),
        "border":0,
        "activeforeground":"white"

    }
    #boton grabar
    self.btnGrabar = tk.Button(self.win, bg=self.configs_bottons["bg"], font=self.configs_bottons["font"])
    self.btnGrabar.configure(state="normal", text="Grabar", width=self.configs_bottons["width"], fg=self.configs_bottons["fg"] ,activebackground=self.configs_bottons["activebackground"],border=self.configs_bottons["border"], activeforeground=self.configs_bottons["activeforeground"])
    self.btnGrabar.place(anchor="nw", relx=0.04, rely=0.74)
    self.btnGrabar.bind("<Enter>", lambda event: self.on_enter(event,"agregar"))  # Asociar la función on_enter() al evento <Enter>
    self.btnGrabar.bind("<Leave>", lambda event: self.on_leave(event,"agregar"))
    self.btnGrabar.bind("<1>", self.adiciona_Registro, add="+")
    """15. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro
    Se llama la funcion que evalua que se cumplan los requisitos de todos los "entry" """

    #Botón Editar
    self.btnEditar = tk.Button(self.win, bg=self.configs_bottons["bg"], font=self.configs_bottons["font"])
    self.btnEditar.configure(text="Editar", width=self.configs_bottons["width"], fg=self.configs_bottons["fg"] ,activebackground=self.configs_bottons["activebackground"],border=self.configs_bottons["border"], activeforeground=self.configs_bottons["activeforeground"])
    self.btnEditar.place(anchor="nw",relx=0.10, rely=0.74)
    self.btnEditar.bind("<Enter>", lambda event: self.on_enter(event,"editar"))  # Asociar la función on_enter() al evento <Enter>
    self.btnEditar.bind("<Leave>", lambda event: self.on_leave(event,"editar"))
    self.btnEditar.bind("<1>", self.edita_tablaTreeView, add="+")

    #Botón Eliminar
    self.btnEliminar = tk.Button(self.win,bg=self.configs_bottons["bg"], font=self.configs_bottons["font"])
    self.btnEliminar.configure(text="Eliminar", width=self.configs_bottons["width"], fg=self.configs_bottons["fg"] ,activebackground=self.configs_bottons["activebackground"],border=self.configs_bottons["border"], activeforeground=self.configs_bottons["activeforeground"])
    self.btnEliminar.place(anchor="nw", relx=0.16, rely=0.74)
    self.btnEliminar.bind("<Enter>", lambda event: self.on_enter(event,"eliminar"))  # Asociar la función on_enter() al evento <Enter>
    self.btnEliminar.bind("<Leave>", lambda event: self.on_leave(event,"eliminar"))
    self.btnEliminar.bind("<1>", self.elimina_Registro, add="+")
    """16. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro
    Se llama la funcion que permite eliminar cualquiera de los valores de los entry"""

    #Botón Cancelar
    self.btnCancelar = tk.Button(self.win, bg=self.configs_bottons["bg"], font=self.configs_bottons["font"])
    self.btnCancelar.configure(text="Cancelar", command = self.limpia_Campos, width=self.configs_bottons["width"], fg=self.configs_bottons["fg"] ,activebackground=self.configs_bottons["activebackground"],border=self.configs_bottons["border"], activeforeground=self.configs_bottons["activeforeground"])
    self.btnCancelar.place(anchor="nw", relx=0.22, rely=0.74)
    self.btnCancelar.bind("<Enter>", lambda event: self.on_enter(event,"cancelar"))  # Asociar la función on_enter() al evento <Enter>
    self.btnCancelar.bind("<Leave>", lambda event: self.on_leave(event,"cancelar"))
    """15. Se ajustan las caracteristicas de posicion, tamaño, ancho de cuadro
    Se llama la funcion que permite borrar todos los valores de los entry"""