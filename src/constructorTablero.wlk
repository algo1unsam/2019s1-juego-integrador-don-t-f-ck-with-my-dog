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
		constructorTablero.nuevoElementoEnTablero(gema1)
		game.addVisualIn(gema2, game.at(10,2))
		constructorTablero.nuevoElementoEnTablero(gema2)
		game.addVisualIn(gema3, game.at(18,6))
		constructorTablero.nuevoElementoEnTablero(gema3)
		constructorTablero.agregarPalancaTablero(palanca)
		constructorTablero.nuevoElementoEnTablero(palanca)
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
		constructorTablero.constructorParedesVertical(0,12,0)
		
		//PARED ARRIBA
		constructorTablero.constructorParedesHorizontal(1,19,12)
		
		//PARED DERECHA
		constructorTablero.constructorParedesVertical(19,11,2)
		
		//PARED ABAJO
		constructorTablero.constructorParedesHorizontal(1,19,0)
	}
	method removerLaberinto(cantidadParedes){
		(0 .. cantidadParedes-1).forEach({n => game.removeVisual(pared)})
	}
	
	method agregarLaberinto() {
		
		constructorTablero.constructorParedesHorizontal(3,1,1)
		//game.addVisualIn(pared, game.at(3,1))
		
		constructorTablero.constructorParedesVertical(1,0,3)
		constructorTablero.constructorParedesVertical(1,0,7)
		constructorTablero.constructorParedesVertical(1,0,8)
		
		 
		//game.addVisualIn(pared, game.at(1,3))
		//game.addVisualIn(pared, game.at(1,7))
		//game.addVisualIn(pared, game.at(1,8))
		
		constructorTablero.constructorParedesVertical(2,0,3)
		constructorTablero.constructorParedesVertical(2,0,5)
		constructorTablero.constructorParedesVertical(2,0,10)
		 
		//game.addVisualIn(pared, game.at(2,3))
		//game.addVisualIn(pared, game.at(2,5))
		//game.addVisualIn(pared, game.at(2,10))
		
		constructorTablero.constructorParedesVertical(3,7,3)
		/*
		game.addVisualIn(pared, game.at(3,3))
		game.addVisualIn(pared, game.at(3,4))
		game.addVisualIn(pared, game.at(3,5))
		game.addVisualIn(pared, game.at(3,6))
		game.addVisualIn(pared, game.at(3,7))
		game.addVisualIn(pared, game.at(3,8))
		game.addVisualIn(pared, game.at(3,9))
		game.addVisualIn(pared, game.at(3,10))
		*/
		
		constructorTablero.constructorParedesVertical(4,0,1)
		constructorTablero.constructorParedesVertical(4,0,7)
		constructorTablero.constructorParedesVertical(4,0,9)
		
		/* 
		game.addVisualIn(pared, game.at(4,1))
		game.addVisualIn(pared, game.at(4,7))
		game.addVisualIn(pared, game.at(4,9))
		 */
		constructorTablero.constructorParedesVertical(5,3,1)
		/*
		game.addVisualIn(pared, game.at(5,1))
		game.addVisualIn(pared, game.at(5,2))
		game.addVisualIn(pared, game.at(5,3))
		game.addVisualIn(pared, game.at(5,4))
		 */
		constructorTablero.constructorParedesVertical(5,0,11)
		//game.addVisualIn(pared, game.at(5,11)) 
		
		constructorTablero.constructorParedesVertical(6,5,2)
		 /*  
		game.addVisualIn(pared, game.at(6,2))
		game.addVisualIn(pared, game.at(6,3))
		game.addVisualIn(pared, game.at(6,4))
		game.addVisualIn(pared, game.at(6,5))
		game.addVisualIn(pared, game.at(6,6))
		game.addVisualIn(pared, game.at(6,7))
		*/
		constructorTablero.constructorParedesVertical(6,2,9)
		/* 
		game.addVisualIn(pared, game.at(6,9))
		game.addVisualIn(pared, game.at(6,10))
		game.addVisualIn(pared, game.at(6,11))
		*/
		constructorTablero.constructorParedesVertical(7,1,2)
		/* 
		game.addVisualIn(pared, game.at(7,2))
		game.addVisualIn(pared, game.at(7,3))
		*/ 
		constructorTablero.constructorParedesVertical(7,0,7)
		//game.addVisualIn(pared, game.at(7,7))
		
		constructorTablero.constructorParedesVertical(8,0,5)
		constructorTablero.constructorParedesVertical(8,0,7)
		constructorTablero.constructorParedesVertical(8,1,9)
		
		/*
		game.addVisualIn(pared, game.at(8,5))
		game.addVisualIn(pared, game.at(8,7))
		game.addVisualIn(pared, game.at(8,9))
		game.addVisualIn(pared, game.at(8,10))
		 */
		
		constructorTablero.constructorParedesVertical(9,3,2)
		constructorTablero.constructorParedesVertical(9,0,7)
		constructorTablero.constructorParedesVertical(9,0,9)
		/*  
		game.addVisualIn(pared, game.at(9,2))
		game.addVisualIn(pared, game.at(9,3))
		game.addVisualIn(pared, game.at(9,4))
		game.addVisualIn(pared, game.at(9,5))
		game.addVisualIn(pared, game.at(9,7))
		game.addVisualIn(pared, game.at(9,9))
		*/
		
		constructorTablero.constructorParedesVertical(10,0,3)
		constructorTablero.constructorParedesVertical(10,2,7)
		constructorTablero.constructorParedesVertical(10,0,11)
		
		/*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
		game.addVisualIn(pared, game.at(10,3))
		game.addVisualIn(pared, game.at(10,7))
		game.addVisualIn(pared, game.at(10,8))
		game.addVisualIn(pared, game.at(10,9))
		game.addVisualIn(pared, game.at(10,11))
		*/
		
		constructorTablero.constructorParedesVertical(11,1,2)
		constructorTablero.constructorParedesVertical(11,2,5)
		constructorTablero.constructorParedesVertical(11,0,11)
		
		/* 
		game.addVisualIn(pared, game.at(11,2))
		game.addVisualIn(pared, game.at(11,3))
		game.addVisualIn(pared, game.at(11,5))
		game.addVisualIn(pared, game.at(11,6))
		game.addVisualIn(pared, game.at(11,7))
		game.addVisualIn(pared, game.at(11,11))
		*/
		constructorTablero.constructorParedesVertical(12,0,3)
		constructorTablero.constructorParedesVertical(12,0,7)
		constructorTablero.constructorParedesVertical(12,2,9)
		
		/* 	
		game.addVisualIn(pared, game.at(12,3))
		game.addVisualIn(pared, game.at(12,7))
		game.addVisualIn(pared, game.at(12,9))
		game.addVisualIn(pared, game.at(12,10))
		game.addVisualIn(pared, game.at(12,11))	
		*/
		constructorTablero.constructorParedesVertical(13,0,3)
		constructorTablero.constructorParedesVertical(13,0,5)
		constructorTablero.constructorParedesVertical(13,0,7)
		/* 
		game.addVisualIn(pared, game.at(13,3))
		game.addVisualIn(pared, game.at(13,5))
		game.addVisualIn(pared, game.at(13,7))
		*/
		constructorTablero.constructorParedesVertical(14,0,1)
		constructorTablero.constructorParedesVertical(14,0,3)
		constructorTablero.constructorParedesVertical(14,0,5)
		constructorTablero.constructorParedesVertical(14,3,7)
		
		/* 
		game.addVisualIn(pared, game.at(14,1))
		game.addVisualIn(pared, game.at(14,3))
		game.addVisualIn(pared, game.at(14,5))
		game.addVisualIn(pared, game.at(14,7))
		game.addVisualIn(pared, game.at(14,8))
		game.addVisualIn(pared, game.at(14,9))
		game.addVisualIn(pared, game.at(14,10))
		*/
		constructorTablero.constructorParedesVertical(15,0,1)
		constructorTablero.constructorParedesVertical(15,0,3)
		constructorTablero.constructorParedesVertical(15,0,5)
		
		/* 
		game.addVisualIn(pared, game.at(15,1))
		game.addVisualIn(pared, game.at(15,3))
		game.addVisualIn(pared, game.at(15,5))
		*/
		constructorTablero.constructorParedesVertical(16,0,1)
		constructorTablero.constructorParedesVertical(16,2,3)
		constructorTablero.constructorParedesVertical(16,0,8)
		constructorTablero.constructorParedesVertical(16,1,10)
		
		/* 
		game.addVisualIn(pared, game.at(16,1))
		game.addVisualIn(pared, game.at(16,3))
		game.addVisualIn(pared, game.at(16,4))
		game.addVisualIn(pared, game.at(16,5))
		game.addVisualIn(pared, game.at(16,8))
		game.addVisualIn(pared, game.at(16,10))
		game.addVisualIn(pared, game.at(16,11))
		*/
		
		constructorTablero.constructorParedesVertical(17,0,1)
		constructorTablero.constructorParedesVertical(17,4,4)
		/* 
		game.addVisualIn(pared, game.at(17,1))
		game.addVisualIn(pared, game.at(17,4))
		game.addVisualIn(pared, game.at(17,5))
		game.addVisualIn(pared, game.at(17,6))
		game.addVisualIn(pared, game.at(17,7))
		game.addVisualIn(pared, game.at(17,8))
		*/
		constructorTablero.constructorParedesVertical(18,3,7)
		
		/* 
		game.addVisualIn(pared, game.at(18,7))
		game.addVisualIn(pared, game.at(18,8))
		game.addVisualIn(pared, game.at(18,9))
		game.addVisualIn(pared, game.at(18,10))
		*/
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
	var arquero6 = new Arquero(posicionInicial = game.at(7,7), direccionInicial = arriba, flecha = null)
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
	
	method agregarLaberinto(){}
	
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
		constructorTablero.constructorParedesVertical(0,4,1)
		constructorTablero.constructorParedesVertical(0,4,7)
		
		//PARED ARRIBA
		constructorTablero.constructorParedesHorizontal(0,19,12)
		
		//PARED DERECHA
		constructorTablero.constructorParedesVertical(19,12,1)
		
		//PARED ABAJO
		constructorTablero.constructorParedesHorizontal(0,15,0)
		constructorTablero.constructorParedesHorizontal(17,2,0)
	}
}

