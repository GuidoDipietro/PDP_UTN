# Influencers

**El mundo está lleno de influencers, pero son menos inocentes de lo que pensamos. Son gente contratada por una organización maligna, la Asociación Mundial de Venta de Todo, para modificar el comportamiento de las sociedades, instalarle nuevos gustos o miedos y venderle productos que no necesitan. Esta asociación nos contactó para hacer un sistema que les permita simular sus acciones para saber cómo van a salir de antemano: son malignos, pero también tacaños.**

![](influencer.jpg)

### Los influenciables 

Existen personas, y de cada una se conocen varias cosas:
* Qué temas le gusta.
* Qué cosas le dan miedo y en qué medida (expresado numéricamente). 
* Su estabilidad actual, representada en una escala de 0 a 100. 

*Por ejemplo:*
* *A María le gusta la mecánica, le tiene miedo a los extraterrestres en 600 y a quedarse sin trabajo en 300. Su estabilidad es 85.*
* *A Juan Carlos le gusta el maquillaje y los trenes. Le tiene miedo a los insectos en 100, al coronavirus en 10 y a las vacunas en 20. Tiene una estabilidad de 50.*

Implementar las funciones para poder representar las siguientes acciones: 
1. Que una persona se vuelva miedosa a algo en cierta medida, agregándole el nuevo miedo o aumentando su medida, en caso de ya tener ese miedo previamente. 
2. Que una persona pierda pierda el miedo a algo, lo que independiente de en qué medida lo tuviera, lo deja de tener. (En caso de no tener ese miedo, no cambia nada)
3. Que una persona pueda variar su estabilidad en una cierta proporción dada, pero sin salirse de los límites de la escala.
4. Que una persona se vuelva fan de otra persona, en ese caso asume como propios todos los gustos de la otra persona (si ya tenía previamente alguno de esos gustos, lo va a tener repetido)
5. Averiguar si una persona es fanática de un gusto dado, que es cuando tiene más de tres veces dicho gusto. 
6. Averiguar si una persona es miedosa, cuando el total de la medida de todos sus miedos sumados supera 1000.

### Los influenciadores

No se sabe si los influencers son personas, seres de otra especie o conglomerados anónimos de bits, pero lo que sí sabemos es que existen y afectan a las personas de distintas formas. Pese a que muchas personas se creen que son inmunes a las influencias externas, lo cierto es que el influencer actúa directamente sobre una persona sin que esta persona lo sepa. Algunos de ellos son:
* Hay uno, llamado <coloque aquí su nombre>, que podría intervenirle la televisión a María para hacerle creer que los extraterrestres están instalando una falsa pandemia. El impacto sería que se disminuya su estabilidad en 20 unidades, que tenga miedo a los extraterrestres en 100 y al coronavirus en 50.
* Hay otro que hace que una persona le de miedo a la corrupción en 10, le pierda el miedo a convertirse en Venezuela y que agrega el gusto por escuchar.
* El community manager de un artista es un influencer que hace que la gente se haga fan de dicho artista.
* Está el influencer inutil, que no lograr alterar nada.
* Agregá uno a tu elección, pero que tambien realice uno o más cambios en una persona.
	
Implementar las funciones que permitan:

1. Hacer una campaña de marketing básica, que dado un conjunto de personas hace que todas ellas sean influenciadas por un influencer dado.
2. Saber qué influencer es más generador de miedo: dada una lista de personas y dos influencer, saber cuál de ellos provoca que más personas se vuelvan miedosas.

### La influenciación 

El objetivo principal de influenciar, sin embargo, es vender productos. De cada producto se saben dos cosas: el gusto que se necesita que tenga la persona para comprarlo y una condición adicional específica de ese producto. 

Por ejemplo:
* El desodorante Acks necesita que a la gente le guste el chocolate pero además que la estabilidad de la persona sea menor a 50.
* El llavero de plato volador necesita que a la persona le gusten los extraterrestres pero que no sea miedosa.
* El pollo frito Ca Efe Se necesita que a la persona le guste lo frito y que sea fanática del pollo.

1. Calcular la eficiencia de un campaña de marketing con un influencer para un producto en particular. Es el porcentaje de variación de la cantidad de gente que antes de la campaña no hubiera comprado el producto, pero luego sí. 

### Importante

1. Definir los tipos de datos necesarios, declarar el tipo de cada función y agregar los datos de ejemplo que sean necesarios para hacer pruebas de las principales variantes.
2. Analizar qué sucede en caso de utilizar una lista infinita. Mostrar formas de utilizar algunas de las funciones hechas de manera que:
* Se quede iterando infinitamente sin arrojar un resultado. 
* Se obtenga una respuesta finita.  
* La respuesta que se obtiene sea a su vez infinita.
3. Explicar la utilidad del concepto de aplicación parcial en la resolución realizada dando un ejemplo concreto donde se lo usó

