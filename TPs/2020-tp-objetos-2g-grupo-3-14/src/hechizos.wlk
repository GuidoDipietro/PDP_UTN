object espectroMalefico {
	var nombre = "espectroMalefico"
	
	method cambiarNombre(nuevo) {
		nombre = nuevo
	}
	method poder() = nombre.length()
	method esPoderoso() = self.poder() > 15
}

object hechizoInservible {
	method poder() = 0
	method esPoderoso() = false
}

object hechizoBasico {
	method poder() = 10
	method esPoderoso() = false
}