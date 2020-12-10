import rolando.fuerzaOscura
import hechizos.*

object goblin {
	method resistencia() = 5
}

object elfoOscuro {
	method resistencia() {
		return 2 + fuerzaOscura.valor()
	}
}

object cthulu {
	var enloquecido = false
	method enloquecer() { enloquecido = true }
	method tranquilizar() { enloquecido = false } //en vez de un "toggle", pintó
	
	method resistencia() {
		return if(enloquecido) 666666666 else (fuerzaOscura.valor() * 10).min(300)
	}
}

// Ruperto el mago
object ruperto {
	const hechizos = [espectroMalefico, hechizoInservible, hechizoBasico]

	method hechizoMasDebil() {
		return hechizos.min({ hechizo => hechizo.poder() })
	} 

	method resistencia() {
		if(self.hechizoMasDebil().esPoderoso())
			return 0
		else
			return self.hechizoMasDebil().poder() * 10
	}
}

object marcelo {
	const soldados = [goblin, elfoOscuro, cthulu]
	var conflictoGremial = false

	method mejorSoldado() = soldados.max({soldado => soldado.resistencia()})

	method rendimiento() {
		if(conflictoGremial)
			return soldados.size() * 2
		else
			return self.mejorSoldado().resistencia()		
	}
	
	method cambiarConflictoGremial(){
		conflictoGremial = not conflictoGremial
	}
}