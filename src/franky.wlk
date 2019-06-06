import wollok.game.*

object franky {
	var property position = game.at(3,3)
	var property direccion
	var property imagen 
	
	method image(){
		return imagen
	}
	method cambiarDireccion(imagenDireccion, nuevaDireccion){
		direccion=nuevaDireccion
		imagen=imagenDireccion
	}
	method movimiento(direccionTecla, imagenDireccion){
		if (self.direccion() == direccionTecla){
			direccion.mover(self)
			}
			else {
				self.cambiarDireccion(imagenDireccion, direccionTecla)
			}
	}
	
}

object derecha {
	
	method mover(algo){
		algo.move(algo.position().right(1))
	}
}
object izquierda {
	
	method mover(algo){
		algo.move(algo.position().left(1))
	}
}
object arriba {
	
	method mover(algo){
		algo.move(algo.position().up(1))
	}
}
object abajo {
	
	method mover(algo){
		algo.move(algo.position().down(1))
	}
}