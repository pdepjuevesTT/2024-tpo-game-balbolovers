import wollok.game.*

object nave {
  method image() = "nave.png"
  var property position = game.center().down(5)
  method posicion() = position
  var poder = 50




  var vida = 100
  method disparar() {
    const nuevoTiro = new Tiro(danio = poder)
    game.addVisual(nuevoTiro)
    nuevoTiro.confColisiones()
    nuevoTiro.moverse()
    
  }
  
  method perderVida(n) {
      vida = vida-n
      if(vida <= 0) self.morir()
    }
    method morir() {
      game.removeVisual(self)
    }
}

class Alien {

    method image() = "alienVerde.png"

    var position = game.center().right(5).up(5)

    var vida = 50
    const danio = 20
    method perderVida(n) {
    vida = vida-n
    if(vida <= 0) self.morir()
    }
    method morir() {
      game.removeVisual(self)
    }


    method confColisiones(){
      game.onCollideDo(self, {nave => nave.perderVida(danio)})
    }

   method abajo(){
        position = position.down(1)
    }
    method derecha(){
        position = position.right(1)
    }
    method izquierda(){
        position = position.left(1)
    }
    method movimiento() {

    }
}

class Tiro {
    method image() = "bala.png"
    var property position = nave.posicion()
    var danio = 50

    method subir(){
        position = position.up(1)
    }
    method moverse(){
      game.onTick(100, "movimiento", { self.subir() })
    }
    method confColisiones(){
      game.onCollideDo(self, {alien => alien.perderVida(danio) self.desaparecer()})
    }
    method desaparecer() {
      game.removeVisual(self)
    }

}
