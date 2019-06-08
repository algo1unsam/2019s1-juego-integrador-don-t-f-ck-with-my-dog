import wollok.game.*
import franky.*
import Direcciones.*

class Enemigo {
	var property position 
	var property direccion
	
	method movimiento(){
		
	}
}

class Lobo inherits Enemigo {
	var pasos = 0
	var imagen = "wolf.gif"
	
	method image() = imagen
	
	method moverse() {
		game.onTick(500,"lobo enemigo",{ self.avanzar() })
	}	
	
	method avanzar(){
		if (pasos < 5){
			direccion.mover(self)
			pasos++
		}
		else { self.cambiarDireccion() }
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion) 
	}
	method cambiarDireccion(){
		if (direccion == izquierda){
			direccion = derecha
			imagen = "tumba.gif"
		}
		else {
			direccion = izquierda
			imagen = "wolf.gif"
		}
		pasos = 0
	}
}

class Flecha inherits Enemigo{
	
	method image() = "tumba.gif"
	
	method moverse() {
		direccion.mover(self)
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
}

class Arquero inherits Enemigo{
	method image() = "franky-left.png"
	
	method disparar() {
		var flecha = new Flecha(position = self.position(), direccion = izquierda)
			game.addVisual(flecha)
			flecha.moverse()
		
		/*game.onTick(200,"disparo de flecha",{ 
			
			flecha = new Flecha(position = self.position(), direccion = izquierda)
			game.addVisual(flecha)
		})*/
	} 
}	


