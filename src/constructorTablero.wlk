import wollok.game.*
import franky.*
import Direcciones.*
import enemigos.*
import ayudas.*

object pared {
	method image() = "wall.png"
	method chocarCon(jugador){
		jugador.direccion().retroceder(jugador)
	}
}

object gameOver {
	method image() = "game-over.png"
	
	method cerrarJuego() {game.onTick(2000,"Game over", {game.stop()})}
}

//va a ser el objeto que va a ir generando los diferentes mapas
object constructorTablero {
	var property enemigosDerrotados = []	
	var property palancas = []
	const property mapas = [mapa1, mapa2, mapa3]
	var property cantidadParedes = 0
	var property nroMapaActual = 2
	
	method movimientosYAcciones() {
		//MOVIMIENTOS DEL PERSONAJE
		keyboard.up().onPressDo { franky.movimiento(arriba, "franky-back.png") }
		keyboard.down().onPressDo { franky.movimiento(abajo, "franky-front.png") }
		keyboard.left().onPressDo { franky.movimiento(izquierda, "franky-left.png")}
		keyboard.right().onPressDo { franky.movimiento(derecha, "franky-right.png") }
		
		//ACCIONES DEL PERSONAJE
		keyboard.space().onPressDo { franky.atacar() }
		keyboard.a().onPressDo { franky.activar() }
		
		//COLISIONES
		game.whenCollideDo(franky, {enemigo => enemigo.chocarCon(franky)})
//		game.whenCollideDo(franky, {agua => agua.chocarCon(franky)})
	}
	
	method posicionInicialFranky() = mapas.get(nroMapaActual).posicionFranky()
	
	method cargarMapa(){
		mapas.get(nroMapaActual).agregarParedes()
		mapas.get(nroMapaActual).agregarLaberinto()
		mapas.get(nroMapaActual).agregarAyudas()
		mapas.get(nroMapaActual).agregarVidas()
		mapas.get(nroMapaActual).agregarEnemigos()
		mapas.get(nroMapaActual).agregarFranky()
		self.movimientosYAcciones()
	}
	
	method constructorVertical(x,cantidadDeBloques,y,algo){
		(y .. y+cantidadDeBloques).forEach({n => game.addVisualIn(algo, game.at(x,n))
		cantidadParedes++		
		}) 
	}
	
	method constructorHorizontal(x,cantidadDeBloques,y,algo){
		(x .. cantidadDeBloques+x).forEach({n => game.addVisualIn(algo, game.at(n,y))	
		cantidadParedes++
		}) 
	}
	
	method agregarPalancaTablero(palanca){
		game.addVisual(palanca)
		palancas.add(palanca)
	}
	
	method nuevoEnemigoDerrotado(enemigo){ enemigosDerrotados.add(enemigo) }
	
	
	//Cuando Franky pasa de nivel
	method llegoAPosicionFinal(posicion) = posicion == mapas.get(nroMapaActual).posicionFinalFranky()
	
	method pasarDeNivel(){
		self.borrarMapa()
		nroMapaActual++
		self.cargarMapa()
		franky.limpiarGemas()
		enemigosDerrotados.clear()
	}
	
	method borrarMapa(){
		mapas.get(nroMapaActual).removerLaberinto(cantidadParedes)
		cantidadParedes=0
		self.borrarElementosDeTablero()
	}
	
	method borrarElementosDeTablero(){ game.clear() }


	//Cuando Franky muere
	method reestablecerEnemigos(){ 
		if (enemigosDerrotados.size() > 0) { enemigosDerrotados.forEach{enemigo => enemigo.agregarEnTablero()} }
	}
	
	method desactivarPalancas(){ 
		if (palancas.size() > 0) { palancas.forEach{palanca => palanca.desactivar()} }
	}
}


object mapa1  {
	//Hago un set de la posición de franky al comenzar y al finalizar el juego
	var  property posicionFranky = game.at(1,1)
	var property posicionFinalFranky = game.at(19,1)
	
	//Creo las ayudas
	var puerta = new Puerta(position = game.at(19,1),activacionesNecesarias=1)
	var palanca = new Palanca(position = game.at(2,4),objetoCerrado=puerta) 
	var gema1 = new Gema()
	var gema2 = new Gema()
	var gema3 = new Gema()
	
