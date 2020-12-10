probabilidadGanar(N,Probabilidad):-
    between(0,3,N), 
    cantidadGanadas(N,Ganados),
    cantidadJugadas(Total),
    Probabilidad is Ganados/Total.

cantidadGanadas(N,Ganados):-
    count(gana(N,_,_),Ganados).

cantidadJugadas(Total):-
    count((jugada(_),jugada(_)),Total).
    
gana(N,Atacante,Defensor):-
    jugadaOrdenada(Atacante),
    jugadaOrdenada(Defensor),
    count(ganaItem(Atacante,Defensor),N).

ganaItem(Atacante,Defensor):-
    nth1(Posicion,Atacante,DadoAtacante),
    nth1(Posicion,Defensor,DadoDefensor),
    DadoAtacante > DadoDefensor.

jugadaOrdenada(Ordenada):-
    jugada(Jugada),
    msort(Jugada,Ordenada).

jugada([A,B,C]):-
    dado(A),
    dado(B),
    dado(C).

dado(X):- member(X,[1,2,3,4,5,6]).

count(Consulta,Cantidad):-
    findall(_,Consulta,Lista),
    length(Lista,Cantidad).
