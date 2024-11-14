import wollok.game.*
import colores.*
import pantallas.*
import eventos.*
import aliens.*
import objetos.*

object nave {
  var property nivel = 1
  var property image = "naveEtapa1.png"
  var property position = new MutablePosition(x = game.origin().x(), y = game.origin().y())
  method posicion() = position
  var poder = 50
  var vida = 100

  method subirNivel(){
    nivel += 1
    self.cambiarImagen()
  }

  method reiniciar() {
    nivel = 1
    self.cambiarImagen()
    vida = 100
    vidaNave.actualizarVida(vida)
    self.confColisiones()
    self.confColisiones()
  }

  method cambiarImagen(){
    image = "navEtapa" + nivel +".png"
  }

  method disparar() {
    const nuevoTiro = new Tiro (danio = poder, position = new MutablePosition(x = position.x(), y = position.y() + 1))
    game.addVisual(nuevoTiro)
    nuevoTiro.confColisiones()
    nuevoTiro.moverseArriba()
    
  }
  
  method perderVida(n) {
    vida = vida - n
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

  method confColisiones(){
      game.onCollideDo(self, {alien => alien.perderVida(poder) self.perderVida(20) })
  }
}

class Tiro {
  method image() = "balaV2.png"
  var property position 
  var danio = 50
  var id = 0.randomUpTo(10000)
  var moviendo = false
  var estado = 0

  method subir(){
    position.goUp(1)
    self.fueraTablero(24)
  }

  method bajar(){
    position.goDown(1)
    self.fueraTablero(1)
  }

  method fueraTablero(n) {
    if (position.y() == n)  
      {self.desaparecer()
      self.detenerMovimiento()}
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

  method detenerMovimiento() {
    moviendo = false
    if (estado == 1)
    {game.removeTickEvent("balaSubida" + id)}
    else if (estado == -1)
    {game.removeTickEvent("balaBajada" + id)}
  }
}