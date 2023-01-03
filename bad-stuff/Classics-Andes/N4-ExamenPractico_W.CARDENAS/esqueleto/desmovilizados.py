import pandas as pd

#Requerimiento 0 - Cargar datos
def cargar_datos(ruta_archivo:str)->pd.DataFrame:
    return pd.read_csv(ruta_archivo)

def cantidad_familias_por_numero_hijos(archivo:pd.DataFrame)->list:
    res=archivo.groupby("NumDeHijos").count()    
    return res


