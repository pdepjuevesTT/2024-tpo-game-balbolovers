PdeP Invaders

## Equipo de desarrollo

- Manuel Cejas
- Geronimo Basso Arroyo
- Francisco Gonzalez Miel
- Mirko Peschel

## Capturas

(agregar)

## Reglas de Juego / Instrucciones
El juego¹ se basa en el famoso Space Invaders. Éste contiene el personaje que nosotros controlamos², que es una nave³ que esta en la parte inferior de la pantalla la cual podremos mover hacia los costados² con el objetivo de esquivar y disparar⁴ a los aliens³, las entidades enemigas a las que tendremos que eliminar⁵ para obtener puntos y PowerUps. Estos cuentan con vida⁶ y cada uno otorga una distinta cantidad de puntos⁷ al ser eliminado, con el avanzar del juego tambien mejoraran sus habilidades pudiendo disparar, aumentar su vida, entre otras cosas, esto varia segun el tipo⁸ de alien. Cuando se llegue a una cierta cantidad de puntos (según los aliens derrotados) aparecera un jefe⁹, el cual tambien deberemos derrotar para continuar sumando puntos. El juego termia cuando nuestra nave se quede sin vida (perdemos)¹⁰ o cuando llegamos a los 3000 puntos (ganamos)¹¹, en cualquiera de los dos casos el juego finaliza y se muestran los puntos por pantalla¹².

**Conceptos Aplicados:**
- 1: Utilizando Wollok Game con bibliotecas y mensajes como: "import wollok.game.*" y "game.start()". Sin ellas el juego no funciona.
- 2: El control que tenemos sobre la nave es gracias a que le decimos: "game.addVisualCharacter(nave)" para que el juego sepa que ese es el elemento que queremos controlar. Y con "keyboard.tecla().onPressDo{nave.hacerAlgo()}"
- 3: Es posible visualizar a los personajes de nuestro juego gracias a un metodo que cada entidad tiene con su respectiva imagen, como: "method image() = "nave60v2.png"" o "method image() = "alienRojo60.png"". Y para mostrar o quitar las visuales del tablero con: "game.addVisual()" y "game.removeVisual()".
- 4: Es un Evento Automatico que cada tanto tiempo ("onTick()") se mueve un casillero hacia arriba.
- 5: Se basa en Colisiones, cuando la bala choca con el alien desaparece ("game.onCollideDo(bala, {alien => alien.perderVida(danio) bala.desaparecer()})") y al mismo tiempo el alien pierde vida, si éste muere desaparece ("game.removeVisual()").
- 6: "var vida = 50" Definida por una referencia o atributo vida, con valor inicial 50.
- 7: Al morir el alien, se ejecuta: "puntaje.cambiarPuntos(50)" (Suma puntos basados en la vida del alien).
- 8:
- 9:
- 10: La nave cuenta con 100 puntos de vida ("var vida = 100"), si ésta se queda sin vida ("if(vida <= 0) nave.morir()") muere ("game.removeVisual(nave)") y perdemos ("eventos.perder()").
- 11:
- 12:
  
## Otros

- K2033 UTN
- Versión de wollok: 0.2.6
