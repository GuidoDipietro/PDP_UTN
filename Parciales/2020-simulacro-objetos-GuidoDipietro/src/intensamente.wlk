object riley{ 
	const fechaDeNacimiento = new Date(day=14, month=10, year=2009)
	var felicidad = 1000
	var property emocionDominante = alegria 
	var pensamientoActual
	const recuerdosDelDia = []
	const pensamientosCentrales = #{}
	const recuerdosLargoPlazo = #{}
	
	method felicidad() = felicidad
	method recuerdosDelDia() = recuerdosDelDia
	method recuerdosRecientesDelDia() = recuerdosDelDia.drop(recuerdosDelDia.size() - 5)
	method pensamientosCentrales() = pensamientosCentrales
	method pensamientosCentralesDificiles() = pensamientosCentrales.filter({
		pensamiento => pensamiento.esDificil()
	})
	
	method vivirEvento(descripcion) {
		const recuerdo = new Recuerdo(desc=descripcion, fecha=new Date(), emocion=emocionDominante)
		recuerdosDelDia.add(recuerdo)
	}
	method muyFeliz() = felicidad > 500
	method disminuirFelicidad(pct) {
		const nuevaFelicidad = felicidad*(1-pct)
		if (nuevaFelicidad<1)
			throw new Exception(message="La felicidad no puede ser menor a 1")
		else
			felicidad = nuevaFelicidad
	}
	method hacerPensamientoCentral(recuerdo) {
		pensamientosCentrales.add(recuerdo)
	}
	
	// Procesos al dormir
	method asentarLista(lista){
		lista.forEach({ recuerdo => recuerdo.asentarse(self) })
	}
	method asentamientoSelectivo(palabra){
		self.asentarLista( recuerdosDelDia.filter({ recuerdo => recuerdo.descTiene(palabra) }) )
	}
	method profundizacion(){
		const noCentralesYNoNegadosDeHoy = recuerdosDelDia.filter({
			recuerdo => !pensamientosCentrales.contains(recuerdo) && !emocionDominante.niega(recuerdo.emocion())
		})
		self.asentarLista(noCentralesYNoNegadosDeHoy)
	}
	method controlHormonal(){
		if (
			pensamientosCentrales.any({ pensamiento => recuerdosLargoPlazo.contains(pensamiento) })
			|| recuerdosDelDia.all({ recuerdo => recuerdo.emocion()==recuerdosDelDia.first().emocion() })
		){
			self.disminuirFelicidad(0.15)
			// Saca los 3 mas viejos
			pensamientosCentrales.sortedBy({ pensA, pensB => pensA.fecha() > pensB.fecha() }).take(3).forEach({
				pensamiento => pensamientosCentrales.remove(pensamiento)
			})
		}
	}
	method restauracionCognitiva(){
		felicidad = (felicidad+100).min(1000)
	}
	method liberacionDeRecuerdos() { recuerdosDelDia.clear() }
	
	method dormir() {
		self.asentarLista(recuerdosDelDia)
		self.asentamientoSelectivo("Wollok")
		self.profundizacion()
		self.controlHormonal()
		self.restauracionCognitiva()
		self.liberacionDeRecuerdos()
	}
	
	method niegaAlguno() {
		return recuerdosDelDia.any({ recuerdo => emocionDominante.niega(recuerdo.emocion()) })
	}
	
	method algunoMuyViejo() {
		try
			pensamientoActual = recuerdosLargoPlazo.filter({
				recuerdo => (recuerdo.fecha() - new Date()) > (fechaDeNacimiento - new Date()).div(2)
			}).anyOne()
		catch e
			throw new Exception(message="No tiene recuerdos a largo plazo.")
	}
	method vecesRepetidas(recuerdo) = recuerdosLargoPlazo.occurrencesOf(recuerdo)
	method dejaVu() = self.vecesRepetidas(pensamientoActual) > 1
}

/***** EMOCIONES *****/

class Emocion {
	method condicionEmocion(persona) = true
	method accionEmocion(persona,recuerdo) {}
	method niega(emocion) = false
}
object alegria inherits Emocion {
	override method condicionEmocion(persona) = persona.muyFeliz()
	override method accionEmocion(persona,recuerdo) { persona.hacerPensamientoCentral(recuerdo) }
	override method niega(emocion) = emocion != self
}
object tristeza inherits Emocion {
	override method accionEmocion(persona,recuerdo){
		persona.hacerPensamientoCentral(recuerdo)
		persona.disminuirFelicidad(0.1)
	}
	override method niega(emocion) = emocion == alegria
}
object furia inherits Emocion {}
object disgusto inherits Emocion {}
object temor inherits Emocion {}

class EmocionCompuesta inherits Emocion {
	const emociones
	override method niega(emocion) = emociones.all({ emoc => emoc.niega(emocion) })
	method esAlgre() = emociones.contains(alegria)
	override method condicionEmocion(persona) = emociones.fold(true, {
		acum, emocion => acum && emocion.condicionEmocion(persona)
	})
	override method accionEmocion(persona,recuerdo) {
		emociones.forEach({
			emocion => emocion.accionEmocion(persona, recuerdo)
		})
	}
}

/***** RECUERDOS *****/

class Recuerdo {
	const property desc
	const property fecha
	const property emocion
	method asentarse(persona){
		if (emocion.condicionEmocion(persona))
			emocion.accionEmocion(persona, self)
	}
	method esDificil() = desc.split(" ").size() > 10
	method descTiene(palabra) = desc.split(" ").contains(palabra)
}