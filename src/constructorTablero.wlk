import wollok.game.*
import franky.*
import Direcciones.*
import enemigos.*
import ayudas.*

object pared {
	method image() = "wall.png"
	method chocarCon(jugador){
		jugador.direccion().retroceder(jugador)
	}
}


object mapa1  {
	var  property posicionFranky=game.at(1,1)
	var property posicionFinalFranky=game.at(19,1)
	var puerta = new Puerta(position = game.at(19,1))
	var palanca = new Palanca(position = game.at(2,4),objetoCerrado=puerta) 
	var gema1 = new Gema()
	var gema2 = new Gema()
	var gema3 = new Gema()
	
	var lobo1 = new Lobo(posicionInicial = game.at(9,8), direccionInicial = izquierda)
	var lobo2 = new Lobo(posicionInicial = game.at(15,4), direccionInicial = izquierda)
	var murcielago1 = new Murcielago(posicionInicial = game.at(15,11), direccionInicial = abajo)
	var arquero1 = new Arquero(posicionInicial = game.at(6,1), direccionInicial = derecha,flecha=null)	
	var pinches = new Pinche(position = game.at(2,7), posicionInicial = game.at(2,7), direccionInicial = null)
	
	method agregarAyudas(){
		game.addVisualIn(gema1, game.at(18,11))
		game.addVisualIn(gema2, game.at(10,2))
		game.addVisualIn(gema3, game.at(18,6))
		constructorTablero.agregarPalancaTablero(palanca)
		game.addVisual(puerta)
		
		game.hideAttributes(gema1)
		game.hideAttributes(gema2)
		game.hideAttributes(gema3)
		
		game.hideAttributes(puerta)
		game.hideAttributes(palanca)
	}
	
	method agregarVidas(){
		game.addVisualIn(vida3, game.at(18,12))
		game.addVisualIn(vida2, game.at(17,12))
		game.addVisualIn(vida1, game.at(16,12)) 
		
		game.hideAttributes(vida1)
		game.hideAttributes(vida2)
		game.hideAttributes(vida3)
	}
	
	method agregarEnemigos(){		
		lobo1.agregarEnTablero() 
		lobo2.agregarEnTablero()
		murcielago1.agregarEnTablero()
		arquero1.agregarEnTablero()
		pinches.agregarEnTablero()
		
		arquero1.disparar(300)
		lobo1.moverse()
		lobo2.moverse()
		murcielago1.moverse()
		pinches.subirYBajar()
		
		game.hideAttributes(lobo1) 
		game.hideAttributes(lobo2)
		game.hideAttributes(murcielago1)
		game.hideAttributes(arquero1)
		game.hideAttributes(pinches)
	}
	
	method agregarParedes(){
		//PARED IZQUIERDA
		constructorTablero.constructorVertical(0,12,0,pared)
		
		//PARED ARRIBA
		constructorTablero.constructorHorizontal(1,19,12,pared)
		
		//PARED DERECHA
		constructorTablero.constructorVertical(19,11,2,pared)
		
		//PARED ABAJO
		constructorTablero.constructorHorizontal(1,19,0,pared)
	}
	method removerLaberinto(cantidadParedes){
		(0 .. cantidadParedes-1).forEach({n => game.removeVisual(pared)})
	}
	
