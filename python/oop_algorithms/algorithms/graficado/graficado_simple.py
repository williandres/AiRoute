from bokeh.plotting import figure, output_file, show

if __name__ == '__main__':
    output_file('graficado_simple.html')
    fig = figure()
    print(type(fig))#Ver que tipo de dato es
    #help(fig)#Ver que metodos se pueden usar
    total_vals = int(input('Cuantos valores quieres graficar?'))
    x_vals = list(range(total_vals))#Generamos una lista con este buen shortcut que nos permite generar numeros de una lista independiente
    y_vals = []

    for x in x_vals:
        val = int(input(f'Valor y para {x}: '))
        y_vals.append(val)

    fig.line(x_vals, y_vals, line_width=2)
    show(fig)#metodo de bokeh
    print('Pummm')
