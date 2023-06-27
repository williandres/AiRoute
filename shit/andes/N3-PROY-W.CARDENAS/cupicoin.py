#________________________________CARGAR BLOCKCHAIN/HASH_____________________________________#


def cargar_blockchain_cupicoin(arch:str)->list:
    blockchain=[]                                  #LISTA QUE CONTIENA LOS DICCIONARIOS DE LO BLOQUES CON SUS CORREPONIENTE DICCIONARIO DE TRANSACCIONES
    archivo=open(arch,"r")                         #ABRE EL ARCHIVO
    linea=archivo.readline()                       #TITULO
    cadena=[]                                      #ESTA CADENA CONTIENE DATOS PARA REALIZAR EL HASH 
    #PRIMERA LINEA DE DATOS______LA USAMOS Y CREAMOS NUESTRO PRIMER BLOQUE
    linea=archivo.readline()
    bloque=primer_bloque(linea)
    #GUARDAMOS EL NUMERO DE BLOQUE Y SU HASH_____PARA PRIMERO SABER CUANDO SE CAMBIA DE BLOQUE
    #Y GUARDAR SU HASH PARA PONERLO EN HASH ANTERIOR
    datos=linea.split(",")    
    num_bloque=datos[1]
    hash_anterior=bloque["Hash"]
    timestamp=datos[5]
    #APARTIR DE LA TRANSACCION PASAMOS LOS DATOS A "CADENA" PARA LUEGO CONVERTIRLA EN UN HASH
    transaccion=transaccion_crear(datos)
    asci=sumaascii(transaccion,cadena)
    #PASAMOS A NUESTRA SEGUNDA LINEA DE DATOS____USAMOS "i" PARA ASAGINARLE UN NUMERO A LA TRANSACCION
    linea=archivo.readline()
    i=0
    while len(linea)>0:                             #HARA TODO EL PROCESO DESDE LA SEGUNDA LINEA HASTA TODO EL ARCHIVO
        #CONVERTIR LA LINEA EN UNA LISTA
        datos=linea.split(",")
        #CREAR LA TRANSACCION
        transaccion=transaccion_crear(datos)
        #CREAR NUEVO BLOQUE
        if datos[1]!=num_bloque:                    #CREAR UN NUEVO BLOQUE SI DETECTA UN NUEVO NUM_BLOQUE
            hsh=def_hash(asci,num_bloque,hash_anterior,int(timestamp))#CREAMOS EL HASH
            bloque.update({"Hash":hsh})             #ACTUALIZA EL BLOQUE CON SU HASH
            bloque.update({"Abierto":False})        #ACTUALIZA EL BLOQUE CAMBIEN SU ESTADA A CERRADO
            hash_anterior=bloque["Hash"]            #ACTUALIZAMOS EL HASH CON EL ANTERIOR
            cadena=[]                               #VACIAMOS LA CADENA PARA VOLVE A EMPEZAR EL PROCESO DE CREACION DE HASH
            blockchain.append(bloque)               #AÑADE EL BLOQUE A LA LISTA
            #CREAMOS UN NUEVO BLOQUE
            bloque={}
            bloque["Numero_Bloque"]=datos[1]
            bloque["Cantidad_Transacciones"]=1
            bloque["Timestamp"]=datos[5]
            bloque["Abierto"]=True
            bloque["Hash"]=None
            bloque["Hash_Anterior"]=hash_anterior
            asci=sumaascii(transaccion,cadena)      #EMPEZAMOS LA CREACION DE LA NUEVA CADENA
            ##AÑADIR TRANSACCION##
            i=0                                     #SE RESETEA EL NUEMERO LA TRANSSACIN
            bloque[str(i)]=transaccion
        #ACTUALIZAR BLOQUE
        if datos[1]==num_bloque:
            asci=sumaascii(transaccion,cadena)      #SE AÑADE MAS DATOS A LA CADENA
            bloque["Cantidad_Transacciones"]+=1     #ACTUALIZA EL NUMERO DE TRANSACCIONES
            ##AÑADIR TRANSACCION##
            i+=1
            bloque[str(i)]=transaccion
        #GUARDAMOS LOS DATOS DE LA LINEA ANTERIOR PARA QUE A LA VUELTA DEL CICLO SE PUEDAN EVALUAR
        num_bloque=datos[1]
        timestamp=datos[5]
        linea=archivo.readline()                    #LINEA SIGUIENTE
    #CUANDO LLEGUE A LA ULTIMA LINEA DE DATOS 
    hsh=def_hash(asci,num_bloque,hash_anterior,int(timestamp))
    bloque.update({"Hash":hsh})
    bloque.update({"Abierto":False})
    hash_anterior=bloque["Hash"]
    blockchain.append(bloque)                       #AÑADE EL BLOQUE A LA LISTA
    #ULTIMO BLOQUE(ABIERTO)
    bloque=ultimo_bloque(num_bloque,hash_anterior)
    blockchain.append(bloque)                       #AÑADE EL BLOQUE A LA LISTA
    return blockchain

