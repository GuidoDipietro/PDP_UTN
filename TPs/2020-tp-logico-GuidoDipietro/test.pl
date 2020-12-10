% Definición de hechos
% Clara, Amilcar, Tao, Antonio, y Kavin
internet(clara,lento).
internet(amilcar,rapido).
internet(tao,noTiene).
internet(antonio,noTiene).
internet(kavin,noTiene).

calefaccion(clara,leRobaron).
calefaccion(amilcar,mal).
calefaccion(tao,bien).
calefaccion(antonio,leRobaron).
calefaccion(kavin,leRobaron).

tieneHambre(clara).
tieneHambre(antonio).
tieneHambre(kavin).

tieneEmpleo(amilcar).
tieneEmpleo(clara).

superCercanoCerrado(tao).
superCercanoCerrado(antonio).
superCercanoCerrado(kavin).

tareasPendientes(clara,6).
tareasPendientes(amilcar,8).
tareasPendientes(tao,15).
tareasPendientes(antonio,22).
tareasPendientes(kavin,3).

% Deficinión de reglas "molesta", "furiosa", "fueraDeSi"
molesta(Persona):- internet(Persona,lento),not(furiosa(Persona)),not(fueraDeSi(Persona)).
molesta(Persona):- calefaccion(Persona,mal),not(furiosa(Persona)),not(fueraDeSi(Persona)).
molesta(Persona):-
    tieneHambre(Persona),
    superCercanoCerrado(Persona),
    not(furiosa(Persona)),not(fueraDeSi(Persona)).

fueraDeSi(Persona):-
    internet(Persona,noTiene),
    calefaccion(Persona,leRobaron),
    tieneHambre(Persona),
    not(tieneEmpleo(Persona)).

furiosa(Persona):- internet(Persona,noTiene),not(fueraDeSi(Persona)).
furiosa(Persona):- calefaccion(Persona,leRobaron),not(fueraDeSi(Persona)).
furiosa(Persona):-
    tieneHambre(Persona),
    not(tieneEmpleo(Persona)),
    not(fueraDeSi(Persona)).

% Definición de regla "tomar acción" y la clasificación de disponibilidad
libre(Persona):-
    tareasPendientes(Persona,X),X<5.
atareada(Persona):-
    tareasPendientes(Persona,X),between(5,10,X).
noPuedeMas(Persona):-
    tareasPendientes(Persona,X),X>10.

tomarAccion(Persona,15,"piñas","computadora"):-
    molesta(Persona),libre(Persona).
tomarAccion(Persona,15,"piñas","pared"):-
    molesta(Persona),atareada(Persona).
tomarAccion(Persona,15,"piñas","pared"):-
    molesta(Persona),noPuedeMas(Persona).
tomarAccion(Persona,30,"piñas","computadora"):-
    furiosa(Persona),libre(Persona).
tomarAccion(Persona,30,"piñas","pared"):-
    furiosa(Persona),atareada(Persona).
tomarAccion(Persona,"6 potes","untar dulce de leche","computadora"):-
    furiosa(Persona),noPuedeMas(Persona).
tomarAccion(Persona,50,"latigazos","espalda"):-
    fueraDeSi(Persona),libre(Persona).
tomarAccion(Persona,"1 año","criogenizarse","self"):-
    fueraDeSi(Persona),noPuedeMas(Persona). %QEPD

% Garbarino
clienteGarbarino(Persona,computadora):-
    tomarAccion(Persona,X,"piñas","computadora"),X>20.
clienteGarbarino(Persona,computadora):-
    tomarAccion(Persona,_,"untar potes de dulce de leche","computadora").
clienteGarbarino(Persona,masajeador):-
    tomarAccion(Persona,_,_,"espalda").