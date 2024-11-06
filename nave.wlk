import wollok.game.*
import colores.*
import pantallas.*
import eventos.*
import aliens.*
import objetos.*

object nave {
  var property nivel = 1
  var property image = "naveEtapa1.png"
  var property position = game.origin()
  method posicion() = position
  var poder = 50
  var vida = 100
  method estadisticas() = "ESTADISTICAS AUMENTADAS"

  method subirNivel(){
    nivel += 1
    self.cambiarImagen()
    game.say(self,self.estadisticas())
  }



  method cambiarImagen(){
    if(nivel == 2) image = "naveEtapa2.png"
    else if(nivel == 3) image = "naveEtapa3.png"
    else if(nivel == 4) image = "naveEtapa4.png"
  }

  method disparar() {
    const nuevoTiro = new Tiro(danio = poder, position = position.up(1))
    game.addVisual(nuevoTiro)
    nuevoTiro.confColisiones()
    nuevoTiro.moverseArriba()
    
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
    vidaNave.actualizarVida(vida)
  }
}

class Tiro {
    method image() = "balaV2.png"
    var property position 
    var danio = 50
    var id = 0.randomUpTo(10000)
    var moviendo = false
    var estado = 0
    method subirAux(){
        position = position.up(1)
        self.fueraTablero(24)
    }

    method subir(){
      position = position.up(1)
      self.fueraTablero(24)
    }

    

    method bajar(){
      position = position.down(1)
      self.fueraTablero(0)
    }

    method fueraTablero(n) {
      if (position.y() == n)  
            self.desaparecer()
    }


    method confColisiones(){
      game.onCollideDo(self, {alien => alien.perderVida(danio) self.desaparecer()})
    }
    method desaparecer() {
      game.removeVisual(self)
    }

    method perderVida(_){}

method moverseArriba() {
    estado = 1
    moviendo = true
    game.onTick(150, "balaSubida" + id, { 
      if (moviendo) self.subir() 
    })
  }

  method moverseAbajo() {
    estado = -1
    moviendo = true
    game.onTick(150, "balaBajada" + id, { 
      if (moviendo) self.bajar() 
    })
  }

  method detenerMovimientoBajada() {
    moviendo = false
    if (estado == 1)
    game.removeTickEvent("balaSubida" + id)
else if (estado == -1)
    game.removeTickEvent("balaBajada" + id)
  }
  


}
