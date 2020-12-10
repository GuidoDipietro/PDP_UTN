import mundo.*

class Articulo {
	var property titulo
	var property cifraDestacada
	var property autor
}

class Analista {
	var property nombre
	var indice = null
	
	method escribirArticulo(pais) {
		return new Articulo(
			titulo = self.titulo(pais),
			cifraDestacada = null,
			autor = nombre
		)
	}
	
	// Abstractos
	method titulo(pais)
	method cifraDestacada(pais) = indice.valor(pais)
}

class AnalistaClasico inherits Analista {
	constructor() {
		indice = pbiPerCapita
	}
//	override method cifraDestacada(pais) = pbiPerCapita.valor(pais)
	override method titulo(pais) = "La situacion en " + pais.nombre()
}

class AnalistaRebelde inherits Analista {
	constructor() {
		indice = indiceMejorPais
	}
	override method titulo(pais) = "Mejor país del mundo"
//	override method cifraDestacada(pais) = indiceMejorPais.valor(pais)
	override method escribirArticulo(pais) {
		return super(mundo.mejorPais())
	}
}

class AnalistaPanqueque inherits Analista {
	const paisesQueSimpatiza // lista
	var property indicePositivo
	var property indiceNegativo
	
	override method titulo(pais) = "La columna económica de " + self.nombre()
	override method cifraDestacada(pais) {
		if (paisesQueSimpatiza.contains(pais))
			return indicePositivo.valor(pais)
		else
			return indiceNegativo.valor(pais)
	}
	override method escribirArticulo(pais) {
		const articulo = super(pais)
		articulo.cifraDestacada(self.cifraDestacada(pais))
		return articulo
	}
}

class AnalistaSalieri inherits Analista {
	var autorAPlagiar = new AnalistaRebelde(nombre="Prueba")
	
	override method escribirArticulo(pais) {
		return autorAPlagiar.escribirArticulo(pais)
	}
	method cambiarAutorAPlagiar() { autorAPlagiar = diario.analistas().anyOne() }
	// No usa esto porque se copia
	override method titulo(pais) = null
	override method cifraDestacada(pais) = null
}

class AnalistaWollok inherits Analista {	
	var property socio
	constructor(newSocio) {
		socio = newSocio
		indice = indiceMejorPais
	}
	
	override method titulo(pais) = "El impacto de Wollok en " + pais.nombre()
	override method escribirArticulo(pais) {
		const articulo = super(pais)
		articulo.autor(nombre + " y " + socio.nombre())
		return articulo
	}
//	override method cifraDestacada(pais) = indiceMejorPais.valor(pais)
}

// Analistas
const estebanQuito = new AnalistaPanqueque(
	nombre = "Esteban Quito",
	paisesQueSimpatiza = [colombia, ecuador, bolivia, argentina],
	indicePositivo = accesoUniversidad,
	indiceNegativo = gini
)
const soniaDora = new AnalistaPanqueque(
	nombre = "Sonia Tuvalu Dora",
	paisesQueSimpatiza = [suecia, noruega],
	indicePositivo = ingresosAltos,
	indiceNegativo = nombrista
)
const mark = new AnalistaSalieri(
	nombre = "Mark Zuckerberg",
	autorAPlagiar = estebanQuito
)
const chocolato = new AnalistaWollok(
	nombre = "Amilcar Chocolato Argentina",
	socio = mark
)
//Como ellos (panqueques) podría haber otros, pero se destaca Juanci Payo,
//quien sin escrúpulos y más allá de las estrategias que utiliza,
//el único país que no es de su agrado es Argentina.
//Además, cuando escribe un artículo, a la cifra destacada la exagera en un 50%.
object juanciPayo inherits AnalistaPanqueque {
	override method cifraDestacada(pais) {
		if (pais!=argentina)
			return indicePositivo.valor(pais)*1.5
		else
			return indiceNegativo.valor(pais)*1.5
	}
	override method nombre() = "Juan Cipayo"
}

// Diario //

object diario {
	const property analistas = []
	const property articulos = []
	
	method contratar(analista) = analistas.add(analista)
	method analistasAptosParaEscribir(pais) {
		return analistas.filter({ analista =>
			!analista.nombre().words().contains(pais.nombre()) &&
			articulos.count({ articulo => articulo.autor()==analista }) < 3
		})
	}
	
	method edicion(pais) {
		self.analistasAptosParaEscribir(pais).forEach({
			analista => articulos.add(analista.escribirArticulo(pais))
		})
	}
}

