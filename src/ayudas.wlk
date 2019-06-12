import wollok.game.*
import franky.*
import Direcciones.*
import constructorTablero.*

class Palanca{
	var property position=game.at(0,0)
	var estaActivo=false
	const objetoCerrado
	
	method image(){
		if (estaActivo){
			return "palanca-activada.png"
		}
		else {
			return "palanca-desactivada.png"
		}
	}
	method activar(){
		objetoCerrado.abrir()	
	}
	method desactivar(){
		estaActivo=false
		objetoCerrado.cerrar()	
	}
	method esAtacado(){}
	method esUsado(){
		self.activar()
		estaActivo=true
	}
	method chocarCon(jugador){
		jugador.direccion().retroceder(jugador)
	}
}
class Puerta {
	var property position
	var estaAbierto = false
	 
	method abrir(){
		estaAbierto=true
		game.removeVisual(self)
	}
	method cerrar(){ estaAbierto = false }
 	method image() = "wall.png"
 	
	method chocarCon(jugador){
		if (!estaAbierto){ jugador.direccion().retroceder(jugador) }
	}
	method esAtacado(){}
	method esUsado(){}
}

class Gema {
	method image() = "gema.png"
	
	method chocarCon(jugador){ jugador.recogerGema(self) }
}

class Vida {
	var imagen = "life.png"
	
	method image() = imagen
	
	method vacia() { imagen = "life-out.png" }
	
	method llena() { imagen = "life.png" }
}

object vida1 inherits Vida{}

object vida2 inherits Vida{}

object vida3 inherits Vida{}