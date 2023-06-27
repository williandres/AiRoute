# !/usr/bin/python3
# -*- coding: utf-8 -*
import tkinter as tk
import tkinter.ttk as ttk
from tkinter import messagebox as mssg
import sqlite3
import window_main as wm
import left_controller as lc
import treeview as tr
import os
from dateutil.parser import parse
import style as s

numbs_allowed = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9","KP_0", "KP_1", "KP_2", "KP_3", "KP_4", "KP_5", "KP_6", "KP_7", "KP_8", "KP_9"]
keys_allowed = ["\x08","Up","Down","Left","Right","Home","End","Delete","BackSpace","Tab","Shift_L","Shift_R","Control_L","Control_R","Alt_L","Alt_R","Caps_Lock","Escape","Return"]

principal= s.style(1)
secondary= s.style(2)
tertiary = s.style(3)
other=s.style(6)
hover=s.style(1)

class Participantes:
    # Ruta de la base de datos
    db_name = os.path.abspath("assets/db/poo_project.db")#Ruta de la base de datos
    actualiza = None
    verificate = [False, 0]
    def __init__(self, master=None): 
        # Top Level - Ventana Principal
        self.win = tk.Tk() if master is None else tk.Toplevel()
        height = self.win.winfo_screenheight()#Tamaño de la pantalla Alto
        width = self.win.winfo_screenwidth()#Tamaño de la pantalla Ancho

        #Configuracion de la ventana principal, titulos, iconos y dimensiones
        wm.main(self,self.win,height,width)

        # Main widget
        self.mainwindow = self.win#Ventana principal

        #Entrys y botones
        lc.main(self, self.win)

        #TreeView
        tr.main(self, self.win)

    #--------Rutinas Esteticas----------#
    def centra(self,win,ancho,alto)->None:
        """ Centra las ventanas en la pantalla
                win: Ventana a centrar
                ancho: Ancho de la ventana
                alto: Alto de la ventana
        """
        x = (self.win.winfo_screenwidth() // 2) - (ancho // 2)#Posicion en X
        y = (self.win.winfo_screenheight() // 2) - (alto // 2)#Posicion en Y
        win.geometry(f'{ancho}x{alto}+{x}+{y}')
        win.deiconify()#Hace visible la ventana
    #--------Rutinas De Validacion----------#
    def valida(self):
        '''Valida que el Id no esté vacio, devuelve True si ok'''
        #Valida ID
        if self.actualiza != True:
            #Valida si esta vacia
            fila_id = self.entryId.get()#Leemos el id
            if len(fila_id) == 0:
                mssg.showerror('Error','El campo identificacion esta vacio')
                return False
            #Valida si ya existe o no
            for i in self.treeDatos.get_children():
                if self.treeDatos.item(i, 'values')[0] == fila_id:
                    mssg.showerror('Error','El id ingresado ya existe')
                    return False

        #Validar campos vacios
        campo_vacio = lambda x: len(x) == 0
        cadena = ""
        if campo_vacio(self.entryNombre.get()):
            cadena += " Nombre \n"
        if campo_vacio(self.entryDireccion.get()):
            cadena += " Direccion \n"
        if campo_vacio(self.entryCelular.get()):
            cadena += " Celular \n"
        if campo_vacio(self.entryEntidad.get()):
            cadena += " Entidad \n"
        if campo_vacio(self.entryFecha.get()):
            cadena += " Fecha \n"

        if len(cadena) > 0:
            confirmacion = mssg.askokcancel("Confirmación", "Los siguiente campos estan vacios: \n" + cadena + "\n ¿Desea continuar?")
            if confirmacion:
                pass
            else:
                return False

        #Advertencia fecha
        if not self.valida_Fecha(0):
            confirmacion = mssg.askokcancel("Confirmación", "¿Desea continuar?")
            if confirmacion:
                self.entryFecha.delete(0, 'end')
            else:
                return False
        return True

    def valida_Length(self,entry,n,event,valida_Int = False):
        char = event.keysym#Obtiene la tecla presionada en el entry
        #Validacion de que sea un numero
        if valida_Int:
            if char in keys_allowed + numbs_allowed:
                pass
            else:
                return "break"
        #Validacion de maximo de caracteres
        if len(entry.get()) >= n and char not in keys_allowed:
            return "break"

    def valida_FormatoFecha(self, event):
        key = event.keysym#Obtiene la tecla presionada en el entry (Incluye flechas)

        # Se verifica que sea un número o una tecla en especial
        if key in keys_allowed + numbs_allowed:
            pass
        else:
            return "break"

        fecha = self.entryFecha.get()
        # Se genera el formato adecuado
        if len(fecha) == 2:
            if key not in keys_allowed:
                self.entryFecha.delete(0, "end")
                self.entryFecha.insert(0, fecha + "/")
        if len(fecha) == 5:
            if key not in keys_allowed:
                self.entryFecha.delete(0, "end")
                self.entryFecha.insert(0, fecha + "/")
        if len(fecha) == 10 and key not in keys_allowed:
            return "break"

    def fecha_real(self):
        fecha = self.entryFecha.get()
        if len(fecha) != 0 and fecha != "dd/mm/aaaa" + " ":
            try:
                if not len(fecha) == 10:
                    return 0
                else:
                    day, month, year = map(int, fecha.split("/"))
                    if day <  1 or day > 31:
                        return 1
                    elif month < 1 or month > 12:
                        return 2
                    elif year < 1900 or year > 2100:
                        return 3
                parse(fecha)
                return 5
            except ValueError:
                return 4
        else:
            return 5

    def valida_Fecha(self, event):
        flag = self.fecha_real()
        type_warning = ["La fecha esta incompleta",
                        "El dia debe estar entre 1 y 31",
                        "El mes debe estar entre 1 y 12",
                        "El año debe estar entre 1900 y 2100",
                        "La fecha no existe"]
        if flag != 5:
            mssg.showwarning("Atencion",type_warning[flag] + ", no se podra guardar este campo")
            return False
        return True

    def valida_Celular(self, event):
        celular = self.entryCelular.get()
        if len(celular) != 0:
            if len(celular) != 10 or celular[0] != '3':
                mssg.showinfo('Atencion','Recuerde que en Colombia comunmente el numero celular empieza con 3 y tiene 10 numeros')

    #---------Rutinas de control-----#
    def fecha_celu(self, event,n):
        self.verificate[0] = True
        self.verificate[1] = n

    def evaluate(self, event):
        if self.verificate[0] == True and self.verificate[1] == 1:
            self.valida_Celular(event)
            self.verificate[0] = False
        if self.verificate[0] == True and self.verificate[1] == 2:
            self.valida_Fecha(event)
            self.verificate[0] = False

    #--------Rutinas De SQL----------#
    def get_fila(self):
        try:
            fila_focus = self.treeDatos.focus()
            fila = self.treeDatos.item(fila_focus)['values']
            self.entryId.configure(state='normal')#Habilita el entry para que se pueda modificar
            self.entryId.delete(0, 'end')
            self.entryId.insert(0, fila[0])
            self.entryId.configure(state='readonly')#Deshabilita el entry para que no se pueda modificar
            self.entryNombre.delete(0, 'end')
            self.entryNombre.insert(0, fila[1])
            self.entryDireccion.delete(0, 'end')
            self.entryDireccion.insert(0, fila[2])
            self.entryCelular.delete(0, 'end')
            self.entryCelular.insert(0, fila[3])
            self.entryEntidad.delete(0, 'end')
            self.entryEntidad.insert(0, fila[4])
            self.entryFecha.delete(0, 'end')
            self.entryFecha.insert(0, fila[5])
            return fila
        except:
            mssg.showinfo('Atencion','Seleccione una fila')
            return None


    def limpia_Campos(self):
        self.actualiza = None
        self.entryId.configure(state='normal')#Habilita el entry para que se pueda modificar
        self.entryId.delete(0, 'end')
        self.entryNombre.delete(0, 'end')
        self.entryDireccion.delete(0, 'end')
        self.entryCelular.delete(0, 'end')
        self.entryEntidad.delete(0, 'end')
        self.entryFecha.delete(0, 'end')

    def run_Query(self, query, parametros = ()):
        ''' Función para ejecutar los Querys a la base de datos '''
        with sqlite3.connect(self.db_name) as conn:
            # nos permite ejecutar codigo sql
            cursor = conn.cursor()#permite ejecutar codigo sql
            result = cursor.execute(query, parametros)#ejecuta el query y guarda el resultado en una variable
            conn.commit()#guarda los cambios
        return result

    def lee_tablaTreeView(self):
        try:
            with sqlite3.connect(self.db_name) as conn:
                # nos permite ejecutar codigo sql
                cursor = conn.cursor()
                # inserta datos en la base
                # cursor.execute(" INSERT INTO personas VALUES (1, 'JULIO','CALLE 55', 12312412, 123, 90  )")

                # guarda
                # conn.commit()
                cursor.execute("SELECT * FROM personas ")
                # GUARDA EN UNA VARIABLE TODA LA INFO DE LA CONSULTA EN UNA LISTA

                personas = cursor.fetchall()

                conn.commit()

                self.treeDatos.delete(*self.treeDatos.get_children())#Elimina las filas del treeview
                # Insertando los valores al treeview
                for index, value in enumerate(personas, start=1):
                    # el "id" se puede manejar como la Primary key en caso de ser necesario, hasta el momento es cuenta sucesiva de numeros
                    # la columna en donde se muestra el idd esta oculta

                    # Se estan insertando los valores de la base de datos en la columnas del tree view
                    self.treeDatos.insert(parent="", index='end', iid=index, values=(value[0],value[1],value[2],value[3],value[4],value[5] ))
                    # parent indica dentro ed quien esta contenida la fila, 
                    # index end indica que los datos se colocanuno debajo del otro
        except Exception as e : #captuta cualquier posible error desde que se conecta a la base
            mssg.showerror("Error al conectar la base de datos","No se ha podido conectar a la base de datos")
            print(e)

    def adiciona_Registro(self, event=None):
        '''Adiciona un producto a la BD si la validación es True'''
        if self.valida():
            #Funcion de editar
            if self.actualiza:
                self.actualiza = None
                query = 'UPDATE personas SET Id = ?,Nombre = ?,Dirección = ?,Celular = ?,"Entidad " = ?, Fecha = ? WHERE Id = ?'
                parametros = (self.entryId.get(), self.entryNombre.get(), self.entryDireccion.get(),
                                self.entryCelular.get(), self.entryEntidad.get(), self.entryFecha.get(),self.entryId.get()
                                )
                self.limpia_Campos()
                self.run_Query(query, parametros)
                mssg.showinfo('Ok',' Registro actualizado con éxito')
                self.lee_tablaTreeView()
            #Funcion de crear registro
            else:
                query = 'INSERT INTO personas VALUES(?, ?, ?, ?, ?, ?)'
                parametros = (self.entryId.get(),self.entryNombre.get(), self.entryDireccion.get(),
                                self.entryCelular.get(), self.entryEntidad.get(), self.entryFecha.get())
                self.limpia_Campos()
                self.run_Query(query, parametros)
                mssg.showinfo('',f'Registro: {parametros[0]} .. agregado')
                self.lee_tablaTreeView()

    def edita_tablaTreeView(self, event=None):
        if self.get_fila() != None:
            self.actualiza = True

    def elimina_Registro(self, event=None):
        self.actualiza = None
        fila_focus = self.get_fila()#Leemos la fila
        if fila_focus:
            fila_id = fila_focus[0]#Capturamos el id
            # Valida que se tome el valor de id correctamente
            if fila_id:
                confirmacion = mssg.askokcancel("Confirmación", f"¿Desea Eliminar el registro?\n \n Identificación: {fila_id}")
                if confirmacion:
                    # Eliminacion del registro
                    query = "DELETE FROM personas WHERE id = ?"
                    self.run_Query(query, (fila_id,))

                    # Actualiza el treeview
                    self.lee_tablaTreeView()
                    self.limpia_Campos()
                else:
                    self.limpia_Campos()
            else:
                mssg.showerror("Error", "Seleccione un registro valido ")
    #--------Rutinas Animaciones----------#
    def on_enter(self,event, tipo):
        if tipo=="eliminar":
            self.btnEliminar.configure(bg=hover.get_color(), fg="white",)
        elif tipo=="agregar":
            self.btnGrabar.configure(bg=hover.get_color(), fg="white",)
        elif tipo=="cancelar":
            self.btnCancelar.configure(bg=hover.get_color(), fg="white",)
        elif tipo =="editar":
            self.btnEditar.configure(bg=hover.get_color(), fg="white",)
    def on_leave(self, event, tipo):
        if tipo=="eliminar":
            self.btnEliminar.configure(bg=other.get_color(), fg="white",)
        elif tipo=="agregar":
            self.btnGrabar.configure(bg=other.get_color(), fg="white",)
        elif tipo=="cancelar":
            self.btnCancelar.configure(bg=other.get_color(), fg="white",)
        elif tipo =="editar":
            self.btnEditar.configure(bg=other.get_color(), fg="white",)
    #--------Rutinas Principales----------#
    def run(self):
        self.mainwindow.mainloop()#Ejecuta la ventana

if __name__ == "__main__":
    app = Participantes()
    app.run()
