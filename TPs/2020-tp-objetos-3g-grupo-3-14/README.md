<!-- Output copied to clipboard! -->



# Auténtico software pirata

<img src="https://i.imgur.com/KcW2OHz.jpg" data-canonical-src="https://i.imgur.com/KcW2OHz.jpg" height="200" />

**_Superando las paradojas, y más allá del oxímoron, les proponemos embarcarse en la audaz misión de desarrollar un software que modele algunos aspectos de los auténticos piratas de los viejos tiempos._**


## Barcos

Hay barcos piratas que necesitan reclutar tripulantes. Cada barco pirata tiene una misión que quiere cumplir, y por eso sólo aceptará en su tripulación a los piratas que le sirvan para esa misión. Un barco puede cambiar de misión en cualquier momento, incluso a una que no puede cumplir. Al cambiar de misión, el barco echa a los tripulantes que no sirven para su misión actual. Asumimos que un barco siempre tiene una misión asignada. 

De cada barco también se conoce su capacidad (cuántas personas es capaz de llevar), la cual no puede sobrepasar.

Vamos a decir que un barco pirata es temible si puede realizar la misión que tiene asignada. 

Los barcos pueden anclar en ciudades. Al hacerlo, toda la tripulación compra un souvenir del lugar, que provoca que sus pertenencias aumenten y que gasten unas monedas. Además, el integrante de la tripulación que tenga menos monedas queda perdido en la ciudad, o sea que deja de formar parte de la tripulación y la ciudad queda con un habitante más.

Existen también un barco único, el holandés errante, cuya principal diferencia es que la tripulación es desconocida y puede cumplir cualquier misión. Sin embargo, no acepta nuevos tripulantes.


## Misiones

Una misión, para poder ser completada por un barco, debe cumplir ciertos requisitos. El primero, común a todas ellas, es que el barco tenga suficiente tripulación.  Se considera que un barco tiene suficiente tripulación cuando la cantidad de sus tripulantes llega al menos al 90% de su capacidad. 


Existen muchas misiones posibles, entre ellas: búsquedas del tesoro, convertirse en leyenda o saqueos. Nos va a interesar saber si un pirata es útil para una misión y además si una misión puede ser realizada por un barco.


### Búsqueda del tesoro

Para esta clase de misiones sólo serán útiles como tripulantes aquellos piratas que entre sus pertenencias tengan una brújula o un mapa, y no posean más de 5 monedas. Para que una búsqueda del tesoro pueda ser realizada por un barco, al menos uno de sus tripulantes debe tener entre sus pertenencias una llave de cofre.


### Convertirse en leyenda

Para que un pirata sea útil en una misión de convertirse en leyenda debe tener al menos 10 pertenencias entre las cuales debe figurar un elemento indispensable definido en cada misión de convertirse en leyenda. Estas misiones en general no tienen condiciones particulares para que puedan ser realizadas con un barco, excepto unas muy puntuales que exigen que el barco tenga sólo piratas ricos (es decir, con más de 1000 monedas, aunque ese valor puede cambiar y debe ser el mismo para todos los piratas).


### Saqueo

Los saqueos pueden ser a un barco o a una ciudad costera. 

Para estas misiones son útiles los piratas que cuenten con menos dinero que una cantidad de monedas determinada y además se animen a realizar el saqueo (para saquear un barco, el pirata tiene que ser experto en saqueos y para saquear una ciudad, el pirata debe tener un mapa de esa ciudad)

Para que un barco pueda concretar un saqueo a otro barco, debe tener más del doble de tripulantes, mientras que para saquear a una ciudad alcanza que la tripulación sea al menos de un 40% de la población de la ciudad. 


## Piratas

Cada pirata puede llevar varios “ítems” consigo, como ser: un mapa de algún lugar, una brújula, un loro, un cuchillo, etc.  Por ejemplo: el pirata Barbanegra tiene una brújula, dos cuchillos, un diente de oro.  De cada pirata también se conoce su habilidad principal (es decir, aquello en lo que es experto) y la cantidad de dinero que lleva consigo (para simplificar el modelo, el dinero es un número de monedas). \


Además de los piratas normales, se sabe que algunos tripulantes son espías de la corona. Estos piratas se comportan igual que los piratas comunes a excepción de que:
  - siempre son (o dicen ser) lo suficientemente hábiles como para cumplir una misión que exija alguna habilidad
  - para animarse a saquear una víctima se tienen que dar las condiciones explicadas anteriormente y además tener el ítem permiso de la corona

---

## Requerimientos

Se requiere modelar el dominio pensando en el paradigma de objetos, con la codificación para cumplir con los siguientes objetivos:



1. Saber si un pirata es útil para una misión
2. Saber si un pirata puede formar parte de la tripulación de un barco. Esto ocurre cuando el barco tiene lugar para un tripulante más, y además el pirata sirve para la misión del barco.
3. Incorporar un pirata a la tripulación de un barco, sólo si esto puede ser llevado a cabo.
4. Hacer que un barco cambie de misión. 
5. Saber quién es el pirata que más pertenencias posee 
6. Hacer que un barco ancle en una ciudad costera.
7. Saber si un barco pirata es temible
8. Escribir tests para todos los puntos contemplando las variantes principales e incluyendo al menos uno donde se lance un error.
9. Justificar el uso de polimorfismo y mostrar un ejemplo donde se lo vea y se lo testee.	