//va a ser el objeto que va a ir generando los diferentes mapas
// por ahora lo uso para reestablecer los elementos del tablero al morir
object constructorTablero {
	var property enemigosDerrotados=[]	
	var property palancas=[]
	var property elementosEnTablero=[]
	const property mapas = [mapa1, mapa2]
	var property cantidadParedes=0
	var property nroMapaActual=0
	
	method nuevoEnemigoDerrotado(enemigo){ enemigosDerrotados.add(enemigo) }
	
	method agregarPalancaTablero(palanca){
		game.addVisual(palanca)
		palancas.add(palanca)
	}
	method nuevoElementoEnTablero(nuevoElemento){
		elementosEnTablero.add(nuevoElemento)
	}
	method borrarElementoEnTablero(elementoABorrar){
		elementosEnTablero.remove(elementoABorrar)
		game.removeVisual(elementoABorrar)
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
	
	method constructorParedesVertical(x,cantidadDeBloques,y){
		(y .. y+cantidadDeBloques).forEach({n => game.addVisualIn(pared, game.at(x,n))
		cantidadParedes++		
		}) 
	}
	
	method constructorParedesHorizontal(x,cantidadDeBloques,y){
		(x .. cantidadDeBloques+x).forEach({n => game.addVisualIn(pared, game.at(n,y))	
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
		/* 
		elementosEnTablero.forEach({elemento => game.removeVisual(elemento)})	
		elementosEnTablero.clear()
		*/
		}
}
