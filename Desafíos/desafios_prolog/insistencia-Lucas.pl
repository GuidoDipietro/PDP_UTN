:- dynamic intentos/1.

intentos(0).

consulta:-
    intentos(Intentos),
    Intentos < 5,
    Siguiente is Intentos +1,
    assert(intentos(Siguiente)),
    fail.

consulta:-
    intentos(5).
