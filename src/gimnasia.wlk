class Rutina {
    const intensidad

    method cantidadDeCalorias(tiempo){
        return 100 * (tiempo - self.calcularDescanso(tiempo)) * intensidad
    }

    method calcularDescanso(tiempo)
}

class Running inherits Rutina{    

    override method calcularDescanso(tiempo){
        return if (tiempo > 20){
                    5
                } else { 
                    2 
                }
    }
}

class Maraton inherits Running{

    override method cantidadDeCalorias(tiempo){
        return 2 * super(tiempo)
    }
}

class Remo inherits Rutina{
    
    override method calcularDescanso(tiempo){
        return tiempo/5
    }
}

class RemoCompeticion inherits Remo{
    
    override method calcularDescanso(tiempo){
       return (super(tiempo)-3).max(2) 
    }
}


class Persona{
    var peso
    const property tiempo

    method hacerRutina(rutina){
        peso = peso - self.calcularGastoEnKg(rutina)
    }

    method calcularGastoEnKg(rutina){
        return rutina.cantidadDeCalorias(self.tiempo()) / self.kilosPorCaloria()
    }

    method kilosPorCaloria()
}

class PersonaSedentario inherits Persona{

    override method hacerRutina(rutina){
        if (peso <= 50){
            super(rutina)
        }
    }

    override method kilosPorCaloria() = 7000
}

class PersonaAtleta inherits Persona(tiempo=90){

    
    override method calcularGastoEnKg(rutina){
        return super(tiempo) - 1
    }

    override method hacerRutina(rutina){
        if (rutina.cantidadDeCalorias(tiempo)<10000){
            super(rutina)
        }
    }

    override method kilosPorCaloria() = 8000

}

