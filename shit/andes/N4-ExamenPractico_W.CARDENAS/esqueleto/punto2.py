#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def cargar_vinos (ruta_archivo: str) -> list:
    
    vinos = []
    archivo = open(ruta_archivo)
    titulos = archivo.readline().split(";")
    
    linea = archivo.readline()
    while len(linea) > 0:
        datos_vino = linea.replace("\n", "").split(";")
        fixed_acidity = float(datos_vino[0])
        volatile_acidity = float(datos_vino[1])
        residual_sugar = float(datos_vino[2])
        pH = float(datos_vino[3])
        tupla = (fixed_acidity, volatile_acidity, residual_sugar, pH)
        vinos.append(tupla)
        linea = archivo.readline()
    
    archivo.close()
    return vinos


###############----Desarrollo del Punto 2----#####################☻

def contar_vinos_tipo_exportacion(vinos:list)->int:
    cantidad_vinos=0
    for i in range(0, len(vinos)):
        ph=vinos[i][-1]
        if ph>=3.0 and i%3==0:
            cantidad_vinos=cantidad_vinos+1
    return cantidad_vinos
    
    
if __name__=='__main__':
    vinos=cargar_vinos("winequality-red.csv")
    resultado=contar_vinos_tipo_exportacion(vinos)
    print(resultado)