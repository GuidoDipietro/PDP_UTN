% dado(X):-
    %random(1,6,X).
dado(X):-
    member(X,[1,2,3,4,5,6]).

jugada(tirada(A,B,C)):- % 3 dados al azar, ordenados de mayor a menor
    dado(X),dado(Y),dado(Z),
    M is max(X,Y),
    A is max(M,Z),
    B is M,
    C is min(X,Y).

punto(par(A,B),1):-
    A\=B, A is max(A,B).
punto(par(A,B),0):-
    B is max(A,B).

pares(par(A,X),par(B,Y),par(C,Z)):-
    jugada(tirada(A,B,C)),
    jugada(tirada(X,Y,Z)).

% gana(atacante, defensor, N).
gana(N):-
    pares(A,B,C),
    punto(A, PA), punto(B, PB), punto(C, PC),
    N is PA+PB+PC.

probabilidad(P, N):-
    findall(
        _,
        gana(N),
        Lista
    ),
    findall(
        _,
        gana(_),
        ListaTodos
    ),
    length(Lista, Favorables),
    length(ListaTodos, Totales),
    P is Favorables/Totales.

todasLasJugadasPosibles(Lista, Longitud):-
    findall(
            Jugada,
            jugada(Jugada),
            Todas
        ),
    list_to_set(Todas, Lista),
    length(Lista, Longitud).