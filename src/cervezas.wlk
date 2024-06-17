import personas.*
import carpas.*

class Cerveza{
	const property grsLupulo
	const property pais
	var property graduacionReglamentaria = 5
}

class Corona inherits Cerveza{
	const property graduacion
	method precioPorLitro() = 800
}

class Guiness inherits Cerveza{
	method graduacion() = graduacionReglamentaria.min(grsLupulo*2)
	method precioPorLitro() = 1200
}

class Hof inherits Guiness{
	override method graduacion() = super() * 1.25
	override method precioPorLitro() = 1800
}

class Jarra{
	const property litros
	const property marca
	const property servidaEn

	method alcohol() = marca.graduacion() * litros 
}

