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

class Alien inherits Enemigo() {
  const puntos
    
  const id = 0.randomUpTo(10000)  // Genera un identificador único para cada alien
  var moviendo = false

  override method morir() {
    super()
    puntaje.cambiarPuntos(puntos)
    self.detenerMovimiento()
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

  override method config(){
    super()
    self.moverse()
  }
  
}

class AlienVerde inherits Alien(puntos = 50, danio = 20, vida = 50){
  var property image = "alienVerde60.png"
}

class AlienRojo inherits Alien(puntos = 50, danio = 40, vida = 50){
  var property image = "alienRojo60.png"
}

class AlienVioleta inherits Alien(puntos = 50, danio = 40, vida = 70){
  var property image = "alienVioleta.png"
}

class Jefe inherits Enemigo(vida = 50 * nivel, danio = 50 * nivel) {
  var property image = "jefeBlanco1.png"

  override method morir() {
      super()
      game.removeTickEvent("disparar")
      game.removeTickEvent("izquierda")
      game.removeTickEvent("derecha")
      eventos.muerteJefe()
    }
  
  override method desaparecer() {}

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

  override method config() {
    super()
    self.movimientoDerecha()
    self.confDisparo()
  }

}

class Enemigo{
  var property position = new MutablePosition(x = 0.randomUpTo(game.width()).truncate(0) , y = 23)

  var property nivel = eventos.rondaActual //antes: var property nivel = eventos.ronda()
  var vida
  var danio

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
  
  method desaparecer() {
    game.removeVisual(self)
  }

  method config(){
    game.addVisual(self)
    self.confColisiones()
  }

  
}