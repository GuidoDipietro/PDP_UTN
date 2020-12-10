import objetos.*
import enemigos.*

object buenosAires {
	var alturaObelisco = 10 // un obelisco de porqueria
	
	method coeficienteDefensivo() = alturaObelisco	
	method reforzar() {
		alturaObelisco += 3
		if(alturaObelisco > 20)
			alturaObelisco = 0
	}
	
	method refuerzaRolando() {
		const viejaAltura = alturaObelisco
		
		self.reforzar()
		
		if(viejaAltura > alturaObelisco)
			alturaObelisco = viejaAltura	
	}
}

object mordor {
    var torreSauronSinDanio = false

    method coeficienteDefensivo() {
    	return if(torreSauronSinDanio) 99 else 0
    }
    method reforzar() {
    	torreSauronSinDanio = true //y si no está rota, no va a cambiar nada
    }
    
    method refuerzaRolando() {
    	const viejo_coef = self.coeficienteDefensivo()
    	
    	self.reforzar()
    	
    	if(viejo_coef > self.coeficienteDefensivo())
    		self.reforzar();
    }
}

// MELBOURNE //
// Su coeficiente dest. se calcula como el doble
// de la suma de la resistencia de sus turistas
object melbourne {
	const turistas = [goblin, ruperto] //quiénes visitaron Melbourne
	var deLaPera = false
	
	method visitar(alguien) = turistas.add(alguien)
	method olvidar(alguien) = turistas.remove(alguien) //si Melbourne se ofende
	
	method coeficienteDefensivo(){
		if(not deLaPera)
			return 2 * turistas.sum({
				alguien => alguien.resistencia()
			})
		else return 142749
	}
	
	method reforzar() = {deLaPera = true}
	
	method refuerzaRolando() {
		const viejoCoef = self.coeficienteDefensivo()
		
		self.reforzar()
		
		if(viejoCoef > self.coeficienteDefensivo())
			deLaPera = false
	}
}

object desembarcoDelRey {
    const objetosEnLaCiudad = [collarDivino, espadaDelDestino]
    var incrementoDePoder = false

    method coeficienteDefensivo(){
		if(incrementoDePoder)
			return self.mejorArma().unidades() * 10
		else
			return self.mejorArma().unidades()
    }

    method mejorArma() = objetosEnLaCiudad.max({arma => arma.unidades()})

    method reforzar(){
    	incrementoDePoder = true
    }
    
    method refuerzaRolando() {
    	incrementoDePoder = true //siempre va a mejorar
    }
}