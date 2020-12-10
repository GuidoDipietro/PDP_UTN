import hechizos.*
import objetos.*
import enemigos.*
import ciudades.*

object fuerzaOscura {
	var valor = 5
	
	method valor() = valor	
	method eclipse() {
		valor = valor*2
	}
}

object rolando {
	var hechizoPreferido = espectroMalefico
	var artefactoEquipado = collarDivino
	const ejercitoAliado = []
	
	// MÉTODOS DE PRIMERA PARTE DEL TP //
	method cambiarHechizo(nuevo) {
		hechizoPreferido = nuevo
	}
	method cambiarArtefacto(nuevo) {
		artefactoEquipado = nuevo
	}
	method leGana(enemigo) = return enemigo.resistencia() < self.mayorPoder() //modificado por método de parte 2 del TP
	
	method nivelDeHechiceria() {
		return 3 * hechizoPreferido.poder() + fuerzaOscura.valor()
	}
	method valorDeLucha() {
		return 1 + artefactoEquipado.unidades()
	}
	method hechizoPreferido() = hechizoPreferido
	// END PRIMERA PARTE //
	
	// PARTE DEL TP GRUPAL //
	
	// Ejército //
	method ejercito() = ejercitoAliado //equivale a { return ejercitoAliado }
	method reclutar(personaje) = ejercitoAliado.add(personaje)
	method rajar(personaje) = ejercitoAliado.remove(personaje)

	// REQUERIMIENTO 2
	method poderioEjercitoAliado() {
		return self.mayorPoder() + self.resistenciaTotalEjercito()
	}
	method mayorPoder() {
		return self.valorDeLucha().max(self.nivelDeHechiceria())
	}
	method resistenciaTotalEjercito() {
		return ejercitoAliado.sum({ guerrero => guerrero.resistencia() })
	}
	// REQUERIMIENTO 4
	
	method puedeDefenderCiudadEnemigo(ciudad, ejercito) {
		const poderEjercito = ciudad.coeficienteDefensivo() * self.poderioEjercitoAliado()
		const poderEnemigo = ejercito.sum({ guerrero => guerrero.resistencia() })
		
		return poderEnemigo < poderEjercito && ejercito.all({enemigo => self.leGana(enemigo)})
	}
	
	// REQUERIMIENTO 5
	
	method reforzarCiudad(ciudad){
		ciudad.refuerzaRolando()
	}
	
	method reforzarCiudades(ciudades){
		ciudades.forEach({
			ciudad => self.reforzarCiudad(ciudad) // lo uso acá
		})
	}
}
