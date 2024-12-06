# Sandpiles

## César Carios & Jhonatan Homsany

### Información general

Este proyecto ha sido desarrollado para la asignatura Lenguajes de Programación en el semestre 2-2024. El código fuente no tiene una función _main_, así que para ejecutarlo y probar cada función por separado se debe utilizar el intérprete de Haskell: GHCI.

### Pasos para la ejecución del programa

1. Abrir la consola de comandos en la ruta donde ha sido descargado el código fuente.
2. Escribir el comando _GHCI_ para iniciar el intérprete de Haskell.
3. Luego de haber iniciado, se podrán introducir comandos al intérprete. Ahora se debe cargar el archivo con el código fuente usando el comando _:l Proyecto1.hs_.
4. Llegado a este punto, ya se pueden introducir las funciones del código fuente con sus parámetros para ser ejecutadas individualmente.

### Instancia de Show: Uso de {-# OVERLAPPING #-}

Para poder imprimir las matrices con un formato legible, fue necesario crear una instancia de Show. La nueva instancia de Show creada define cómo se debe mostar una lista de listas. Ahora bien, para que esta instancia pudiera ejecutarse sin problemas fue necesario usar en su firma la anotación {-OVERLAPPING-}, esto le indica al compilador que use esa instancia aunque haya otras instancias de Show. Sin esta anotación ocurría un error al intentar imprimir las matrices del programa. El uso de OVERLAPPING en este caso fue consultado de la siguiente web https://serokell.io/blog/learn-from-errors-overlapping-instances. Allí describen el problema que teníamos al no usar OVERLAPPING y cómo se resolvía usándolo.

### Material consultado: Hoogle y Zvon

Las páginas webs hoogle.haskell.org y zvon.org fueron de gran utiidad para investigar el funcionamiento de funciones de orden superior del **Prelude** que nos podían servir para el proyecto. Fue de dichas páginas donde consultamos la función _zip_ y nos sirvió para la función _sandpilesSum_. En esta función definimos una lista por comprensión que suma componente a componente los elementos de las matrices introducidas, y esto lo hace _zip_ juntando los elementos de cada matriz en tuplas para luego sumarlos.

### Modificación de IO en la firma de _sanpilesSimulate_ y _sandpilesSum_

Fue necesario añadir IO a la firma de las funciones _sandpilesSimulate_ y _sandpilesSum_ para poder realizar operaciones de entrada y salida. En este caso, el IO es necesario porque las funciones mencionadas utilizan _print_ para imprimir la nueva matriz en cada iteración, lo cual es una operación de salida.

### Validaciones en la entrada

Se hicieron validaciones en la función _initMatrix_ para que se mostrara un mensaje de error en el caso de que introdujeran el tamaño de una matriz menor o igual que 0, una cantidad negativa de granos de arena e índices negativos.