def primer_bloque(linea:str)->dict:##PARA FACILITAR EL TRABAJO DE HACER EL PRIMER BLOQUE CON SUS 
                                   ##CARACTERISTICAS ESPECIALES LO CREAMOS DE FORMA "MANUAL"
    datos=linea.split(",")#CONVERTIR LA LINEA EN UNA LISTA
    transaccion=transaccion_crear(datos) #CREAR LA TRANSACCION
    #CREAR BLOQUE
    bloque={}
    bloque["Numero_Bloque"]=datos[1]
    bloque["Cantidad_Transacciones"]=1
    bloque["Timestamp"]=datos[5]
    bloque["Abierto"]=True
    bloque["Hash"]=None
    bloque["Hash_Anterior"]=None
    ##AÑADIR TRANSACCION##
    bloque["0"]=transaccion
    return bloque

def transaccion_crear(datos:list)->dict:#CREAMOS LA TRANSACCION CON LOS DATOS DEL ARCHIVO
    transaccion={}
    transaccion["Codigo"]=datos[0]
    transaccion["Remitente"]=datos[2]
    transaccion["Destinatario"]=datos[3]
    transaccion["Valor"]=str(datos[4])
    if datos[3]=="":
        transaccion["Operacion"]="Contrato"
    if datos[3]!="":
        transaccion["Operacion"]="Transferencia"
    return transaccion


def sumaascii(dicc:dict,cadena:list)->list:#AGREGA LOS VALORES DE LAS TRANSACCION DEL BLOQUE
    for value in dicc.values():
        cadena.append(value)
    return cadena

def def_hash(cadena:list,num:str,ahas:str,timestamp:int)->int:#FUNCION QUE RECIBE LAS TRANSACCIONES CONCATENDAS Y HACER LOS RESPECTIVO CALCULO PARA CREAR EL HASH
    final=0                             #NUMERO QUE REPRESENTA LA SUMA DE LOS CARACTERES ASCCI
    cadena.append(str(num))             #SE AGREGA EL NUMERO DE BLOQUE
    cadena.append(str(ahas))            #SE AGREGA EL NUMERO EL HASH ANTERIOR
    cadena_final="".join(cadena)        #SE CONVIERTE LA LISTA EN UN STRING SIN ESPACIOS
    
    for i in range(0,len(cadena_final)):#RECORRE TODA LA CADENA HASTA SU ULTIMO CARACTER
        hashx=ord(cadena_final[i])      #CAPTURA EL CARACTER Y LO CONVIERTO EN UN NUMEROS SEGUN ASCII
        final+=hashx                    #SUMAMOS EL CARACTER
    return final%timestamp#TERMINA LA CREACION DEL HASH

def ultimo_bloque(num_bloque:str,hash_anterior:str)->dict:##PARA FACILITAR EL TRABAJO DE HACER EL ULTIMO BLOQUE CON SUS 
                                   ##CARACTERISTICAS ESPECIALES LO CREAMOS DE FORMA "MANUAL"
    #CREAR BLOQUE
    bloque={}
    bloque["Numero_Bloque"]=int(num_bloque)+1
    bloque["Cantidad_Transacciones"]=0
    bloque["Timestamp"]=None
    bloque["Abierto"]=True
    bloque["Hash"]=None
    bloque["Hash_Anterior"]=int(hash_anterior)
    return bloque


 #_____________________AÑADIR TRANSACCION A ULTIMO BLOQUE ABIERTO______________________________#
 
 
def añadir_trans(blockchain:list,codigo:str,remitente:str,operacion:str,destinatario:str,valor:float):
    num_trans=blockchain[len(blockchain)-1]["Cantidad_Transacciones"]#ASINAGMOS EL NUMERO DE LA TRANSACCION USANDO CANTIDAD DE TRANSACCIONES    
    #CREAMOS LA TRANSACCION CON LOS CORRESPONDIENTES DATOS
    transaccion={}
    transaccion["Codigo"]=codigo
    transaccion["Remitente"]=remitente
    transaccion["Operacion"]=operacion
    transaccion["Destinatario"]=destinatario
    transaccion["Valor"]=str(valor)
    blockchain[len(blockchain)-1][str(num_trans)]=transaccion       #AÑADE LA TRANSACCIONA AL ULTIMO BLQOUE
    blockchain[len(blockchain)-1]["Cantidad_Transacciones"]+=1      #ACTUALIZA EL BLOQUE (NUMERO DE TRANSACCIONES)
    
    
    #_____________________FIN DEL ULTIMO BLOQUE______________________________#
    
    
