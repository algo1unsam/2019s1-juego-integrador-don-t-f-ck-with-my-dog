import wollok.game.*
import Direcciones.*
import constructorTablero.*
import ayudas.*

object franky {
	var property position = game.at(0,0)
	var property direccion = derecha
	var property imagen = "franky-right.png" 
	var vida = 3
	var gemasAcumuladas = []
	var corazonesAcumulados = [vida1,vida2,vida3]
	var cant = 0
	
	method image() = imagen 
	
	method move(nuevaPosicion) { 
		self.position(nuevaPosicion)
		if (constructorTablero.llegoAPosicionFinal(nuevaPosicion)) { constructorTablero.pasarDeNivel() }
	}
	
	method movimiento(direccionTecla, imagenDireccion){
		if (self.direccion() == direccionTecla){ direccion.mover(self) }
		else { self.cambiarDireccion(imagenDireccion, direccionTecla) }
	}
	
	method cambiarDireccion(imagenDireccion, nuevaDireccion){
		direccion = nuevaDireccion
		imagen = imagenDireccion
	}
	
	method recogerGema(unaGema){
		self.acumularGema(unaGema)
		self.gemaAcumuladaAlTablero(unaGema)
		
		if (gemasAcumuladas.size() == 3) {
			vida ++	
			cant = 3	
			corazonesAcumulados.get(vida-1).llena()
			if (vida > 3){ 
				vida = 3
			}
		}	
	}
	
	method acumularGema(unaGema){
		gemasAcumuladas.add(unaGema)
		game.removeVisual(unaGema)
	}
	
	method gemaAcumuladaAlTablero(unaGema) { 
		cant++
		game.addVisualIn(unaGema, game.at(cant,12))
	}
	
	method morir(){
		position = constructorTablero.posicionInicialFranky()
		//Al morir tiene que dejar el tablero como iniciado el juego por eso llamo a estos dos métodos
		constructorTablero.reestablecerEnemigos()
		constructorTablero.desactivarPalancas()
		vida --
		if (vida == 2) { vida3.vacia() }
		if (vida == 1) { vida2.vacia() } 
		if (vida == 0) { game.stop() }
	}
	
	method activar(){
		//devuelve la siguiente posicion de la direccion actual del jugador
		// luego activa todos los elementos en dicha posicion
			var posicionObjeto=direccion.devolverProximaPosicion(self.position())
		if (not posicionObjeto.allElements().contains(pared)){
			posicionObjeto.allElements().forEach({objeto => objeto.esUsado()})
		}
	}
	
	method atacar(){
		//devuelve la siguiente posicion de la direccion actual del jugador 
		//luego ataca a todos los elementos en dicha posicion
		var posicionEnemiga=direccion.devolverProximaPosicion(self.position())
		if (not posicionEnemiga.allElements().contains(pared)) {
			posicionEnemiga.allElements().forEach({enemigo => enemigo.esAtacado()})
		}
	}
}