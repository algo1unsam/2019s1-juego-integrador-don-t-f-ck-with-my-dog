import wollok.game.*
import franky.*
import Direcciones.*
import constructorTablero.*

class Enemigo {
	var property position=game.at(0,0)
	var property direccion=izquierda
	const posicionInicial
	const property direccionInicial

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
		}
		else {
			direccion = abajo
		}
		pasos = 0
	}
	
	override method esAtacado() {
		vida --
		if (vida == 0) { super() }
	}
}

class Arquero inherits Enemigo{ 
	
	method image() {
		if (direccionInicial == izquierda) { return "franky-left.png" }
		else return "franky-right.png"
 	}
	
	method disparar() {
		var flecha = new Flecha(posicionInicial = direccion.devolverProximaPosicion(self.position()), direccionInicial = self.direccionInicial())
		flecha.agregarEnTablero()
		game.onTick(300,"disparo de flecha",{ flecha.moverse()})
	} 
}	


class Flecha inherits Enemigo{
	
	method image() {
		if (direccionInicial == izquierda) { return "flecha-left.png" }
		else return "flecha-right.png"
	}
	
	method moverse() {
		direccion.mover(self)
		if (position.allElements().contains(pared)){ self.move(posicionInicial) }
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
}

class Pinche inherits Enemigo {
	var estanArriba = false
	var imagen = "life-out.png"
	
	method image() = imagen
	
	method subirYBajar() { game.onTick(2000, "subir y bajar", { 
		self.movimiento()
		imagen = "life-out.png"
	}) 
	}
	
	method movimiento() {
		if (estanArriba) { imagen = "life-out.png" } 
		else imagen = "life.png" 
	}
	
	override method chocarCon(algo){
		if (estanArriba) { super(algo) }
	}
}
