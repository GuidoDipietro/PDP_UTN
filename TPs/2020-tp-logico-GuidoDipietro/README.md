# TP Enojo en cuarentena

### Planteo del problema:
Se anunció la semana pasada que la cuarentena se extendería en la Ciudad de Buenos Aires hasta el 28 de junio, siendo esta la sexta o séptima vez que se prorroga. Los ciudadanos ya perdieron la cuenta, y muchos de ellos también perdieron la cabeza.  
Para descargar su cólera, un grupo de asesores del Gobierno emitió un instructivo que indica cómo hacerlo. Se describe a continuación:

### Requerimientos:

### Definiciones
Una persona se considera que está 'molesta' si se cumple alguna de estas condiciones:
- Su conexión a internet es lenta
- No le anda muy bien la calefacción
- Tiene hambre y el supermercado más cercano está cerrado  

Por otro lado, una persona se considera 'furiosa' si se cumple alguna de estas condiciones (no pueden ser todas a la vez):
- No tiene conexión a internet
- Mandó a arreglar la estufa y el service se la robó
- Tiene hambre y está sin empleo  

Finalmente, una persona se considera 'fuera de sí' si se cumplen las tres condiciones de 'furiosa' en simultáneo.  
  
La gente además tiene cosas para hacer. Las definimos así:  
- Una persona está libre si tiene menos de 5 tareas pendientes.
- Una persona está atareada si tiene entre 5 y 10 tareas pendientes.
- Una persona #NoPuedeMás si tiene más de 10 tareas pendientes.

#### Acciones a tomar
Si una persona está molesta y:  
- Está libre, debe pegarle 15 piñas a su computadora.
- Está atareada o no puede más, se sugiere que le pegue 15 piñas a su pared.
  
Una persona furiosa que:  
- Está libre, debería pegarle 30 piñas a su computadora.
- Está atareada, debería pegarle 30 piñas a su pared.
- No puede más, debería untar su computadora con dulce de leche, preferiblemente 6 potes enteros.
  
Una persona fuera de sí que:  
- Está libre, debería pegarse 50 latigazos en la espalda.
- No puede más, debería criogenizarse por 1 año.

## Garbarino al acecho
Garbarino se enteró de esto, y quiere averiguar qué personas le pegaron más de 20 piñas a su computadora, o la untaron con dulce de leche, para ofrecerles "computadora" e intentar recuperar un poco de sus ganancias, porque de lo contrario se van a fundir para siempre.  
También quieren saber quiénes tomaron algún tipo de acción hacia su espalda, para ofrecerles masajeadores.  

---

### Datos:
Clara tiene internet lento, le robaron la estufa, y tiene hambre pero está con trabajo. Tiene 6 tareas por hacer. Ya se va a reponer.  

Amilcar tiene una conexión rapidísima a internet, pero le anda mal la calefacción. Acaba de almorzar ravioles. Está trabajando en Sistemas, y tiene 8 cosas pendientes.  

Tao no tiene internet porque vive en un molino, pero tiene muy buena calefacción. El super más cercano que tenía cerró, pero tiene plantaciones y come de ahí. No tiene un trabajo estable. (Consideramos que los cultivos no son su trabajo). Anda con muchas cosas para hacer: le quedan 15 pendientes.  

Antonio no tiene internet y le robaron la estufa. No come hace una semana, y el super más cercano que tenía cerró para siempre. Encima, como pasó mucho tiempo llorando, tiene 22 tareas por hacer.  

Kavin está en la misma: no tiene internet y le robaron la estufa, y no come hace tres días, y su supermercado más cercano cerró. Al menos no tiene mucho por hacer, sólo tiene 3 tareas inconclusas.  

### Conceptos empleados:
- Inversibilidad  
    Puedo hacer una consulta dejando una variable libre para que Prolog me responda quiénes la cumplen:  
    ```
    atareada(X).
    X = clara ;
    X = amilcar ;
    ```
    O, en el caso de libre(), utilizo inversibilidad para hallar si un número es menor a 5:  
    ```
    libre(Persona):-
        tareasPendientes(Persona,X),X<5.
    ```
    La variable "X" la instancio al mencionar tareasPendientes() dentro de la regla, y luego puedo usarla de forma inversible con "<".  
  
- Universo cerrado  
  Los predicados "tieneHambre() y tieneEmpleo()" no están definidos totalmente (por ejemplo, tieneEmpleo(antonio) no está definido). Cuando algo no está definido se toma como falso, porque no hay cómo demostrar que sea verdadero.  

- Variables anónimas  
  En ocasiones hago referencia a predicados usando variables anónimas, por ejemplo:  
  ```
  clienteGarbarino(Persona,masajeador):-
    tomarAccion(Persona,_,_,"espalda").
  ```
