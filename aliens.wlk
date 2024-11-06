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
  
    method image() = "alienRojo60.png"
    var property position = posicionAleatoria.calcular()
  
    var vida = 50
    const danio = 20
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
        position = position.down(1)
       
        if (position.y() == 1){  
            nave.perderVida(danio)
            self.desaparecer()}   
    
    }

    method desaparecer() {
      game.removeVisual(self)
    }


method moverse() {
    moviendo = true
    game.onTick(300, "movimientoAlien_" + id, { 
      if (moviendo) self.bajar() 
    })
  }

  method detenerMovimiento() {
    moviendo = false
    game.removeTickEvent("movimientoAlien_" + id)
  }
  
}


/*object jefeAlien {
  const hitbox = lista 


}
*/

class Jefe {
  var property position = posicionAleatoria.calcular()
  
    var vida = 50 * nivel
    const danio = 20 * nivel

    var property nivel = eventos.ronda()

    method perderVida(n) {
      vida = vida-n
      if(vida <= 0) self.morir()
    }
    method morir() {
      game.removeVisual(self)
    }

}