	//Creo los enemigos
	var lobo1 = new Lobo(posicionInicial = game.at(9,8), direccionInicial = izquierda)
	var lobo2 = new Lobo(posicionInicial = game.at(15,4), direccionInicial = izquierda)
	var murcielago1 = new Murcielago(posicionInicial = game.at(15,11), direccionInicial = abajo)
	var arquero1 = new Arquero(posicionInicial = game.at(6,1), direccionInicial = derecha,arma=null)	
	var pinches = new Pinche(position = game.at(2,7), posicionInicial = game.at(2,7), direccionInicial = null)
	var pinchesPared1 = new PinchesEnPared(posicionInicial = game.at(4,8), direccionInicial = izquierda)
	var pinchesPared2 = new PinchesEnPared(posicionInicial = game.at(5,5), direccionInicial = abajo)
	var pinchesPared3 = new PinchesEnPared(posicionInicial = game.at(16,6), direccionInicial = derecha)
	var pinchesPared4 = new PinchesEnPared(posicionInicial = game.at(16,7), direccionInicial = derecha)
	var pinchesPared5 = new PinchesEnPared(posicionInicial = game.at(13,1), direccionInicial = derecha)
	
	method agregarAyudas(){
		game.addVisualIn(gema1, game.at(18,11))
		game.addVisualIn(gema2, game.at(10,2))
		game.addVisualIn(gema3, game.at(18,6))
		constructorTablero.agregarPalancaTablero(palanca)
		game.addVisual(puerta)
		
		game.hideAttributes(gema1)
		game.hideAttributes(gema2)
		game.hideAttributes(gema3)
		
		game.hideAttributes(puerta)
		game.hideAttributes(palanca)
	}
	
	method agregarVidas(){
		game.addVisualIn(vida3, game.at(18,12))
		game.addVisualIn(vida2, game.at(17,12))
		game.addVisualIn(vida1, game.at(16,12)) 
		
		game.hideAttributes(vida1)
		game.hideAttributes(vida2)
		game.hideAttributes(vida3)
	}
	
	method agregarEnemigos(){	
		pinchesPared1.agregarEnTablero()	
		pinchesPared2.agregarEnTablero()
		pinchesPared3.agregarEnTablero()
		pinchesPared4.agregarEnTablero()
		pinchesPared5.agregarEnTablero()
		lobo1.agregarEnTablero() 
		lobo2.agregarEnTablero()
		murcielago1.agregarEnTablero()
		arquero1.agregarEnTablero()
		pinches.agregarEnTablero()
		
		arquero1.dispararFlecha(300)
		lobo1.moverse()
		lobo2.moverse()
		murcielago1.moverse()
		pinches.subirYBajar()
		
		game.hideAttributes(lobo1) 
		game.hideAttributes(lobo2)
		game.hideAttributes(murcielago1)
		game.hideAttributes(arquero1)
		game.hideAttributes(pinches)
		game.hideAttributes(pinchesPared1)
		game.hideAttributes(pinchesPared2)
		game.hideAttributes(pinchesPared3)
		game.hideAttributes(pinchesPared4)
		game.hideAttributes(pinchesPared5)
	}
	
	method agregarParedes(){
		//PARED IZQUIERDA
		constructorTablero.constructorVertical(0,12,0,pared)
		
		//PARED ARRIBA
		constructorTablero.constructorHorizontal(1,19,12,pared)
		
		//PARED DERECHA
		constructorTablero.constructorVertical(19,11,2,pared)
		
		//PARED ABAJO
		constructorTablero.constructorHorizontal(1,19,0,pared)
	}
	
	method removerLaberinto(cantidadParedes){ (0 .. cantidadParedes - 1).forEach({n => game.removeVisual(pared)}) }
	
