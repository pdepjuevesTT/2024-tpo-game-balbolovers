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

object posicionAleatoria {
  method calcular() = game.at(
    0.randomUpTo(game.width()).truncate(0), 23
  )
}


/*
object posicionAleatoria {
method calcular() {
      const x = 0.randomUpTo(game.width()).truncate(0)
    position = game.at(0.randomUpTo(game.width()).truncate(0), 23)
  }
}
*/
class Alien {
  
    method image() = "alienRojo60.png"
    var property position = posicionAleatoria.calcular()
    var contadorMovimientos = 0
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
  
    //method movete() {
    //const x = 0.randomUpTo(game.width()).truncate(0)
    //const y = 0.randomUpTo(game.height()).truncate(0)
    //position = game.at(x,y)
  //}


    method confColisiones(){
      game.onCollideDo(self, {nave => nave.perderVida(danio) self.morir() })
    } 

   
   
  method bajar(){
        position = position.down(1)
        contadorMovimientos += 1 
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.width()).truncate(0)
        position = game.at(x,y)
        if (contadorMovimientos >= 22)  
            self.desaparecer()
    }

    method moverse(){
      game.onTick(300, "movimientoAlien", { self.bajar() })
    }

    method desaparecer() {
      game.removeVisual(self)
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