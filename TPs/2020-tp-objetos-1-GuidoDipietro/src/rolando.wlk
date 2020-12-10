object rolando {
	const hechBase = 3
	const luchaBase = 1
	var hechPref = hechizoBasico
	var artefacto = mascaraOscura
	method nivelDeHechiceria(){
		return hechBase*(hechPref.poder()) + fuerzaOsc.valor()
	}
	method valorDeLucha(){
		return luchaBase+artefacto.unidadesLucha()
	}
	method cambiarHechizoPreferido(h){
		hechPref = h
	}
	method leGanaA(enemigo){
		const polenta = (self.nivelDeHechiceria()).max(self.valorDeLucha())
		return (polenta) > enemigo.resistencia()
	}
	method equiparArtefacto(a){
		artefacto = a
	}
}

object python {
	method unidadesLucha(){
		return 1000000000
	}
}

object java {
	var lentitud = 500
	const platoFavorito = "spaghetti"
	method resistencia(){
		return (lentitud ** 2 + fuerzaOsc.valor()).min(142749)
	}
	method ralentizar() {
		lentitud += 100
	}
	method platoFavorito(){
		return platoFavorito
	}
}

object goblin {
	method resistencia(){
		return 5
	}
}

object elfoOscuro {
	method resistencia(){
		return 2+fuerzaOsc.valor()
	}
}

object mascaraOscura {
	method unidadesLucha(){
		return (fuerzaOsc.valor()/2).max(4)
	}
}

object espadaDelDestino {
	method unidadesLucha(){
		return 3
	}
}

object collarDivino {
	var perlas = 73
	method unidadesLucha(){
		return perlas
	}
	method agregarPerlas(n){
		perlas += n
	}
}

object espectroMalefico {
	var nombre = "espectro malefico"
	method poder(){
		return nombre.length()
	}
	method esPoderoso(){
		return self.poder()>15
	}
	method nuevoNombre(n){
		nombre = n
	}
}

object hechizoBasico {
	method poder(){
		return 10
	}
	method esPoderoso(){
		return self.poder()>15
	}
}

object fuerzaOsc {
	var valor = 5
	method valor(){
		return valor
	}
	method eclipse(){
		valor *= 2
	}
}