	method agregarLaberinto() {
		
		constructorTablero.constructorHorizontal(3,1,1,pared)
		
		constructorTablero.constructorVertical(1,0,3,pared)
		constructorTablero.constructorVertical(1,0,7,pared)
		constructorTablero.constructorVertical(1,0,8,pared)
		
		constructorTablero.constructorVertical(2,0,3,pared)
		constructorTablero.constructorVertical(2,0,5,pared)
		constructorTablero.constructorVertical(2,0,10,pared)
		
		constructorTablero.constructorVertical(3,7,3,pared)
		
		constructorTablero.constructorVertical(4,0,1,pared)
		constructorTablero.constructorVertical(4,0,7,pared)
		constructorTablero.constructorVertical(4,0,9,pared)
		
		constructorTablero.constructorVertical(5,3,1,pared)
		
		constructorTablero.constructorVertical(5,0,11,pared)
		
		constructorTablero.constructorVertical(6,5,2,pared)
		
		constructorTablero.constructorVertical(6,2,9,pared)

		constructorTablero.constructorVertical(7,1,2,pared)
		
		constructorTablero.constructorVertical(7,0,7,pared)
		
		constructorTablero.constructorVertical(8,0,5,pared)
		constructorTablero.constructorVertical(8,0,7,pared)
		constructorTablero.constructorVertical(8,1,9,pared)
		
		constructorTablero.constructorVertical(9,3,2,pared)
		constructorTablero.constructorVertical(9,0,7,pared)
		constructorTablero.constructorVertical(9,0,9,pared)
		
		constructorTablero.constructorVertical(10,0,3,pared)
		constructorTablero.constructorVertical(10,2,7,pared)
		constructorTablero.constructorVertical(10,0,11,pared)
		
		constructorTablero.constructorVertical(11,1,2,pared)
		constructorTablero.constructorVertical(11,2,5,pared)
		constructorTablero.constructorVertical(11,0,11,pared)
		
		constructorTablero.constructorVertical(12,0,3,pared)
		constructorTablero.constructorVertical(12,0,7,pared)
		constructorTablero.constructorVertical(12,2,9,pared)
		
		constructorTablero.constructorVertical(13,0,3,pared)
		constructorTablero.constructorVertical(13,0,5,pared)
		constructorTablero.constructorVertical(13,0,7,pared)

		constructorTablero.constructorVertical(14,0,1,pared)
		constructorTablero.constructorVertical(14,0,3,pared)
		constructorTablero.constructorVertical(14,0,5,pared)
		constructorTablero.constructorVertical(14,3,7,pared)
		
		constructorTablero.constructorVertical(15,0,1,pared)
		constructorTablero.constructorVertical(15,0,3,pared)
		constructorTablero.constructorVertical(15,0,5,pared)
		
		constructorTablero.constructorVertical(16,0,1,pared)
		constructorTablero.constructorVertical(16,2,3,pared)
		constructorTablero.constructorVertical(16,0,8,pared)
		constructorTablero.constructorVertical(16,1,10,pared)
		
		constructorTablero.constructorVertical(17,0,1,pared)
		constructorTablero.constructorVertical(17,4,4,pared)
	
		constructorTablero.constructorVertical(18,3,7,pared)
	}
	
	method agregarFranky() { 
		game.addVisual(franky)
		franky.move(posicionFranky)
	}
}

object mapa2{
	//var contadorDeAgua 	
	var property posicionFranky = game.at(0,6)
	var property posicionFinalFranky = game.at(16,0) 
	
	var arquero1 = new Arquero(posicionInicial = game.at(18,1), direccionInicial = izquierda, arma=null)
	var arquero2 = new Arquero(posicionInicial = game.at(18,2), direccionInicial = izquierda, arma=null)
	var arquero3 = new Arquero(posicionInicial = game.at(4,11), direccionInicial = abajo, arma=null)
	var arquero4 = new Arquero(posicionInicial = game.at(10,8), direccionInicial = arriba, arma=null)
	var arquero5 = new Arquero(posicionInicial = game.at(10,7), direccionInicial = abajo, arma=null)
	var arquero6 = new Arquero(posicionInicial = game.at(8,7), direccionInicial = arriba, arma=null)
	var arquero7 = new Arquero(posicionInicial = game.at(15,11), direccionInicial = abajo, arma=null)
	var pinche1 = new Pinche(posicionInicial = game.at(6,6), direccionInicial = null)
	var pinche2 = new Pinche(posicionInicial = game.at(7,1), direccionInicial = null)
	var pinche3 = new Pinche(posicionInicial = game.at(12,1), direccionInicial = null)
	var pinche4 = new Pinche(posicionInicial = game.at(8,1), direccionInicial = null)
	var pinche5 = new Pinche(posicionInicial = game.at(12,2), direccionInicial = null)
	var murcielago1 = new Murcielago(posicionInicial = game.at(12,7), direccionInicial = arriba)
	var lobo1 = new Lobo(posicionInicial = game.at(13,5), direccionInicial = izquierda)
	var lobo2 = new Lobo(posicionInicial = game.at(18,5), direccionInicial = izquierda)
	
	var gema1 = new Gema()
	var gema2 = new Gema()
	var gema3 = new Gema()
	
	method agregarFranky(){
		game.addVisual(franky)
		franky.position(posicionFranky)
	}
	
