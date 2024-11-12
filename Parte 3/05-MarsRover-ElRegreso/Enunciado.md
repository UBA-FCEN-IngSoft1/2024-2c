# MarsRover El Regreso

Para hacer un seguimiento del MarsRover, nos han pedido la siguiente funcionalidad:
1. Tener un log donde se vayan agregando los cambios de la posición y los cambios de hacia dónde apunta el MarsRover. Se tiene que poder seguir sólo los cambios de posición o sólo los cambios de dirección o ambos simultáneamente.
2. Tener una "ventana" donde se muestre la posición actual y hacia donde apunta el MarsRover actualmente. De la misma forma que con el log, se debe poder ver sólo la posición actual o sólo los cambios de dirección o ambos simultáneamente.

**La diferencia entre 1 y 2** es que **1** es un log donde van quedando todos los cambios y **2** sólo muestra la situación actual en unos text fields de una ventana.

Es necesario que la solución soporte que solo se esté usando el log, o solo la ventana o ambos al mismo tiempo.

## Ejemplos de funcionalidad

1. Si se está siguiendo los cambios de posición con el log:
   * Si el MarsRover empieza en 1@1 apuntando al norte y se procesa una f, en el log se espera una línea con 1@2
   * Si el MarsRover empieza en 1@1 apuntando al norte y se procesa ff, en el log se espera una línea con 1@2 y otra con 1@3
2. Si se está siguiendo los cambios de hacia donde apunta con el log:
   * Si el MarsRover empieza en 1@1 apuntando al norte y se procesa una r, en el log se espera una línea con East
   * Si el MarsRover empieza en 1@1 apuntando al norte y se procesa una rl, en el log se espera una línea con East y otra con North
3. Si se está siguiendo los cambios de posición y hacia donde apunta con el log:
   * Si el MarsRover empieza en 1@1 apuntando al norte y se procesa una fr, en el log se espera una línea con 1@2 y otra con East
4. Si se está siguiendo los cambios de posición y hacia donde apunta con la ventana:
   * Si el MarsRover empieza en 1@1 apuntando al norte y se procesa una frf, se espera que:
     *  después de la primera f, el campo de posición diga 1@2 y el de heading nada.
     *  después de procesar la r, el el campo de posición diga 1@2 y el de heading "Apuntando al Este".
     *  después de procesar la segunda f, el el campo de posición diga 2@2 y el de heading "Apuntando al Este".

Adicionalmente, la solución debe ser extensible. O sea, se debe poder agregar otras maneras de hacer el seguimiento del MarsRover como mandar mensajes a un micro servicio, grabarlo en una base de datos, etc. sin que esto implique una modificación en el mismo.

También la solución debe soportar que se puedan seguir los cambios de algún otro colaborador que el MarsRover pueda tener. Por ejemplo, si se le agrega un colaborador para temperatura entonces se debe, fácilmente y con la menor cantidad de cambios posibles al MarsRover, poder seguir las modificaciones de temperatura.

Construir esta funcionalidad haciendo TDD y en base a la solución de la cátedra del MarsRover.
