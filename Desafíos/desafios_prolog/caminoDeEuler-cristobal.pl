grafo(1, [a, b, c, d], [camino(a, b), camino(b, a), camino(b, c), camino(c, d)]).
grafo(2, [a, b, c, d, e], [camino(a, b), camino(b, a), camino(c, b), camino(b,d), camino(b, e)]).
grafo(3, [a, b, c, d, e, f, g], [camino(a, b), camino(b, c), camino(c, d), camino(d, c), camino(c, e), camino(e, a), camino(f, b)]).
grafo(4, [a, b, c, d], [camino(a, b), camino(a, a), camino(b, a), camino(c, d), camino(d, c)]).

obtenerCamino(Actual, Visitadas, Aristas, Res, X):-
    member(Res, Aristas),
    not(member(Res, Visitadas)),
    Res = camino(Actual, X),
    Res \= camino(Actual, Actual).

obtenerCamino(Actual, Visitadas, Aristas, Res, X):-
    member(Res, Aristas),
    not(member(Res, Visitadas)),
    Res = camino(X, Actual),
    Res \= camino(Actual, Actual).

obtenerCamino(_, Visitadas, Aristas, _, _):-
    permutation(Visitadas, Aristas).

caminoEuler(_, _, [_], _).

caminoEuler(_, Visitadas, _, Aristas):-
    permutation(Visitadas, Aristas).

caminoEuler(Actual, Visitadas, Vertices, Aristas):-
    obtenerCamino(Actual, Visitadas, Aristas, Camino, NuevoActual),
    append(Visitadas, [Camino], NuevoVisitadas),
    caminoEuler(NuevoActual, NuevoVisitadas, Vertices, Aristas).

tieneEuler(Id):-
    grafo(Id, Vertices, Aristas),
    member(X, Vertices), 
    caminoEuler(X, [], Vertices, Aristas).