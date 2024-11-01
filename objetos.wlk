import wollok.game.*
import colores.*
object nave {
  method image() = "nave60v2.png"
  var property position = game.center()
  method posicion() = position
  var poder = 50




  var vida = 100
  method disparar() {
    const nuevoTiro = new Tiro(danio = poder, position = position.up(2))
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


/*object jefeAlien {
  const hitbox = lista 


}
*/

class Alien {
  
    method image() = "alienRojo60.png"

    var property position = game.center().right(12).up(10)
    
    var vida = 50
    const danio = 20
    method perderVida(n) {
    vida = vida-n
    if(vida <= 0) self.morir()
    }
    method morir() {
    puntaje.cambiarPuntos(50) // Suma puntos basados en la vida del alien
    game.removeVisual(self)
}


    method confColisiones(){
      game.onCollideDo(self, {nave => nave.perderVida(danio) self.morir() })
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
    method image() = "bala60.png"
    var property position 
    var danio = 50
    var contadorMovimientos = 0

    method subir(){
        position = position.up(1)
        contadorMovimientos += 1 
        if (contadorMovimientos >= 24)  
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

    method perderVida(n){}

}

object puntaje { 
var puntos = 0
method cambiarPuntos(n){puntos += n}
method text() = "PUNTOS: " + puntos
method position() = game.center().right(11).up(12)
method textColor() = paleta.blanco()
}