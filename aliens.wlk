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
  var puntos
  const property velocidadSpawn
    
  const id = 0.randomUpTo(10000)  // Genera un identificador único para cada alien
  var moviendo = false

  override method morir() {
    self.detenerMovimiento()
    super()
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

class AlienVerde inherits Alien(puntos = 50, danio = 20, vida = 50, velocidadSpawn = 2500){
  var property image = "alienVerde60.png"

  override method morir(){
    puntaje.cambiarPuntos(puntos)
    super()
  }

}

class AlienRojo inherits Alien(puntos = 70, danio = 40, vida = 50, velocidadSpawn = 2000){
  var property image = "alienRojo60.png"

  override method morir(){
    puntaje.cambiarPuntos(puntos)
    super()
  }

}

class AlienVerde2 inherits Alien(puntos = 70, danio = 40, vida = 70, velocidadSpawn = 1500){
  var property image = "alienVerde260.png"

  override method morir(){
    puntaje.cambiarPuntos(puntos)
    super()
  }

}
/*
class AlienVerde2 inherits AlienRojo(danio = 40, vida = 70, velocidadSpawn = 1500){
  override var property image = "alienVerde260.png"
}
*/
class Jefe inherits Enemigo(vida = 50 * nivel, danio = 20 * nivel) {
  var property image = "alienRojo60.png"

  override method morir() {
      super()
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

  override method config() {
    super()
    self.movimientoDerecha()
    self.confDisparo()
  }

}

class Enemigo{
  var property position = new MutablePosition(x = 0.randomUpTo(game.width()).truncate(0) , y = 23)

  var property nivel = eventos.ronda()
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
      game.onCollideDo(self, {nave => nave.perderVida(danio) })
  }
  
  method config(){
    game.addVisual(self)
    self.confColisiones()
  }
}