	method agregarVidas(){
		game.addVisualIn(vida3, game.at(18,12))
		game.addVisualIn(vida2, game.at(17,12))
		game.addVisualIn(vida1, game.at(16,12)) 
		
		game.hideAttributes(vida1)
		game.hideAttributes(vida2)
		game.hideAttributes(vida3)
	}
	
	method agregarParedes(){
		//PARED IZQUIERDA
		constructorTablero.constructorVertical(0,4,1,pared)
		constructorTablero.constructorVertical(0,4,7,pared)
		
		//PARED ARRIBA
		constructorTablero.constructorHorizontal(0,19,12,pared)
		
		//PARED DERECHA
		constructorTablero.constructorVertical(19,12,1,pared)
		
		//PARED ABAJO
		constructorTablero.constructorHorizontal(0,15,0,pared)
		constructorTablero.constructorHorizontal(17,2,0,pared)
	}
	
	method agregarLaberinto(){
		
		constructorTablero.constructorHorizontal(1,6,5,agua)
		constructorTablero.constructorHorizontal(3,6,3,agua)
		
		constructorTablero.constructorHorizontal(1,4,7,agua)
		constructorTablero.constructorHorizontal(1,4,8,agua)
		constructorTablero.constructorHorizontal(1,4,9,agua)
		constructorTablero.constructorHorizontal(1,4,10,agua)
		constructorTablero.constructorHorizontal(1,2,11,agua)
		constructorTablero.constructorHorizontal(5,0,11,agua)
		
		constructorTablero.constructorVertical(7,3,7,agua)
		constructorTablero.constructorVertical(8,2,8,agua)
		constructorTablero.constructorVertical(9,3,7,agua)
		constructorTablero.constructorVertical(10,1,9,agua)
		constructorTablero.constructorVertical(11,3,7,agua)
		
		constructorTablero.constructorHorizontal(13,5,10,agua)
		constructorTablero.constructorHorizontal(13,1,11,agua)
		constructorTablero.constructorHorizontal(16,2,11,agua)
		
		constructorTablero.constructorHorizontal(13,4,8,agua)
		constructorTablero.constructorHorizontal(13,4,7,agua)
		constructorTablero.constructorHorizontal(7,10,6,agua)
		constructorTablero.constructorHorizontal(9,9,4,agua)
		constructorTablero.constructorHorizontal(12,6,3,agua)
		
		constructorTablero.constructorHorizontal(3,1,2,agua)
	}
	
	method agregarEnemigos() {
		arquero1.agregarEnTablero()
		arquero2.agregarEnTablero()
		arquero3.agregarEnTablero()
		arquero4.agregarEnTablero()
		arquero5.agregarEnTablero()
		arquero6.agregarEnTablero()
		arquero7.agregarEnTablero()
		pinche1.agregarEnTablero()
		pinche2.agregarEnTablero()
		pinche3.agregarEnTablero()
		pinche4.agregarEnTablero()
		pinche5.agregarEnTablero()
		murcielago1.agregarEnTablero()
		lobo1.agregarEnTablero()
		lobo2.agregarEnTablero()
		
		arquero1.dispararFlecha(200)
		arquero2.dispararFlecha(300)
		arquero3.dispararFlecha(300)
		arquero4.dispararFlecha(500)
		arquero5.dispararBoomerang(400)
		arquero6.dispararFlecha(400)
		arquero7.dispararFlecha(500)
		pinche1.subirYBajar()
		pinche2.subirYBajar()
		pinche3.subirYBajar()
		pinche4.subirYBajar()
		pinche5.subirYBajar()
		murcielago1.moverse()
		lobo1.moverse()
		lobo2.moverse()
		
		game.hideAttributes(arquero1)
		game.hideAttributes(arquero2)
		game.hideAttributes(arquero3)
		game.hideAttributes(arquero4)
		game.hideAttributes(arquero5)
		game.hideAttributes(arquero6)
		game.hideAttributes(arquero7)
		game.hideAttributes(pinche1)
		game.hideAttributes(pinche2)
		game.hideAttributes(pinche3)
		game.hideAttributes(pinche4)
		game.hideAttributes(murcielago1)	
	}
	
	method agregarAyudas(){
		game.addVisualIn(gema1, game.at(12,7))
		game.addVisualIn(gema2, game.at(10,3))
		game.addVisualIn(gema3, game.at(17,2))
		
		game.hideAttributes(gema1)
		game.hideAttributes(gema2)
		game.hideAttributes(gema3)
	}
}

