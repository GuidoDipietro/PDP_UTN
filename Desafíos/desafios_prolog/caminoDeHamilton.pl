% Por definicion, para un grafo tener camino de euler debe ser conexo y tener todos vertices de grado
% par o, como maximo, 2 vertices de grado impar.

% grafo(identificador, vertices, aristas)

grafo(1, [a, b, c, d], [camino(a, b), camino(b, a), camino(b, c), camino(c, d), camino(a, a)]).
grafo(2, [a, b, c, d, e], [camino(a, b), camino(b, a), camino(c, b), camino(b,d), camino(b, e)]).
grafo(3, [a, b, c, d, e, f, g], [camino(a, b), camino(b, c), camino(c, d), camino(d, c), camino(c, e), camino(e, a), camino(f, b), camino(g, a)]).
grafo(4, [a, b, c, d], [camino(a, b), camino(b, a), camino(c, d), camino(d, c)]).

obtenerProximo(Actual, Visitados, Vertices, Aristas, X):-
    member(X, Vertices),
    X \= Actual,
    not(member(X, Visitados)),
    member(camino(X, Actual), Aristas).

obtenerProximo(Actual, Visitados, Vertices, Aristas, X):-
    member(X, Vertices),
    X \= Actual,
    not(member(X, Visitados)),
    member(camino(Actual, X), Aristas).

tieneHamilton(_, _, [_], _).

tieneHamilton(Actual, Visitados, Vertices, _):-
    append(Visitados, [Actual], NuevoVisitados),
    permutation(NuevoVisitados, Vertices).

tieneHamilton(Actual, Visitados, Vertices, Aristas):-
    append(Visitados, [Actual], NuevoVisitados),
    obtenerProximo(Actual, NuevoVisitados, Vertices, Aristas, Prox),
    tieneHamilton(Prox, NuevoVisitados, Vertices, Aristas).

saberSiTieneHamilton(Id):-
    grafo(Id, Vertices, Aristas),
    findall(X, (member(X, Vertices), tieneHamilton(X, [], Vertices, Aristas)), Res),
    Res \= [].

% las consultas se hacen con saberSiTieneHamilton(Id)