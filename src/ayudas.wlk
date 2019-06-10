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
			return "franky-left.png"
		}
		else {
			return "franky-front.png"
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
class Puerta{
	var property position=game.at(0,0)
	var estaAbierto=false
	 
	method abrir(){
		estaAbierto=true
	}
	method cerrar(){
		estaAbierto=false
	}
	method image(){
		if (estaAbierto){
			return "franky-left.png"
		}
		else {
			return "franky-front.png"
		}
	}
	method chocarCon(jugador){
		if (!estaAbierto){
		jugador.direccion().retroceder(jugador)
		}
	}
	method esAtacado(){}
	method esUsado(){}
}
