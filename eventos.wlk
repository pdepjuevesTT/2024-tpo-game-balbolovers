import wollok.game.*
import colores.*
import pantallas.*
import objetos.*
import aliens.*
import nave.*

object eventos{
  var property ronda = 1 
  method ganar(){
    game.clear()
    game.addVisual(gameFinalTexto)
    game.addVisual(misionSuperada)
  }
  method perder(){
    game.clear()
    game.addVisual(gameFinalTexto)
    game.addVisual(gameOver)
  }

  method jefe(){
    if(ronda == 1){
      game.removeTickEvent("spawnVerde")
      spawn.jefe()
    
  }

  }

  method muerteJefe() {
    ronda += 1
    self.nuevaRonda()
  }

  method nuevaRonda() {
    if(ronda == 1) {
      game.onTick(2000, "spawnVerde", { spawn.alienVerde() })
    }
    
  }

  method powerUp() {
    nave.agregarVida(40)
    nave.subirNivel()

  }

  method borrarVisuales(){
    game.allVisuals().map({visual => game.removeVisual(visual)})
  }
}

object spawn{
  method alienVerde(){
    const nuevoAlien = new Alien()
    game.addVisual(nuevoAlien)
    nuevoAlien.confColisiones()
    nuevoAlien.moverse()
  }
  method jefe() {

  }
}






