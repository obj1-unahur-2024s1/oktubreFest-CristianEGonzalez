import cervezas.*
import personas.*

class Carpa{
	const property limite
	const property tieneBandaTradicional
	const property marcaVendida
	const property personasAdentro = []
	var property cantidadDePersonas = personasAdentro.size()
	var property recargo //Esta variable recibe el objeto según el tipo de recargo
	
	method permiteEntrarA(persona) =
		cantidadDePersonas <= limite and
		!persona.estaEbrio()
	
	method servirJarraA(persona,lts){
		const unaJarra = new Jarra(marca=marcaVendida,litros=lts,servidaEn=self)
		persona.jarras().add(unaJarra)
	}
	
	method ebriosEmpedernidos(){ return
		personasAdentro.count({ p =>
			p.jarras().all({ j => j.litros() >= 1 })
		})	
	}
	
	method esHomogenea(){
		const nacionalidades = #{}
		personasAdentro.forEach({ p => nacionalidades.add(p.paisDeOrigen()) })
		return nacionalidades.size() == 1
	}
	
	method noTomaronAqui() = personasAdentro.filter({ p =>
		!p.carpasDondeTomo().contains(self)
		})
	
	method precioPorLitro() = self.marcaVendida().precioPorLitro() * recargo.porcentaje(self) 
	
	method precioPor(jarra) = self.precioPorLitro() * jarra.litros()
}

object recargoFijo{
	method porcentaje(carpa) = 1.3
}
object recargoPorCantidad{
	method porcentaje(carpa) = if (carpa.cantidadDePersonas() / 2 > carpa.limite()) 1.4 else 1.25
}
object recargoPorEbriedad{
	method porcentaje(carpa) = if ( (carpa.personasAdentro().count({ p => p.estaEbrio()}) / carpa.cantidadDePersonas()) >= 0.75) 50 else 20
}