import wollok.game.*
import franky.*
import Direcciones.*
import constructorTablero.*

class Enemigo {
	var property position=game.at(0,0) 
	var property direccion=izquierda
	const posicionInicial
	const direccionInicial

	method chocarCon(jugador){
		jugador.morir()
	}
	
	method agregarEnTablero(){
		position=posicionInicial
		direccion=direccionInicial
		game.addVisual(self)
	}
	method esAtacado(){
		//Guardo todos los enemigos que voy derrotando para reestablecerlos en caso de morir
		constructorTablero.nuevoEnemigoDerrotado(self)
		game.removeVisual(self)
	}
	method esUsado(){}
}

class Lobo inherits Enemigo {
	var pasos = 0
	//wolf.gif
	var imagen = "franky-left.png"
	
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
			imagen = "franky-right.png"
			////tumba.gif
		}
		else {
			direccion = izquierda
			imagen = "franky-left.png"
			////wolf.gif
		}
		pasos = 0
	}
	
}

class Murcielago inherits Enemigo{
	var pasos = 0
	var imagen = "wolf.gif"
	
	method image() = imagen
	
	method moverse() {
		game.onTick(50,"murcielago enemigo",{ self.avanzar() })
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
		if (direccion == abajo){
			direccion = arriba
			imagen = "tumba.gif"
		}
		else {
			direccion = abajo
			imagen = "wolf.gif"
		}
		pasos = 0
	}
}

class Arquero inherits Enemigo{
	method image() = "franky-left.png"
	
	method disparar() {
		var flecha = new Flecha(posicionInicial = direccion.devolverProximaPosicion(self.position()), direccionInicial = izquierda)
			game.addVisual(flecha)
		game.onTick(200,"disparo de flecha",{ 
			
			flecha.moverse()
			//flecha = new Flecha(position = self.position(), direccion = izquierda)
			//game.addVisual(flecha)
		})
	} 
}	

class Flecha inherits Enemigo{
	
	method image() = "franky-front.png"
	
	method moverse() {
		direccion.mover(self)
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
}
