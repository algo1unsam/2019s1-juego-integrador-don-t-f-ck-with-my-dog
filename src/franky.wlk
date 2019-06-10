import wollok.game.*
import Direcciones.*
import constructorTablero.*

object franky {
	var property position = game.at(3,3)
	var property direccion = derecha
	var imagen = "franky-right.png" 
	
	method image() = imagen
	
	method morir(){
		position = game.at(3,3)
		//Al morir tiene que dejar el tablero como iniciado el juego por eso llamo a estos dos métodos
		constructorTablero.reestablecerEnemigos()
		constructorTablero.desactivarPalancas()
	}
	method activar(){
		//devuelve la siguiente posicion de la direccion actual del jugador, luego activa todos los elementos en dicha posicion
		var posicionObjeto=direccion.devolverProximaPosicion(self.position())
		posicionObjeto.allElements().forEach({objecto => objecto.esUsado()})
	}
	method atacar(){
		//devuelve la siguiente posicion de la direccion actual del jugador, luego ataca a todos los elementos en dicha posicion
		var posicionEnemiga=direccion.devolverProximaPosicion(self.position())
		posicionEnemiga.allElements().forEach({enemigo => enemigo.esAtacado()})
		
	}
	method cambiarDireccion(imagenDireccion, nuevaDireccion){
		direccion = nuevaDireccion
		imagen = imagenDireccion
	}
	method movimiento(direccionTecla, imagenDireccion){
		if (self.direccion() == direccionTecla){
			direccion.mover(self)
			}
			else {
				self.cambiarDireccion(imagenDireccion, direccionTecla)
			}
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
}

object vida { method image() = "life.png" }

object noVida { method image() = "life-out.png" }

object pared {
	method image() = "wall.png"
}

