import wollok.game.*

object nave {
  method image() = "nave.png"
  var property position = game.center().down(5)
  method posicion() = position




  var vida = 100
  method disparar() {
    const disparo = new Tiro()
    
  }
  
  method sacarVida(n) {
      vida = vida-n
      if(vida <= 0) self.morir()
    }
    method morir() {
      
    }
}

class Alien {

method image() = "alienVerde.png"

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

class Tiro {
    method image() = "bala.png"
    var property position = nave.posicion()

    method moverse(){
        position = position.up(1)
    }
    method desaparecer() {
      
    }

}
