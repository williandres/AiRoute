class PasapalosVenezolanos:

    def __init__(self, precio_unidad, numero_racion, relleno):
        self.precio_unidad = precio_unidad
        self.numero_racion = numero_racion
        self.relleno = relleno
    
    def precio_plato(self):
        return self.precio_unidad * self.numero_racion

class Arepa(PasapalosVenezolanos):

    def __init__(self, precio_unidad, numero_racion, relleno, tipo_de_preparacion, tipo_hmaiz):
        super().__init__(precio_unidad, numero_racion, relleno)
        self.tipo_de_preparacion = tipo_de_preparacion # horno, frita, asada
        self.tipo_hmaiz = tipo_hmaiz # harina de maiz blanco / amarilla

class Tequeno(PasapalosVenezolanos):

    def __init__(self, precio_unidad, numero_racion, relleno, tipo_masa):
        super().__init__(precio_unidad, numero_racion, relleno)
        self.tipo_masa = tipo_masa # masa tradicional, masa cachapa

class Pastelito(PasapalosVenezolanos):

    def __init__(self, precio_unidad, numero_racion, relleno, tipo_salsa):
        super().__init__(precio_unidad, numero_racion, relleno)
        self.tipo_salsa = tipo_salsa # de ajo, rosada, picante, tartara