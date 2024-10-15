import wollok.game.*

object nave {
  var property image = "nave.png"
  var property position = game.center().down(5)
  method posicion() = position

  method moverseIzquierda() {
		position = if ((position.x() - 1) < 0) 
		           		position.left(1) else
		           	 position
	}
	
	method moverseDerecha() {
		position = if ((position.x() + 1) > 19)
		           		position.right(1) else position           	
	}





  var vida = 100
  method disparar() {
    
  }
  
  method sacarVida(n) {
      vida = vida-n
      if(vida <= 0) self.morir()
    }
    method morir() {
      
    }
}

object alien {

var property image = "alienVerde.png"

method position() = game.center().right(5).up(5)

    var vida = 50
    method sacarVida(n) {
      vida = vida-n
      if(vida <= 0) self.morir()
    }
    method morir() {
      
    }


    method pegar(){
        
    }
    
}

object tiro {
    var property image = "bala.png"
    method position() = nave.posicion()
    method desaparecer() {
      
    }

}
