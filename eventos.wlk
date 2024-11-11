import wollok.game.*
import colores.*
import pantallas.*
import objetos.*
import aliens.*
import nave.*


//class Ronda {
 // const 
//}

object eventos{
 // const rondas = [ronda1, ronda2]

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
      game.onTick(2500, "spawnAlien", { spawn.alienVerde() })
    }
    else if (ronda == 2) {
      game.onTick(2000, "spawnAlien", { spawn.alienRojo() })
    }
    else if (ronda == 3) {
      game.onTick(1500, "spawnAlien", { spawn.alienVerde2() })
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

  method borrarVisuales(){
    game.allVisuals().map({visual => game.removeVisual(visual)})
  }
}

object spawn{
  method alienVerde(){
    const nuevoAlien = new AlienVerde()
    nuevoAlien.config()
  }

  method alienRojo(){
    const nuevoAlien = new AlienRojo()
    nuevoAlien.config()
  }

  method alienVerde2(){
    const nuevoAlien = new AlienVerde2()
    nuevoAlien.config()
  }


  method jefe() {
    const nuevoJefe = new Jefe()
    nuevoJefe.config()

  }
}








