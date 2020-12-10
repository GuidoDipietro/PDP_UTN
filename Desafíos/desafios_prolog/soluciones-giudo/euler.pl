%arista(vertice1, arista, vertice2).
arista(a,1,b).
arista(a,2,b).
arista(a,3,c).
arista(a,4,c).
arista(a,5,d).
arista(c,6,d).
arista(b,7,d).

% El grafo cargado es el problema de los puentes de Königsberg
% Retirando una arista, como por ejemplo la 7, el grafo adquire un camino de Euler.

conectado(A,B):-
    arista(A,_,B); arista(B,_,A).

camino(A,A).
camino(A,B):-
    conectado(A,B). %teóricamente esto se contempla en la definición que viene después, pero no andaba, yqc
camino(A,B):-
    conectado(A,X),
    conectado(Y,B),
    camino(X,Y).

grado(Vertice,Grado):-
    findall(
        _,
        conectado(Vertice,_),
        Lista
        ),
    length(Lista,Grado).

existeEuler:-
    findall( % solamente 0 o 2 vértices con grados impares
            A,
            (arista(A,_,_), grado(A,Grado), 1 is Grado mod 2),
            Lista
        ),
    list_to_set(Lista, Vertices),
    (length(Vertices, 2); length(Vertices,0)),
    forall( % y que sea conexo
            (member(V, Vertices), member(W, Vertices)),
            camino(V,W)
        ).

% ?- existeEuler.
% false.