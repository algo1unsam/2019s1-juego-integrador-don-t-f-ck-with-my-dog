import wollok.game.*
import franky.*
import Direcciones.*
import enemigos.*

//va a ser el objeto que va a ir generando los diferentes mapas, por ahora lo uso para reestablecer los elementos del tablero al morir
object constructorTablero {
	var property enemigosDerrotados=[]	
	var property palancas=[]
	
	method nuevoEnemigoDerrotado(enemigo){
		enemigosDerrotados.add(enemigo)
	}
	method agregarPalancaTablero(palanca){
		game.addVisual(palanca)
		palancas.add(palanca)
	}
	method reestablecerEnemigos(){
		enemigosDerrotados.forEach({enemigo => enemigo.agregarEnTablero()})
	}
	method desactivarPalancas(){
		palancas.forEach({palanca => palanca.desactivar()})
	}
	method constructorParedes(x,cantidadDeBloques,y){
		var bloques=cantidadDeBloques
		var columnaActual=y
		if (cantidadDeBloques != 0){
			game.addVisualIn(pared, game.at(x,y))
			bloques--
			columnaActual++
		}
	}
}
