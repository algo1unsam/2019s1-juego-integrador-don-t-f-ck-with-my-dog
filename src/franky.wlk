import wollok.game.*
import Direcciones.*

object franky {
	var property position = game.at(3,3)
	var property direccion = derecha
	var property imagen ="franky-right.png" 
	
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

