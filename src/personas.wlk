import cervezas.*
import carpas.*

class Persona{
	const peso
	const property jarras = []
	const property escuchaMusicaTradicional
	var nivelDeAguante
	
	method comprar(jarra){
		jarras.add(jarra)
	}
	
	method leGusta(unaMarca)
	
	method estaEbrio() = (self.alcoholIngerido()* peso) > nivelDeAguante
	
	method alcoholIngerido() = jarras.sum({ j => j.alcohol()})
	
	method quiereEntrarA(carpa) =
		self.leGusta(carpa.marcaVendida()) and
		(carpa.tieneBandaTradicional() == self.escuchaMusicaTradicional())
	
	method puedeEntrarA(carpa) = self.quiereEntrarA(carpa) and carpa.permiteEntrarA(self)
	
	method entrarA(carpa){
		if (self.puedeEntrarA(carpa)){
			carpa.personasAdentro().add(self)
		}else if (self.estaEbrio()){
			self.error("No puede ingresar ebrio")
		}else{
			self.error("El establecimiento está lleno")
		}
	}
	
	method paisDeOrigen()
	
	method esPatriota() = jarras.all({ j => j.marca() == self.paisDeOrigen() })
	
	method esCompatibleCon(otraPersona){
		const marcas = jarras.map({ j => j.marca() })
		const coincidencias = marcas.count({ m => otraPersona.jarras().contains(m)})
		return coincidencias >= jarras.size()
	}
	
	method carpasDondeTomo() = jarras.map({ j => j.servidaEn() })
	
    method entrandoEnElVicio() {
        var creciente = true
        var i = 0
        jarras.forEach({ j =>
        	if (jarras.get(i).litros() <= jarras.get(i+1).litros()){
        		i += 1
        	}else{
        		creciente = false
        	}})
        return creciente
    }
    
	method dineroGastadoEn(carpa) = jarras.sum({ j => carpa.precioPor(j) })
	
	method jarraMasCara(carpa) = jarras.max({ j => carpa.precioPor(j) })
}

class Belga inherits Persona{
	override method leGusta(unaMarca) = unaMarca.grsLupulo() > 4
	
	override method paisDeOrigen() = "belgica"
}

class Checo inherits Persona{
	override method leGusta(unaMarca) = unaMarca.graduacion() > 8
	
	override method paisDeOrigen() = "checoslovaquia"
}

class Aleman inherits Persona{
	override method leGusta(unaMarca) = true
	
	override method quiereEntrarA(carpa) = super(carpa) and carpa.cantidadDePersonas() % 2 == 0
	
	override method paisDeOrigen() = "alemania"
}

