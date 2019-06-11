import wollok.game.*
import franky.*
import Direcciones.*
import constructorTablero.*

class Enemigo {
	var property position=game.at(0,0)
	var property direccion=izquierda
	const posicionInicial
	const direccionInicial

	method chocarCon(algo){
		if (algo == franky){algo.morir()}
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
	var imagen = "wolf-left.png"
	
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
			imagen = "wolf-right.png"
		}
		else {
			direccion = izquierda
			imagen = "wolf-left.png"
		}
		pasos = 0
	}
	
}

class Murcielago inherits Enemigo{
	var pasos = 0
	var imagen = "murcielago.png"
	var vida = 2
	
	method image() = imagen
	
	method moverse() {
		game.onTick(200,"murcielago enemigo",{ self.avanzar() })
	}
	method avanzar(){
		if (pasos < 4){
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
	//		imagen = "tumba.gif"
		}
		else {
			direccion = abajo
	//		imagen = "wolf.gif"
		}
		pasos = 0
	}
	
	override method esAtacado() {
		vida --
		if (vida == 0) { super() }
	}
}

class Arquero inherits Enemigo{ 
	
	method image() = "franky-left.png"
	
	
	method disparar() {
		var flecha = new Flecha(posicionInicial = direccion.devolverProximaPosicion(self.position()), direccionInicial = izquierda)
		flecha.agregarEnTablero()
		game.onTick(300,"disparo de flecha",{ flecha.moverse()})
	} 
}	


class Flecha inherits Enemigo{
	
	method image() = "flecha-left.png"
	
	method moverse() {
		direccion.mover(self)
		if (position.allElements().contains(pared)){ self.move(posicionInicial) }
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
}