	method agregarLaberinto() {
		
		constructorTablero.constructorHorizontal(3,1,1,pared)
		
		constructorTablero.constructorVertical(1,0,3,pared)
		constructorTablero.constructorVertical(1,0,7,pared)
		constructorTablero.constructorVertical(1,0,8,pared)
		
		constructorTablero.constructorVertical(2,0,3,pared)
		constructorTablero.constructorVertical(2,0,5,pared)
		constructorTablero.constructorVertical(2,0,10,pared)
		
		constructorTablero.constructorVertical(3,7,3,pared)
		
		constructorTablero.constructorVertical(4,0,1,pared)
		constructorTablero.constructorVertical(4,0,7,pared)
		constructorTablero.constructorVertical(4,0,9,pared)
		
		constructorTablero.constructorVertical(5,3,1,pared)
		
		constructorTablero.constructorVertical(5,0,11,pared)
		
		constructorTablero.constructorVertical(6,5,2,pared)
		
		constructorTablero.constructorVertical(6,2,9,pared)

		constructorTablero.constructorVertical(7,1,2,pared)
		
		constructorTablero.constructorVertical(7,0,7,pared)
		
		constructorTablero.constructorVertical(8,0,5,pared)
		constructorTablero.constructorVertical(8,0,7,pared)
		constructorTablero.constructorVertical(8,1,9,pared)
		
		constructorTablero.constructorVertical(9,3,2,pared)
		constructorTablero.constructorVertical(9,0,7,pared)
		constructorTablero.constructorVertical(9,0,9,pared)
		
		constructorTablero.constructorVertical(10,0,3,pared)
		constructorTablero.constructorVertical(10,2,7,pared)
		constructorTablero.constructorVertical(10,0,11,pared)
		
		constructorTablero.constructorVertical(11,1,2,pared)
		constructorTablero.constructorVertical(11,2,5,pared)
		constructorTablero.constructorVertical(11,0,11,pared)
		
		constructorTablero.constructorVertical(12,0,3,pared)
		constructorTablero.constructorVertical(12,0,7,pared)
		constructorTablero.constructorVertical(12,2,9,pared)
		
		constructorTablero.constructorVertical(13,0,3,pared)
		constructorTablero.constructorVertical(13,0,5,pared)
		constructorTablero.constructorVertical(13,0,7,pared)

		constructorTablero.constructorVertical(14,0,1,pared)
		constructorTablero.constructorVertical(14,0,3,pared)
		constructorTablero.constructorVertical(14,0,5,pared)
		constructorTablero.constructorVertical(14,3,7,pared)
		
		constructorTablero.constructorVertical(15,0,1,pared)
		constructorTablero.constructorVertical(15,0,3,pared)
		constructorTablero.constructorVertical(15,0,5,pared)
		
		constructorTablero.constructorVertical(16,0,1,pared)
		constructorTablero.constructorVertical(16,2,3,pared)
		constructorTablero.constructorVertical(16,0,8,pared)
		constructorTablero.constructorVertical(16,1,10,pared)
		
		constructorTablero.constructorVertical(17,0,1,pared)
		constructorTablero.constructorVertical(17,4,4,pared)
	
		constructorTablero.constructorVertical(18,3,7,pared)
	}
	
	method agregarFranky() { 
		game.addVisual(franky)
		franky.move(posicionFranky)
	}
}

object mapa2{
	//var contadorDeAgua 	
	var property posicionFranky=game.at(0,6)
	var property posicionFinalFranky=game.at(19,1)
	var arquero1 = new Arquero(posicionInicial = game.at(18,1), direccionInicial = izquierda, flecha = null)
	var arquero2 = new Arquero(posicionInicial = game.at(18,2), direccionInicial = izquierda, flecha = null)
	var arquero3 = new Arquero(posicionInicial = game.at(4,11), direccionInicial = abajo, flecha = null)
	var arquero4 = new Arquero(posicionInicial = game.at(10,8), direccionInicial = arriba, flecha = null)
	var arquero5 = new Arquero(posicionInicial = game.at(10,7), direccionInicial = abajo, flecha = null)
	var arquero6 = new Arquero(posicionInicial = game.at(8,7), direccionInicial = arriba, flecha = null)
	var arquero7 = new Arquero(posicionInicial = game.at(15,11), direccionInicial = abajo, flecha = null)
	
	method agregarFranky(){
		game.addVisual(franky)
		franky.move(posicionFranky)
		franky.imagen("franky-right.png")
		franky.direccion(izquierda)
	}
	
	method agregarVidas(){
		game.addVisualIn(vida3, game.at(18,12))
		game.addVisualIn(vida2, game.at(17,12))
		game.addVisualIn(vida1, game.at(16,12)) 
		
		game.hideAttributes(vida1)
		game.hideAttributes(vida2)
		game.hideAttributes(vida3)
	}
	
