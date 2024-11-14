import wollok.game.*
import objetos.*
import colores.*
import eventos.*
import aliens.*
import nave.*

object gameOver{
  method image() = "gameOverrr.png"
  var property position = game.center().up(8).right(5)
}

object misionSuperada{
  method image() = "mision superada.png"
  var property position = game.center().up(8).right(3)
}

object tituloSpace{
  method image() = "spaceInvadersTitulo.png"
  var property position = game.origin().up(14).right(5)
}

object gameFinalTexto {
  var visible = true
  method text() = "TU PUNTAJE FUE DE: " + puntaje.puntos()
  method position() = game.center().down(3)
  method textColor() = paleta.blanco()

  method parpadear() {
    if (visible) game.removeVisual(self)
    else game.addVisual(self)
    visible = !visible
  }
}

object volverAinicio {
  method text() = "PRESIONE 'W' PARA VOLVER A JUGAR"
  method position() = game.center().down(5)
  method textColor() = paleta.blanco()
}