object mapa3 {
	var property posicionFranky = game.at(17,12)
	var property posicionFinalFranky = game.at(16,0)
	
	var jaula1 = new Jaula(position = game.at(9,6),tieneEncerrado=huesitos,activacionesNecesarias=3)
	
	
	var sierra1 = new Sierra(posicionInicial = game.at(10,8), direccionInicial = izquierda)
	var sierra2 = new Sierra(posicionInicial = game.at(10,4), direccionInicial = izquierda)
	var sierra3 = new Sierra(posicionInicial = game.at(5,5), direccionInicial = arriba)
	var sierra4 = new Sierra(posicionInicial = game.at(14,5), direccionInicial = arriba)
	var sierra5 = new Sierra(posicionInicial = game.at(11,5), direccionInicial = arriba)
	var sierra6 = new Sierra(posicionInicial = game.at(7,5), direccionInicial = arriba)
	var palanca1 = new Palanca(position = game.at(1,1),objetoCerrado=jaula1)
	var palanca2 = new Palanca(position = game.at(1,11),objetoCerrado=jaula1)
	var palanca3 = new Palanca(position = game.at(18,1),objetoCerrado=jaula1)
	
	method agregarParedes(){
		//PARED IZQUIERDA
		constructorTablero.constructorVertical(0,12,0,pared)
		
		//PARED ARRIBA
		constructorTablero.constructorHorizontal(1,15,12,pared)
		constructorTablero.constructorHorizontal(18,0,12,pared)
		
		//PARED DERECHA
		constructorTablero.constructorVertical(19,12,1,pared)
		
		//PARED ABAJO
		constructorTablero.constructorHorizontal(1,19,0,pared)
	}
	
	method agregarLaberinto() {
		constructorTablero.constructorHorizontal(3,5,3,pared)
		constructorTablero.constructorHorizontal(3,4,4,pared)
		constructorTablero.constructorHorizontal(12,4,4,pared)
		constructorTablero.constructorHorizontal(10,6,3,pared)
		
		constructorTablero.constructorHorizontal(3,0,5,pared)
		constructorTablero.constructorVertical(3,2,7,pared)
		constructorTablero.constructorHorizontal(4,0,5,pared)
		constructorTablero.constructorVertical(4,2,7,pared)
		constructorTablero.constructorVertical(5,1,8,pared)
		constructorTablero.constructorHorizontal(6,0,5,pared)
		constructorTablero.constructorVertical(6,2,7,pared)
		constructorTablero.constructorVertical(7,1,8,pared)
		//constructorTablero.constructorHorizontal(8,0,5,pared)
		//constructorTablero.constructorHorizontal(8,0,7,pared)
		constructorTablero.constructorHorizontal(8,0,9,pared)
		constructorTablero.constructorHorizontal(10,6,9,pared)
		constructorTablero.constructorHorizontal(11,5,8,pared)
		constructorTablero.constructorHorizontal(12,1,7,pared)
		constructorTablero.constructorHorizontal(15,1,7,pared)
		constructorTablero.constructorHorizontal(12,1,5,pared)
		constructorTablero.constructorHorizontal(15,1,5,pared)
		constructorTablero.constructorHorizontal(11,0,4,pared)
		
	}
	
	method agregarEnemigos() {
		sierra1.agregarEnTablero()
		sierra2.agregarEnTablero()
		sierra3.agregarEnTablero()
		sierra4.agregarEnTablero()
		sierra5.agregarEnTablero()
		sierra6.agregarEnTablero()
		
		sierra1.moverse()
		sierra2.moverse()
		sierra3.moverse()
		sierra4.moverse()
		sierra5.moverse()
		sierra6.moverse()
		game.hideAttributes(sierra1)
		game.hideAttributes(sierra2)
		game.hideAttributes(sierra3)
		game.hideAttributes(sierra4)
		game.hideAttributes(sierra5)
		game.hideAttributes(sierra6)
	}
	
	method agregarAyudas() {
		game.addVisual(jaula1)
		constructorTablero.agregarPalancaTablero(palanca1)
		constructorTablero.agregarPalancaTablero(palanca2)
		constructorTablero.agregarPalancaTablero(palanca3)
		
	}
	
	method agregarFranky() {
		game.addVisual(franky)
		franky.position(posicionFranky)
		//game.addVisual(huesitos)
		//game.hideAttributes(huesitos)
		game.hideAttributes(franky)
	}
	
	method agregarVidas() {}
}