	method agregarLaberinto(){
		
		constructorTablero.constructorHorizontal(1,6,5,agua)
		constructorTablero.constructorHorizontal(1,6,4,agua)
		
		constructorTablero.constructorHorizontal(1,4,7,agua)
		constructorTablero.constructorHorizontal(1,4,8,agua)
		constructorTablero.constructorHorizontal(1,4,9,agua)
		constructorTablero.constructorHorizontal(1,4,10,agua)
		constructorTablero.constructorHorizontal(1,2,11,agua)
		constructorTablero.constructorHorizontal(5,0,11,agua)
		
		constructorTablero.constructorVertical(7,3,7,agua)
		constructorTablero.constructorVertical(8,2,8,agua)
		constructorTablero.constructorVertical(9,3,7,agua)
		constructorTablero.constructorVertical(10,1,9,agua)
		constructorTablero.constructorVertical(11,3,7,agua)
		
		constructorTablero.constructorHorizontal(13,5,10,agua)
		constructorTablero.constructorHorizontal(13,1,11,agua)
		constructorTablero.constructorHorizontal(16,2,11,agua)
		
		constructorTablero.constructorHorizontal(13,4,8,agua)
		constructorTablero.constructorHorizontal(13,4,7,agua)
		constructorTablero.constructorHorizontal(7,10,6,agua)
		constructorTablero.constructorHorizontal(9,10,4,agua)
		constructorTablero.constructorHorizontal(9,10,3,agua)
	}
	
	method agregarEnemigos() {
		arquero1.agregarEnTablero()
		arquero2.agregarEnTablero()
		arquero3.agregarEnTablero()
		arquero4.agregarEnTablero()
		arquero5.agregarEnTablero()
		arquero6.agregarEnTablero()
		arquero7.agregarEnTablero()
		
		arquero1.disparar(300)
		arquero2.disparar(400)
		arquero3.disparar(300)
		arquero4.disparar(500)
		arquero5.disparar(400)
		arquero6.disparar(400)
		arquero7.disparar(500)
	}
	
	method agregarAyudas(){}
	
	method agregarParedes(){
		//PARED IZQUIERDA
		constructorTablero.constructorVertical(0,4,1,pared)
		constructorTablero.constructorVertical(0,4,7,pared)
		
		//PARED ARRIBA
		constructorTablero.constructorHorizontal(0,19,12,pared)
		
		//PARED DERECHA
		constructorTablero.constructorVertical(19,12,1,pared)
		
		//PARED ABAJO
		constructorTablero.constructorHorizontal(0,15,0,pared)
		constructorTablero.constructorHorizontal(17,2,0,pared)
	}
}

//va a ser el objeto que va a ir generando los diferentes mapas
// por ahora lo uso para reestablecer los elementos del tablero al morir
object constructorTablero {
	var property enemigosDerrotados=[]	
	var property palancas=[]
	const property mapas = [mapa1, mapa2]
	var property cantidadParedes=0
	var property nroMapaActual=1
	
	method nuevoEnemigoDerrotado(enemigo){ enemigosDerrotados.add(enemigo) }
	
	method agregarPalancaTablero(palanca){
		game.addVisual(palanca)
		palancas.add(palanca)
	}
	
	method reestablecerEnemigos(){ enemigosDerrotados.forEach({enemigo => enemigo.agregarEnTablero()}) }
	
	method desactivarPalancas(){ palancas.forEach({palanca => palanca.desactivar()}) }
	
	method cargarMapa(){
		mapas.get(nroMapaActual).agregarParedes()
		mapas.get(nroMapaActual).agregarLaberinto()
		mapas.get(nroMapaActual).agregarVidas()
		mapas.get(nroMapaActual).agregarEnemigos()
		mapas.get(nroMapaActual).agregarAyudas()
		mapas.get(nroMapaActual).agregarFranky()
	}
	method pasarDeNivel(){
		self.borrarMapa()
		nroMapaActual++
		self.cargarMapa()
	}
	
	method constructorVertical(x,cantidadDeBloques,y,algo){
		(y .. y+cantidadDeBloques).forEach({n => game.addVisualIn(algo, game.at(x,n))
		cantidadParedes++		
		}) 
	}
	
	method constructorHorizontal(x,cantidadDeBloques,y,algo){
		(x .. cantidadDeBloques+x).forEach({n => game.addVisualIn(algo, game.at(n,y))	
		cantidadParedes++
		}) 
	}
	method posicionInicialFranky(){
		return mapas.get(nroMapaActual).posicionFranky()
	}
	method borrarMapa(){
		mapas.get(nroMapaActual).removerLaberinto(cantidadParedes)
		cantidadParedes=0
		self.borrarElementosDeTablero()
	}
	method llegoAPosicionFinal(posicion){
		return posicion == mapas.get(nroMapaActual).posicionFinalFranky()
	}
	method borrarElementosDeTablero(){
		game.clear()
		}
}