def final_bloque(blockchain:list,timestamp:int):#CIERRA EL ULTIMO BLOQUE ASIGANDOLE SU CORRESPONDIENTE HASH Y TIMESTAMP, TAMBIEN AGREGA UN NUEVO BLOQUE ABIERTO
    blockchain[len(blockchain)-1]["Timestamp"]=timestamp            #ACTUALIZA EL ULTIMO BLOQUE CON EL TIMESTAMP
    num_bloque=blockchain[len(blockchain)-1]["Numero_Bloque"]       #CAPTURA EL NUMERO DE BLOQUE PARA USARLO EN LA FUNCION HASH
    hash_anterior=blockchain[len(blockchain)-1]["Hash_Anterior"]    #CAPTURA EL HASH ANTERIOR PARA USARLO EN LA FUNCION HASH
    asciii=nuevo_ascii(blockchain)                                 #CONCATENA TODAS LAS TRANSACCIONES
    hsh=def_hash(asciii,num_bloque,hash_anterior,timestamp)        #LLAMA A LA FUNCION HASH PARA AGREGAR A LA CADENA(TODAS LAS TRANSACCIONES) EL NUMERO DEL BLOQUE, EL HASH ANTERIOR Y CALCULA EL HASH CON EL TIME STAMP
    blockchain[len(blockchain)-1]["Hash"]=hsh                      #ACTUALIZA EL ULTIMO BLOQUE CON SU HASH CALCULADO
    blockchain[len(blockchain)-1]["Abierto"]=False                 #ACTUALIZA EL ULTIMO BLOQUE CERRANDOLO
    bloque=ultimo_bloque(num_bloque,hsh)                           #CREA UN NUEVO BLOQUE ABIERTO
    blockchain.append(bloque)                                      #AÑADE EL BLOQUE A LA BLOCKCHAIN
    
def nuevo_ascii(blockchain:list)->list:#FUNCION QUE CONCATENA TODAS LAS TRANSACCIONES DEL ULTIMO BLOQUE
    i=0
    cadena=[]
    while i<=blockchain[len(blockchain)-1]["Cantidad_Transacciones"]-1:
        dicc=blockchain[len(blockchain)-1][str(i)]
        for value in dicc.values():
            cadena.append(value)
        i+=1
    return cadena


    #_____________________NUMERO DE VECES______________________________# 
      
    
def numero_veces(blockchain:list,id_cuenta:str)->dict:#FUNCION QUE RETORNA UN DICCIONARIO SEGUNA CUANTAS VECES HA SIDO REMITENTE Y DESTINATARIO UNA CUENTA
    cuenta={"Remitente":0,"Destinatario":0}
    x=0
    while x<=len(blockchain)-1:
        i=0
        bloque=blockchain[x]
        while i<=bloque["Cantidad_Transacciones"]-1:
            num=str(i)
            dicc=bloque[num]
            if dicc["Remitente"]==id_cuenta:
                cuenta["Remitente"]+=1
            if dicc["Destinatario"]==id_cuenta:
                cuenta["Destinatario"]+=1
            i+=1
        x+=1
    return cuenta


    #_____________________BUSCAR TRANSACCION______________________________# 
    
    
def dicc_transaccion(blockchain:list,codigo_tr:str)->dict:#FUNCION QUE RETORNA EL DICCIONARIO DE LA TRANSACCION SEGUN SU CODIGO 
    res=None
    x=0
    while x<=len(blockchain)-1:
        i=0
        bloque=blockchain[x]
        while i<=bloque["Cantidad_Transacciones"]-1:
            num=str(i)
            dicc=bloque[num]
            if dicc["Codigo"]==codigo_tr:
                res=dicc
            i+=1
        x+=1
    return res


    #_____________________VALIDAR BLOCKCHAIN______________________________# 
    
    
