# !/usr/bin/python3
# -*- coding: utf-8 -*
import tkinter as tk
import tkinter.ttk as ttk
from tkinter import messagebox as mssg
import sqlite3
import style as s
def main(self, win,height,width):
    #Llamado a la rutina de centrado de pantalla
    principal= s.style(1)
    secondary= s.style(2)
    tertiary = s.style(3)
    other=s.style(4)

    margen = lambda dimension,percent: round(dimension * percent)
    self.centra(win,margen(width,0.72),margen(height,0.6))

    #Top Level - Configuración
    self.win.configure(background=tertiary.get_color())#Fondo de la ventana
    self.win.resizable(False, False)#No permite cambiar el tamaño de la ventana
    self.win.title("Conferencia Arquitectura Hexagonal")#Titulo de la ventana
    self.win.pack_propagate(0)#Evita que se ajuste a los elementos de la ventana

    #ICONO - Ventana
    #Windows
    try:
        self.path = "assets/img/win/conference.ico"
        self.win.iconbitmap(self.path)
    #Linux
    except:
        self.path = "assets/img/linux/conference.png"
        self.win.iconphoto(True, tk.PhotoImage(file=self.path))
