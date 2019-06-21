import wollok.game.*
import franky.*
import Direcciones.*
import constructorTablero.*

class Enemigo {
	var property position=game.at(0,0)
	var property direccion=izquierda
	var pasos=0
	const posicionInicial
	const property direccionInicial

	method chocarCon(algo){ 
		if (algo == franky){
	//		game.onTick(1000,"tumba",{algo.tumba()})
	//		game.removeTickEvent("tumba")
			algo.morir()
		} 
	}
	
	method agregarEnTablero(){
		position=posicionInicial
		direccion=direccionInicial
		pasos=0
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
	var imagen = "wolf-left.png"
	
	method image() = imagen 
	
	method moverse() { game.onTick(500, "lobo enemigo", {self.avanzar()}) }	
	
	method avanzar(){
		if (pasos < 5){
			direccion.mover(self)
			pasos++
		}
		else { self.cambiarDireccion() }
	}
	
	method move(nuevaPosicion) { self.position(nuevaPosicion) }
	
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
	var imagen = "murcielago.png"
	//var vida = 2
	
	method image() = imagen
	
	method moverse() { game.onTick(200, "murcielago enemigo", {self.avanzar()}) }
	
	method avanzar(){
		if (pasos < 4){
			direccion.mover(self)
			pasos++
		}
		else { self.cambiarDireccion() }
	}
	
	
	method move(nuevaPosicion) { self.position(nuevaPosicion) }
	
	method cambiarDireccion(){
		if (direccion == abajo){
			direccion = arriba
		}
		else {
			direccion = abajo
		}
		pasos = 0
	}
	/* 
	override method esAtacado() {
		vida --
		if (vida == 0) { super() }
	}
	*/
}

class Arquero inherits Enemigo{ 
	//var flecha
	var arma
	
	method image() {
		if (direccionInicial == izquierda) return "arquero-left.png" 
		if (direccionInicial == derecha) return "arquero-right.png"
		if (direccionInicial == arriba) return "arquero-back.png"
		else return "arquero-front.png"
 	}
	
	method dispararFlecha(segs) {
		arma = new Flecha(posicionInicial = direccion.devolverProximaPosicion(self.position()), direccionInicial = self.direccionInicial())
		arma.agregarEnTablero()
		game.hideAttributes(arma)
		game.onTick(segs,"disparo de arma",{ arma.moverse() })
	}
	
	method dispararBoomerang(segs) {
		arma = new Boomerang(posicionInicial = direccion.devolverProximaPosicion(self.position()), direccionInicial = self.direccionInicial())
		arma.agregarEnTablero()
		game.hideAttributes(arma)
		game.onTick(segs,"disparo de arma",{ arma.moverse() })
	}
	
	override method esAtacado(){
		super()
		game.removeVisual(arma)	
	} 
}	


class Flecha inherits Enemigo{
	
	method image() {
		if (direccionInicial == izquierda) return "flecha-left.png" 
		if (direccionInicial == derecha) return "flecha-right.png"
		if (direccionInicial == arriba) return "flecha-up.png"
		else return "flecha-down.png"
	}
	
	method moverse() {
		direccion.mover(self)
		if (position.allElements().contains(pared)){ self.move(posicionInicial) }
	}

	method move(nuevaPosicion) { self.position(nuevaPosicion) }
	
	override method esAtacado(){}
	
}

class Boomerang inherits Enemigo {
	var imagenes = ["boomerang-left.png", "boomerang-up.png", "boomerang-right.png", "boomerang-down.png"]
	
	method image() = imagenes.get(pasos)
	
	method moverse() { 
		if (pasos < 3){
			direccion.mover(self)
			pasos++
		}
		else { self.cambiarDireccion() }
	}
	
	method cambiarDireccion(){
		if (direccion == abajo){ direccion = arriba }
		else { direccion = abajo }
		pasos = 0
	}
	
	method move(nuevaPosicion) { self.position(nuevaPosicion) }
	
	override method esAtacado(){}
}

class Pinche inherits Enemigo {
	var estanArriba = false
	
	method image() {
		if (estanArriba) return "pinches-up.png" 
		else return "pinches-down.png" 
	}
	
	method subirYBajar() { game.onTick(2000, "subir y bajar", { self.movimiento() }) }
	
	method movimiento() {
		if (estanArriba) { estanArriba = false }
		else { estanArriba = true } 
	}
	
	override method esAtacado(){}
	
	override method chocarCon(algo){ if (estanArriba) {super(algo)} }
}

class PinchesEnPared inherits Enemigo {

	method image() {
		if (direccionInicial == arriba) return "ground-with-spikes-up.png"
		if (direccionInicial == abajo) return "ground-with-spikes-down.png"
		if (direccionInicial == izquierda) return "ground-with-spikes-left.png"
		else return "ground-with-spikes-right.png"
	}
}

object agua {
	method image() = "agua.jpg"
	
	method chocarCon(algo){ if (algo == franky){ algo.morir()} }
	method esAtacado(){}
	method esUsado(){}
}

class Sierra inherits Enemigo {
	var imagenes = ["sierra-1.png", "sierra-2.png", "sierra-3.png", "sierra-4.png"]
	var i = 0
	
	method image() = imagenes.get(i)
	
	method moverse() { game.onTick(200, "girar sierra", {self.girar()}) }
	
	method girar() {
		
		if	(i<3){i++} 
		else {i=0}
		  
		if (pasos < 2) {
			direccion.mover(self)
			pasos++
			//i++
		}
		else { self.cambiarDireccion() }
	}
	
	method cambiarDireccion(){
		if (direccion == izquierda){ direccion = derecha }
		else { if (direccion == derecha){ direccion = izquierda }}
		if (direccion == arriba){ direccion = abajo }
		else { if (direccion == abajo){ direccion = arriba }}
		pasos = 0
		//i = 0
	}
	
	method move(nuevaPosicion) { self.position(nuevaPosicion) }
	
	override method esAtacado(){}
}

class Zombi inherits Enemigo {
	const posicionFinal
	
	override method esAtacado(){}
	method moverse() { game.onTick(500, "lobo enemigo", {self.avanzar()}) }	
	method avanzar(){
		if (direccionInicial == direccion){
		if (position == posicionFinal){self.cambiarDireccion()}
		else { direccion.mover(self) }
		}
		else {
			if (position == posicionInicial){self.cambiarDireccion()}
			else { direccion.mover(self) }
		}
	}
	method cambiarDireccion(){
		if (direccion == izquierda){ direccion = derecha }
		else { if (direccion == derecha){ direccion = izquierda }}
		if (direccion == arriba){ direccion = abajo }
		else { if (direccion == abajo){ direccion = arriba }}
	}
}
