import wollok.game.*
import colores.*
import pantallas.*
import eventos.*
import nave.*
import objetos.*


//const x = 0.randomUpTo(game.width()).truncate(0)
        //const y = y.randomUpTo(y).truncate(0)
        //const x = x-1.randomUpTo(x+1).truncate(0)
        //position = game.at(x,y)

class Alien {
  
    method image() = "alienVerde60.png"
    var property position = new MutablePosition(x = 0.randomUpTo(game.width()).truncate(0) , y = 23)
    //posicionAleatoria.calcular()
    //new MutablePosition(calcular.posicionAleatoria())
    var vida = 50
    const danio = 1
    var id = 0.randomUpTo(10000)  // Genera un identificador único para cada alien
    var moviendo = false

    method perderVida(n) {
    vida = vida-n
    if(vida <= 0) self.morir()
    }

    method morir() {
    puntaje.cambiarPuntos(50) // Suma puntos basados en la vida del alien
    self.detenerMovimiento()
    game.removeVisual(self)
    }
  
    method confColisiones(){
      game.onCollideDo(self, {nave => nave.perderVida(danio) self.morir() })
    } 

    method bajar(){
        position.goDown(1)
       
        if (position.y() == 1){  
            nave.perderVida(danio)
            self.desaparecer()}   
    }

    method desaparecer() {
      game.removeVisual(self)
    }


method moverse() {
    moviendo = true
    game.onTick(700, "movimientoAlien" + id, { 
      if (moviendo) self.bajar() 
    })
  }

  method detenerMovimiento() {
    moviendo = false
    game.removeTickEvent("movimientoAlien" + id)
  }
  
}


/*object jefeAlien {
  const hitbox = lista 


}
*/

class Jefe {
  var property position = new MutablePosition(x = 0.randomUpTo(game.width()).truncate(0) , y = 23)
  var property image = "alienRojo60.png"
  
  var vida = 50 * nivel
  const danio = 20 * nivel

  var property nivel = eventos.ronda()

  method confColisiones(){
      game.onCollideDo(self, {nave => nave.perderVida(danio) })
    }

  method perderVida(n) {
      vida = vida-n
      if(vida <= 0) self.morir()
    }
  method morir() {
      game.removeVisual(self)
      game.removeTickEvent("disparar")
      game.removeTickEvent("izquierda")
      game.removeTickEvent("derecha")
      eventos.muerteJefe()
    }

  method disparar() {
    const nuevoTiro = new Tiro(danio = danio, position = new MutablePosition(x = position.x(), y = position.y() - 1))
    game.addVisual(nuevoTiro)
    nuevoTiro.confColisiones()
    nuevoTiro.moverseAbajo()
    
  }

  method izquierda(){
    position.goLeft(1)
    self.controlarMovimiento()
  }

  method derecha() {
    position.goRight(1)
    self.controlarMovimiento()
  }

  method movimientoDerecha() {
    game.onTick(500,"derecha",{self.derecha()})
  }

  method movimientoIzquierda() {
    game.onTick(500,"izquierda",{self.izquierda()})
  }

  method controlarMovimiento() {
    if(position.x() == 24) {
      game.removeTickEvent("derecha")
      self.movimientoIzquierda()
    } 
    else if(position.x() == 1) {
      game.removeTickEvent("izquierda")
      self.movimientoDerecha()
    }
  }

  method confDisparo() {
    game.onTick(2000, "disparar" , {self.disparar()})
  }

  method config() {
    self.confColisiones()
    self.movimientoDerecha()
    self.confDisparo()
  }

}