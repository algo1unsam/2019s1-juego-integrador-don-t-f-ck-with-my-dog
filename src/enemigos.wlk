import wollok.game.*
import franky.*
import Direcciones.*

class Enemigo {
	var property position 
	var imagen = "wolf.gif"
	
	method image() = imagen
	
	method movimiento(){
		
	}
}

class Lobo inherits Enemigo {
	var pasos = 0
	var direccion = izquierda
	
	method avanzar(){
		if (pasos < 5){
		direccion.mover(self)
		pasos++
		}
		else {
			self.cambiarDireccion("tumba.gif")
		}
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion) 
	}
	method cambiarDireccion(imagenDireccion){
		if (direccion == izquierda){
		direccion = derecha
		}
		else {
			direccion = izquierda
			pasos = 0
		}
		
		imagen = imagenDireccion
	}
}
