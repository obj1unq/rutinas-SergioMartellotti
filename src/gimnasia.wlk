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
    var property peso // para test
    const property tiempo

    method hacerRutina(rutina){
        self.validarRutina(rutina)
        peso = peso - self.calcularGastoEnKg(rutina)
    }

    method calcularGastoEnKg(rutina){
        return rutina.cantidadDeCalorias(self.tiempo()) / self.kilosPorCaloria()
    }

    method validarRutina(rutina){
        if (!self.puedeHacerRutina(rutina)){
            self.error("No se puede hacer la rutina.")
        }
    }

    method kilosPorCaloria()
    method puedeHacerRutina(rutina)

}

class PersonaSedentario inherits Persona{

    override method puedeHacerRutina(rutina) = peso > 50

    override method kilosPorCaloria() = 7000
}

class PersonaAtleta inherits Persona(tiempo=90){
    
    override method puedeHacerRutina(rutina) = rutina.cantidadDeCalorias(self.tiempo())>=10000

    override method kilosPorCaloria() = 8000
 
    override method calcularGastoEnKg(rutina){
        return super(rutina) - 1
    }
}


class Club{
    const predios = []

    method mejorPredioPara_(persona){
        return predios.max({predio => predio.sumaDeRutinas(persona)})
    }

    method prediosTranquis(persona){
        return predios.filter({predio => predio.esPredioTranqui(persona)})
    }


    method rutinasMasExigentes(persona){
        return predios.map({predio => predio.rutinaMasExigente(persona)})
    }
}

class Predio{
    const rutinas

    method sumaDeRutinas(persona){
    return rutinas.sum({rutina => rutina.cantidadDeCalorias(persona.tiempo())})
    }



    method rutinaMasExigente(persona){
        return rutinas.max({rutina => rutina.cantidadDeCalorias(persona.tiempo())})
    }

    method esPredioTranqui(persona){
        return rutinas.any({rutina => self.esRutinaTranqui(rutina,persona)})
    }

    method esRutinaTranqui(rutina,persona){
        return rutina.cantidadDeCalorias(persona.tiempo())<500
    }
}

