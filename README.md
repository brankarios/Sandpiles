# Sandpiles

## César Carios & Jhonatan Homsany

### Instancia de Show: Uso de {-# OVERLAPPING #-}

Para poder imprimir las matrices con un formato legible, fue necesario crear una instancia de Show. La nueva instancia de Show creada define cómo se debe mostar una lista de listas. Ahora bien, para que esta instancia pudiera ejecutarse sin problemas fue necesario usar en su firma la anotación {-OVERLAPPING-}, esto le indica al compilador que use esa instancia aunque haya otras instancias de Show. Sin esta anotación ocurría un error al intentar imprimir las matrices del programa.

### Material consultado: Hoogle y Zvon

Las páginas webs hoogle.haskell.org y zvon.org fueron de gran utiidad para investigar el funcionamiento de funciones de orden superior del **Prelude** que nos podían servir para el proyecto. Fue de dichas páginas donde consultamos la función _zip_ y nos sirvió para la función _sandpilesSum_. En esta función definimos una lista por comprensión que suma componente a componente los elementos de las matrices introducidas, y esto lo hace _zip_ juntando los elementos de cada matriz en tuplas para luego sumarlos.

### Modificación de IO en la firma de _sanpilesSimulate_ y _sandpilesSum_

Fue necesario añadir IO a la firma de las funciones _sandpilesSimulate_ y _sandpilesSum_ para poder realizar operaciones de entrada y salida. En este caso, el IO es necesario porque las funciones mencionadas utilizan _print_ para imprimir la nueva matriz en cada iteración, lo cual es una operación de salida.
