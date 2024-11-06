import wollok.game.*
import colores.*
import pantallas.*
import eventos.*
import aliens.*
import objetos.*

object nave {
  var property nivel = 1
  method image() = "nave60v2.png"
  var property position = game.center()
  method posicion() = position
  var poder = 50
  var vida = 100

  method subirNivel(){
    nivel += 1

  }

  method disparar() {
    const nuevoTiro = new Tiro(danio = poder, position = position.up(2))
    game.addVisual(nuevoTiro)
    nuevoTiro.confColisiones()
    nuevoTiro.moverse()
    
  }
  
  method perderVida(n) {
      vida = vida-n
      vidaNave.actualizarVida(vida)
      if(vida <= 0) self.morir()
    }
    method morir() {
      game.removeVisual(self)
      eventos.perder()
    }
  method agregarVida(n){
    vida += n
  }
}

class Tiro {
    method image() = "bala60.png"
    var property position 
    var danio = 50
    var contadorMovimientos = 0

    method subir(){
        position = position.up(1)
        contadorMovimientos += 1 
        if (contadorMovimientos == 24)  
            self.desaparecer()
    }

    method moverse(){
      game.onTick(150, "movimiento", { self.subir() })
    }
    method confColisiones(){
      game.onCollideDo(self, {alien => alien.perderVida(danio) self.desaparecer()})
    }
    method desaparecer() {
      game.removeVisual(self)
    }

    method perderVida(_){}

}