def validar_blockchain(blockchain:list)->bool:#FUNCION QUE VERIFICA LA INTEGRIDAD DE LA BLOCKCJAIN EN 3 PASOS
    res=True
    lenght=len(blockchain)
    ###(PASO 1)Evalua que todos los bloques esten cerrados a excepcion del ultimo###
    for i in range(0, lenght-1):#Evalua que desde el primer bloque hasta el penultimo que este cerrado
        bloque=blockchain[i]
        if bloque["Abierto"]==True:
            res=False
    if not blockchain[lenght-1]["Abierto"]==True:#evalua que el ultimo bloque NO este cerrado
        res=False
                     ###(PASO 2)VERIFICAR HASH ANTERIOR###
    if not blockchain[0]["Hash_Anterior"]==None:#Verficar que el primer bloque tenga como None el hash anterior
        res=False
    for i in range(1, lenght):#Evaluar desde el segundo bloque hasta el ultimo
        if not blockchain[i-1]["Hash"]==blockchain[i]["Hash_Anterior"]:
            res=False
                         ###(PASO 3)VERIFICAR HASH###
    for i in range(0, lenght-1):#Evaluar desde el primer bloque hasta el penultimo, ya que el ultimo no debe tener hash
        cadena=[]
        x=0
        until=blockchain[i]["Cantidad_Transacciones"]-1
        while x<=until:
            dicc=blockchain[i][str(x)]
            for value in dicc.values():
                cadena.append(value)
            x+=1
        hashh=0
        cadena.append(str(blockchain[i]["Numero_Bloque"]))#SE AGREGA EL NUMERO DE BLOQUE
        cadena.append(str(blockchain[i]["Hash_Anterior"]))#SE AGREGA EL NUMERO EL HASH ANTERIOR
        cadena_final="".join(cadena)#SE CONVIERTE LA LISTA EN UN STRING SIN ESPACIOS
        for y in range(0,len(cadena_final)):#RECORRE TODA LA CADENA HASTA SU ULTIMO CARACTER
            hashx=ord(cadena_final[y])#CAPTURA EL CARACTER Y LO CONVIERTO EN UN NUMEROS SEGUN ASCII
            hashh+=hashx#SUMAMOS EL CARACTER
        hashh=hashh%int(blockchain[i]["Timestamp"])

        if not hashh==blockchain[i]["Hash"]:
            res=False  
            
    if not blockchain[lenght-1]["Hash"]==None:#Verificar que el ultimo bloque no tenga hash
        res=False
    return res    


    #_____________________TRANSACCIONES SEGUN REMITENTE Y DESTINATARIO______________________________# 
    
    

def transacciones_rem_dest(blockchain:list,rem:str,dest:str)->list:#FUNCION QUE RETORINA LA LISTA DE TRANSACCIONES EN DONDE CORRESPONDE REMITENTE Y DESTINATARIO
    res=[]
    x=0
    while x<=len(blockchain)-1:
        i=0
        bloque=blockchain[x]
        while i<=bloque["Cantidad_Transacciones"]-1:
            num=str(i)
            dicc=bloque[num]
            if dicc["Remitente"]==rem and dicc["Destinatario"]==dest :
                res.append(dicc)
            i+=1
        x+=1
    return res
    #_____________________TRANSACCION MAYOR VALOR______________________________#   
def transaccion_mayorvalor(blockchain:list)->dict:#FUNCION QUE RECORRE CADA BLOQUE BUSCANDO LA TRANSACCION CON MAYOR VALOR
    valor=0
    x=0
    while x<=len(blockchain)-1:
        i=0
        bloque=blockchain[x]
        while i<=bloque["Cantidad_Transacciones"]-1:
            num=str(i)
            dicc=bloque[num]
            if float(dicc["Valor"])>valor:
                res=dicc
                valor=float(dicc["Valor"])
            i+=1
        x+=1    
    return res

    #_____________________SALDO DE LA CUENTA______________________________#
def saldocuenta(blockchain:list,id_cuenta:str)->float:#FUNCION QUE SEGUN UNA CUENTA CALCULA EL SUELDO TOTAT, SEGUN SI FUE REMINTENTE DESTINATARIO O SI LA OPERACION ES UN CONTRATO
    saldo=0
    x=0
    while x<=len(blockchain)-1:
        i=0
        bloque=blockchain[x]
        while i<=bloque["Cantidad_Transacciones"]-1:
            num=str(i)
            dicc=bloque[num]
            if dicc["Remitente"]==id_cuenta and dicc["Operacion"]=="Transferencia":
                saldo-=float(dicc["Valor"])
            if dicc["Remitente"]==id_cuenta and dicc["Operacion"]=="Contrato":
                saldo+=float(dicc["Valor"])
            if dicc["Destinatario"]==id_cuenta:
                saldo+=float(dicc["Valor"])
            i+=1
        x+=1    
    return saldo