import wollok.game.*
import colores.*
import pantallas.*
import eventos.*
import aliens.*
import nave.*

object posicionAleatoria {
  method calcular() = game.at(
    0.randomUpTo(game.width()).truncate(0), 23
  )
}

object puntaje { 
var property puntos = 0
method cambiarPuntos(n){
  puntos += n
  self.chequearEventos()
}

method chequearEventos(){
  if(puntos == 1000) eventos.jefe()
  if(puntos == 750) eventos.powerUp()

}

method text() = "PUNTOS: " + puntos
method position() = game.center().right(11).up(12)
method textColor() = paleta.blanco()
}

// Objeto para mostrar la vida de la nave en pantalla
object vidaNave { 
  var vidaRestante = 100
  method actualizarVida(n) {vidaRestante = n}
  method text() = "VIDA: " + vidaRestante
  method position() = game.center().right(11).up(11)  
  method textColor() = paleta.rojo() 
}


//const x = 0.randomUpTo(game.width()).truncate(0)
        //const y = y.randomUpTo(y).truncate(0)
        //const x = x-1.randomUpTo(x+1).truncate(0)
        //position = game.at(x,y)