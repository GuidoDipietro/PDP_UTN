:- dynamic variableLlegamos/1.
:- dynamic variableIncremental/1.

variableIncremental(0).

llegamos:-
    not(variableLlegamos(_)),
    random(1,10,Random),
    assert(variableLlegamos(Random)),
    fail.

llegamos:-
    variableLlegamos(CantidadIteraciones),
    variableIncremental(Estado),
    Estado \= CantidadIteraciones,
    Nuevo is Estado+1,
    assert(variableIncremental(Nuevo)),
    retractall(variableIncremental(Estado)),
    fail.

llegamos:-
    variableLlegamos(CantidadIteraciones),
    variableIncremental(CantidadIteraciones),
    retractall(variableIncremental(_)),
    retractall(variableLlegamos(_)),
    assert(variableIncremental(0)).
    