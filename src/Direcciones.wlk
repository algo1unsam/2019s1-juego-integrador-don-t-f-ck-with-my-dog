
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