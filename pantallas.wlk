import wollok.game.*
import objetos.*
import colores.*
import eventos.*

object pantallaInicio {
  method mostrar() {
    game.boardGround("gameOver.png")
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

