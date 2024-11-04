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
      vidaNave.actualizarVida(vida)
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
  
    method confColisiones(){
      game.onCollideDo(self, {nave => nave.perderVida(danio) self.morir() })
    } 

    method bajar(){
        position = position.down(1)

        if (contadorMovimientos >= 22)  
            self.morir()

        contadorMovimientos += 1 
        //const x = 0.randomUpTo(game.width()).truncate(0)
        //const y = 0.randomUpTo(game.width()).truncate(0)
        //position = game.at(x,y)
        if (contadorMovimientos >= 22){  
            nave.perderVida(danio)
            self.morir()}   

    }

    method moverse(){
      game.onTick(300, "movimientoAlien", { self.bajar() })
    }

  
}

object spawn{
  method alienVerde(){
    const nuevoAlien = new Alien()
    game.addVisual(nuevoAlien)
    nuevoAlien.confColisiones()
    nuevoAlien.moverse()
    if (puntaje.puntos() > 200) game.removeTickEvent("spawnVerde")
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

    method perderVida(_){}

}

object puntaje { 
var property puntos = 0
method cambiarPuntos(n){puntos += n}
method text() = "PUNTOS: " + puntos
method position() = game.center().right(11).up(12)
method textColor() = paleta.blanco()
}

// Objeto para mostrar la vida de la nave en pantalla
object vidaNave { 
  var vidaRestante = 100
  method actualizarVida(n) {vidaRestante = n}
  method text() = "VIDA: " + vidaRestante
  method position() = game.center().right(11).up(11)  
  method textColor() = paleta.rojo() 
}