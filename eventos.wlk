import wollok.game.*
import colores.*
import pantallas.*
import objetos.*
import aliens.*
import nave.*

 //posible implementacion de lo que nos dijo fede
class Ronda {
  const intervaloSpawn
  const tipoAlien

  method iniciar() {
    game.onTick(intervaloSpawn, "spawnAlien", { self.spawnearAlien()})
  }

  method spawnearAlien() {
    if (tipoAlien == "alienVerde") {
      spawn.alienVerde()
    } else if (tipoAlien == "alienRojo") {
      spawn.alienRojo()
    } else if (tipoAlien == "alienVioleta") {
      spawn.alienVioleta()
    }
  }
}

object eventos{
  
  const ronda1 = new Ronda(intervaloSpawn = 3000, tipoAlien = "alienVerde")
  const ronda2 = new Ronda(intervaloSpawn = 2500, tipoAlien = "alienRojo")
  const ronda3 = new Ronda(intervaloSpawn = 2000, tipoAlien = "alienVioleta")

  const rondas = [ronda1, ronda2, ronda3]

  var property rondaActual = 1

  method ganar(){
    game.clear()
    game.addVisual(gameFinalTexto)
    game.onTick(500, "parpadeoPuntajes", { gameFinalTexto.parpadear() })
    game.addVisual(misionSuperada)
    game.addVisual(volverAinicio)
    keyboard.w().onPressDo({self.reiniciar()})
  }

  method perder(){
    game.clear()
    game.addVisual(gameFinalTexto)
    game.onTick(500, "parpadeoPuntajes", { gameFinalTexto.parpadear() })
    game.addVisual(gameOver)
    game.addVisual(volverAinicio)
    keyboard.w().onPressDo({self.reiniciar()})
  }

  method jefe(){
    puntaje.reiniciarPuntosRonda()
    game.removeTickEvent("spawnAlien")
    spawn.jefe()
  }

  method muerteJefe() {       // Método que avanza a la siguiente ronda tras la derrota del jefe
    rondaActual += 1
    if (rondaActual > rondas.size()) {
      self.ganar()            // Si se completaron todas las rondas, se gana el juego
    } else {
      self.nuevaRonda()       // Si no, se inicia una nueva ronda
    }
  }

   method nuevaRonda() {      // Método que inicia la ronda correspondiente
    game.clear()              // Limpia la pantalla del juego
    rondas[rondaActual - 1].iniciar()     // Inicia la ronda actual con su configuración específica
  }

   method reiniciar() {
    game.clear()
    rondaActual = 1         //lo unico que cambia es este nombre
    nave.reiniciar()
    puntaje.reiniciar()
    game.addVisual(puntaje)
    game.addVisual(vidaNave)
    game.addVisualCharacter(nave)
    keyboard.space().onPressDo({nave.disparar()})
    self.nuevaRonda()  // Inicia la primera ronda
  }

  method reiniciarRonda(){
    game.clear()
    game.addVisual(puntaje)
    game.addVisual(vidaNave)
    game.addVisualCharacter(nave)
    keyboard.space().onPressDo({nave.disparar()})
  }

  method powerUp() {
    nave.agregarVida(40)
    nave.subirNivel()
    puntaje.reiniciarPuntosPower()
  }
}
/*
object eventos{

  var property ronda = 1 
  method ganar(){
    game.clear()
    game.addVisual(gameFinalTexto)
    game.onTick(500, "parpadeoPuntajes", { gameFinalTexto.parpadear() })
    game.addVisual(misionSuperada)
    game.addVisual(volverAinicio)
    keyboard.w().onPressDo({self.reiniciar()})
  }
  method perder(){
    game.clear()
    game.addVisual(gameFinalTexto)
    game.onTick(500, "parpadeoPuntajes", { gameFinalTexto.parpadear() })
    game.addVisual(gameOver)
    game.addVisual(volverAinicio)
    keyboard.w().onPressDo({self.reiniciar()})
  }

  method jefe(){
    puntaje.reiniciarPuntosRonda()
    game.removeTickEvent("spawnAlien")
    spawn.jefe()

  }

  method muerteJefe() {
    ronda += 1
    if (ronda == 4) self.ganar()
    else self.nuevaRonda()
  }

  method nuevaRonda() {
    if(ronda == 1) {
      game.onTick(3000, "spawnAlien", { spawn.alienVerde() })
    }
    else if (ronda == 2) {
      game.onTick(2500, "spawnAlien", { spawn.alienRojo() })
    }
    else if (ronda == 3) {
      game.onTick(2000, "spawnAlien", { spawn.alienVioleta() })
    }
  }

  method reiniciar(){
    game.clear()
    ronda = 1
    nave.reiniciar()
    puntaje.reiniciar()
    game.addVisual(puntaje)
    game.addVisual(vidaNave)
    game.addVisualCharacter(nave)
    keyboard.space().onPressDo({nave.disparar()})
    self.nuevaRonda()
  }

  method reiniciarRonda(){
    game.clear()
    game.addVisual(puntaje)
    game.addVisual(vidaNave)
    game.addVisualCharacter(nave)
    keyboard.space().onPressDo({nave.disparar()})
  }

  method powerUp() {
    nave.agregarVida(40)
    nave.subirNivel()
    puntaje.reiniciarPuntosPower()
  }
}
*/
object spawn{
  method alienVerde(){
    const nuevoAlien = new AlienVerde()
    nuevoAlien.config()
  }

  method alienRojo(){
    const nuevoAlien = new AlienRojo()
    nuevoAlien.config()
  }

  method alienVioleta(){
    const nuevoAlien = new AlienVioleta()
    nuevoAlien.config()
  }


  method jefe() {
    const nuevoJefe = new Jefe()
    nuevoJefe.config()
  }
}








