class Pais {
	var property nombre // el nombre podría cambiar!!
	var property pbi
	var property habitantes
	var property accesoUniversidad // porcentaje, 100% = 1
	const property deciles
}

// Países

const argentina = new Pais(
	nombre = "Argentina",
	pbi = 1,
	habitantes = 45000000,
	accesoUniversidad = 0.2,
	deciles = [4290, 9807, 13681, 16199, 19259, 24101, 29614, 36642, 46579, 87758]
)

const tuvalu = new Pais(
	nombre = "Tuvalu",
	pbi = 14,
	habitantes = 10000,
	accesoUniversidad = 0.05,
	deciles = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]
)

const australia = new Pais(
	nombre = "Australia",
	pbi = 1000,
	habitantes = 20000000,
	accesoUniversidad = 0.8,
	deciles = [10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000]
)

// Son países, pero los defino así para ahorrarme tiempo inventando datos (son las 11:51)
object colombia {}
object bolivia {}
object suecia {}
object noruega {}
object ecuador {}

// Mundo

object mundo {
	const property paises = [argentina, tuvalu, australia]
	method mejorPais() = paises.max({ pais => indiceMejorPais.valor(pais) })
}

// Índices

object pbiPerCapita {
	method valor(pais) = (pais.pbi() / pais.habitantes())
}
object gini {
	method valor(pais) = (pais.deciles().max()) / (pais.deciles().min())
}
object ingresosAltos {
	method valor(pais) = pais.deciles().max()
}
object accesoUniversidad {
	method valor(pais) = pais.accesoUniversidad()
}
object nombrista {
	method valor(pais) = 10*pais.nombre().length()
}
object cantDecilesPares {
	method valor(pais) = pais.deciles().count({decil => decil.even()})
}
object mediaDeciles {
	method valor(pais) = (pais.deciles().sum() / pais.deciles().size())
}
object indiceMejorPais {
	method valor(pais) = (pais.pbi() + pais.accesoUniversidad()*1000 + mediaDeciles.valor(pais))
}