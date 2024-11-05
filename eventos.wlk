import wollok.game.*
import colores.*
import pantallas.*
import objetos.*

object eventos{
  method ganar(){
    self.borrarVisuales()
  }
  method perder(){
    self.borrarVisuales()
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
    if (puntaje.puntos() > 200) game.removeTickEvent("spawnVerde")
  }
}
