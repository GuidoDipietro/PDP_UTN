import rolando.fuerzaOscura

// Llamamos "unidades" al "poder" de cada arma.

object espadaDelDestino {
	method unidades() = 3
}

object collarDivino {
	var perlas = 5
	
	method modificarPerlas(nuevo) {
		perlas = nuevo
	}	
	method unidades() = perlas
}

object mascaraOscura {
	method unidades() {
		return (fuerzaOscura.valor() / 2).max(4)
	}
}

// Nuevo item (Espada de las espadas) && REQUERIMIENTO 1
object espadaDeLasEspadas {
	const armas = [espadaDelDestino, collarDivino, mascaraOscura]
	
	method unidades() {
		return self.poderArmas() / armas.size()
	}
	
	method poderArmas() {
		return armas.map({arma => arma.unidades()}).sum()
	}
}

//Arma inventada

object pelapapas {
	var papasPeladas = 14
	var esDeOro = false
	
	method pelarPapas(n){
		papasPeladas+=n
	}
	method pelarPapas(){
		papasPeladas+=1
	}
	method toggleMaterial() { esDeOro = not esDeOro }
	method unidades() = if(esDeOro) 14*papasPeladas else papasPeladas
}