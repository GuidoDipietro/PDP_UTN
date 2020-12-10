import wollok.lib.*
import wollok.lang.*

/****** BARCOS ******/
class BarcoPirata {
	const property tripulacion = []
	const capacidadMax
	var property mision
	const property tipo = "barco"
	
	method reclutar(tripulante) {
		if(tripulante.puedeCumplir(mision) && self.tieneLugar())
			tripulacion.add(tripulante)
	}
	method cambiarDeMision(nuevaMision) {
		mision = nuevaMision
		tripulacion.removeAllSuchThat({
			tripulante => !(tripulante.puedeCumplir(nuevaMision))
		})
	}
	method esTemible() {
		return (
			self.suficienteTripulacion() && 
			mision.puedeCumplir(self) &&
			tripulacion.forEach({ tripulante => mision.pirataCumpleCondicion(tripulante) })
		)
	}
	
	method anclarEn(ciudad) {
		// Todos compran un souvenir de la ciudad
		tripulacion.forEach({
			tripulante => tripulante.comprar(
				ciudad.souvenir()
			)
		})
		// Se va el que quedó más pobre
		tripulacion.remove(
			tripulacion.min({
				tripulante => tripulante.monedas()
			})
		)
		
		ciudad.agregarHabitante()
	}
	method pirataConMasPertenencias() = tripulacion.max({ tripulante => tripulante.numPertenencias() })
	method cantidadTripulantes() = tripulacion.size()
	method suficienteTripulacion() = (self.cantidadTripulantes() / capacidadMax) >= 0.9
	method tieneLugar() = tripulacion.size() < capacidadMax
}

object holandesErrante inherits BarcoPirata {
	method mensajeTripulacion() = throw new MessageNotUnderstoodException(message = "No sabemos nada de la tripulacion")
	
	override method cantidadTripulantes() = self.mensajeTripulacion()
	override method tripulacion() = self.mensajeTripulacion()
	override method esTemible() = true
	override method tieneLugar() = false // Para no poder reclutar mas
}

/****** PIRATAS / ESPÍAS ******/
class Pirata {
	var property monedas = 14
	const pertenencias = [] // lista
	var habilidad
	
	method tiene(pertenencia) = pertenencias.any({p => p.nombre() == pertenencia})
	method numPertenencias() = pertenencias.size()
	method puedeCumplir(mision) = mision.pirataCumpleCondicion(self)
	method pertenencias() = pertenencias
	
	method tieneElMapaDeLaCiudad(ciudad) {
		// El pirata puede tener mas de un mapa en sus pertenencias
		const mapasPirata = pertenencias.filter({pertenencia => pertenencia.nombre() == 'mapa'})
		
		return mapasPirata.any({mapa => mapa.ciudad() == ciudad})
	}
	
	method comprar(cosa) {
		if (monedas >= cosa.precio()){
			monedas -= cosa.precio()
			pertenencias.add(cosa)
		}
	}
	
	method seAnimaASaquear(objetivo) {
		if (objetivo.tipo() == "barco")
			return habilidad == "saqueos"
		else if (objetivo.tipo() == "ciudad")
			return self.tieneElMapaDeLaCiudad(objetivo.nombre())
		else
			return false // Si es otra cosa no se anima
	}
}

class Espia inherits Pirata {
	override method puedeCumplir(mision) = true
	override method seAnimaASaquear(algo) {
		return (super(algo) && self.tiene(permisoDeLaCorona))
	}
}

/****** CIUDADES Y SOUVENIRS ******/
class Ciudad {
	var property habitantes
	const property nombre
	const property souvenir
	const property tipo = "ciudad"
	
	method agregarHabitante() {
		habitantes += 1
	}
}

/****** PERTENENCIAS ******/
class Pertenencia {
	const property precio
	const property nombre
}

const papa = new Pertenencia(precio = 0, nombre="papa")
const permisoDeLaCorona = new Pertenencia(precio = 1, nombre="permisoDeLaCorona")
const alfajores = new Pertenencia(precio = 2, nombre="alfajores")
const brujula = new Pertenencia(precio = 5, nombre="brujula")
const llaveCofre = new Pertenencia(precio = 1, nombre="llave de cofre")
const polvoDeHada = new Pertenencia(precio = 9, nombre="polvo de hada")
const garfio = new Pertenencia(precio = 6, nombre="garfio")

class Mapa inherits Pertenencia { 
	const property ciudad
}

const mapaMdq = new Mapa(precio = 4, nombre="mapa", ciudad="mar del plata")

/* MISIONES */
class BusquedaDelTesoro {
	method pirataCumpleCondicion(pirata) {
		return (pirata.tiene(brujula) || pirata.tiene("mapa")) && pirata.monedas() <= 5
	}
	
	method puedeCumplir(barco) {
		return barco.tripulacion().any({ pirata => pirata.tiene(llaveCofre) })
	}
}

/*
	Otra opcion seria poner todo ConvertirseEnLeyenda en solo una clase y poner el nivel de
	riqueza en 0, pero dice en la consigna que estas son otra "clase" de mision
*/

class ConvertirseEnLeyenda {
	const elementoIndispensable
	method pirataCumpleCondicion(pirata) {
		return pirata.numPertenencias() >= 10 && pirata.tiene(elementoIndispensable)
	}
	
	method puedeCumplir(barco) = true // Sin condiciones especiales
}

class ConvertirseEnLeyendaPuntual inherits ConvertirseEnLeyenda {
	const riqueza
	
	override method pirataCumpleCondicion(pirata) {
		return super(pirata) && pirata.monedas() > riqueza
	}
}

class Saqueo {
	var cantMinDeMonedas
	const objetivo
	method pirataCumpleCondicion(pirata) {
		return pirata.monedas() < cantMinDeMonedas && pirata.seAnimaASaquear(objetivo)
	}
	
	method puedeCumplir(barco) {
		if(objetivo.tipo() == "barco")
			return barco.cantidadTripulantes() > objetivo.cantidadTripulantes() * 2
		else if(objetivo.tipo() == "ciudad")
			return barco.cantidadTripulantes() >= objetivo.habitantes() * 0.4
		else
			return false
	}
}