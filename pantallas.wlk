import wollok.game.*
import objetos.*
import colores.*
import eventos.*
import aliens.*
import nave.*

object pantallaInicio {
  method mostrar() {
    game.boardGround("gameOverrr.png")
    game.addVisual(tituloParpadeante)
    game.onTick(500, "parpadeoTitulo", { tituloParpadeante.parpadear() })
  }
}

object tituloParpadeante {
  var visible = true
  method text() = "PRESIONE 'W' PARA COMENZAR"
  method position() = game.center().down(5)
  method textColor() = paleta.blanco()

  method parpadear() {
    if (visible) game.removeVisual(self)
    else game.addVisual(self)
    visible = !visible
  }
}

object gameOver{
  method image() = "gameOverrr.png"
  var property position = game.center().up(8).right(5)
}

object misionSuperada{
  method image() = "mision superada.png"
  var property position = game.center().up(8).right(3)
}


object gameFinalTexto {
  method text() = "TU PUNTAJE FUE DE: " + puntaje.puntos()
  method position() = game.center().down(3)
  method textColor() = paleta.blanco()
}

object volverAinicio {
  var visible = true
  method text() = "PRESIONE 'W' PARA VOLVER AL INICIO"
  method position() = game.center().down(5)
  method textColor() = paleta.blanco()

  method parpadear() {
    if (visible) game.removeVisual(self)
    else game.addVisual(self)
    visible = !visible
  }
}