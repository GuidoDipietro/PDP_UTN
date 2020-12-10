%%%%% HECHOS - HABITANTES %%%%%

% Una persona se considera posible disidente si cumple todos estos requisitos:
%   Tener una habilidad en algo considerado terrorista sin tener un trabajo de índole militar.
%   No tener gustos registrados en sistema, tener más de 3, o que le guste aquello en lo que es bueno.
%   Tiene más de un registro en su historial criminal o vive junto con alguien que sí lo tiene.

persona(ab570).
persona(ba429).
persona(ce234).
persona(a013).
persona(f2682).
persona(nadie). % Se llama 'nadie' y no tiene crímenes, trabajo, casa, gustos, o habilidades.
persona(yo).
persona(aaa666).
persona(marcos).

crimen(ce234, roboAeronaves).
crimen(ce234, fraude).
crimen(ce234, tenenciaCafeina).
crimen(a013, falsificacionVacunas).
crimen(a013, fraude).
crimen(f2682, fraude).
crimen(yo, tenenciaCafeina).
crimen(aaa666, tirarGasPimienta).
crimen(aaa666, tirarGasDeNuevo).

trabajo(ab570, uti).
trabajo(ce234, aviacionMilitar).
trabajo(a013, inteligenciaMilitar).
trabajo(f2682, unPastel).
trabajo(aaa666, unPastel).

viveEn(ab570, laSeverino).
viveEn(ba429, laSeverino).
viveEn(ce234, laSeverino).
viveEn(a013, comisaria48).
viveEn(f2682, cueva).
viveEn(yo, utnLugano).
viveEn(aaa666, cueva).
viveEn(marcos, cueva).

habilidad(ab570, armarBombas).
habilidad(ce234, conducirAutos).
habilidad(a013, tiroAlBlanco).
habilidad(f2682, conducirAutos).
habilidad(yo, usarAcensores).
habilidad(aaa666, tirarGasPimienta).
habilidad(marcos, explosionEnMercadoCentral).

gustos(ab570, [fuego, destruccion, armarBombas]).
gustos(a013, [juegosAzar, ajedrez, tiroAlBlanco]).
gustos(f2682, [comerPanqueques]).
gustos(yo, [dibujo]).
gustos(aaa666, [tirarGasPimienta]).
gustos(marcos, [caramelos,chocolate,dulceDeLeche,tornillos,bujias]).

%%%%% HECHOS - VIVIENDAS %%%%%

% vivienda(nombre, [zonas])
vivienda(laSeverino, [cuarto(4,8), pasadizo, tunel(8,f), tunel(5,f), tunel(1,c)]).
vivienda(comisaria48, [cuarto(7,7), tunel(14,f), tunel(27,f)]).
vivienda(cueva, [pasadizo, pasadizo, pasadizo, cuarto(2,2)]).
vivienda(utnMedrano, [pasadizo, pasadizo, pasadizo, cuarto(10,10)]).

%%%%% PREDICADOS %%%%%

% Por nuestras estimaciones, se consideran viviendas con potencial rebelde si vive en ella algún disidente y
% su superficie destinada a actividad clandestinas supera 50 metros cuadrados.

viviendaRebelde(Vivienda):-
    vivienda(Vivienda, _),
    superficie(Vivienda, S),
    S > 50,
    viveEn(Persona, Vivienda),
    disidente(Persona).

%% SUPERFICIE %% (suponemos que toda la superficie está destinada a actividades clandestinas 👀👀)
% Se calcula de la siguiente forma:
%   Para los cuartos secretos, que siempre se consideran rectangulares, la superficie cubierta
%   Para los túneles, el doble de su longitud, excepto cuando están en construcción, que no se consideran.
%   Los pasadizos siempre tienen un metro cuadrado de superficie
superficie(Vivienda, Superficie):-
    vivienda(Vivienda, Espacios),
    maplist(area, Espacios, AreasTotales),
    sumlist(AreasTotales, Superficie).
area(cuarto(X,Y),A):-
    A is X*Y.
area(tunel(X,f),A):- % finalizados
    A is X*2.
area(tunel(_,c),0). % en construcción
area(pasadizo,1).

%%% DISIDENTES %%%
% Poder saber quiénes son posibles disidentes. Una persona se considera posible disidente si cumple todos estos requisitos:
%   Tener una habilidad en algo considerado terrorista sin tener un trabajo de índole militar.
%   No tener gustos registrados en sistema, tener más de 3, o que le guste aquello en lo que es bueno.
%   Tiene más de un registro en su historial criminal o vive junto con alguien que sí lo tiene.

habilidadTerrorista(H):-
    member(H, [armarBombas, tirarGasPimienta, explosionEnMercadoCentral]).
trabajoMilitar(T):-
    member(T, [aviacionMilitar, inteligenciaMilitar]).

disidente(Persona):-
    persona(Persona),
    habilidad(Persona, H), habilidadTerrorista(H),
    not((
        trabajo(Persona, T),
        trabajoMilitar(T)
    )),
    condicionGustos(Persona),
    condicionCrimenes(Persona).

condicionGustos(Persona):-
    not(gustos(Persona,_)).
condicionGustos(Persona):-
    gustos(Persona, Gustos),
    length(Gustos, L), L>3.
condicionGustos(Persona):-
    gustos(Persona, Gustos),
    habilidad(Persona, Habilidad),
    member(Habilidad, Gustos).

criminal(Persona):- % más de 1 crimen
    crimen(Persona, A), crimen(Persona, B),
    A \= B.
condicionCrimenes(Persona):-
    viveEn(Persona, Casa),
    viveEn(Otro, Casa),
    criminal(Otro). % Otro puede ser Persona, o puede ser otro distinto. En ambos casos está bien.

%%%%% VIVIENDAS %%%%%
% Detectar si en una vivienda: 
% No vive nadie 
% Todos los que viven tienen al menos un gusto en común.

viviendaAbandonada(Vivienda):-
    vivienda(Vivienda, _),
    not(viveEn(_,Vivienda)).
viviendaConGustosEnComun(Vivienda):-
    vivienda(Vivienda,_),
    viveEn(Alguien, Vivienda),
    gustos(Alguien, Gustos),
    member(UnGusto, Gustos), % existe un gusto de alguien que vive en Vivienda
    forall(
        viveEn(Persona,Vivienda),
        (
            gustos(Persona, SusGustos),
            member(UnGusto, SusGustos) % que todos tienen
        )    
    ).
viviendaConGustosEnComun(Vivienda):-
    viviendaAbandonada(Vivienda). % técnicamente las viviendas abandonadas tienen que cumplir la condición de gustosEnComun

%%%%% PREGUNTAS FINALES %%%%%

%%%%%%%%%%%%%%%%%%%%
% Encontrar todas las viviendas que tengan potencial rebelde.

% ?- viviendaRebelde(X).
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% false.

%%%%%%%%%%%%%%%%%%%%
% Mostrar ejemplos de consulta y respuesta.

% ?- superficie(Viv, Sup).
% Viv = laSeverino,
% Sup = 59 ;
% Viv = comisaria48,
% Sup = 131 ;
% Viv = cueva,
% Sup = 7 ;
% Viv = utnMedrano,
% Sup = 103.

% ?- superficie(X, 59).
% X = laSeverino ;
% false.

% ?- superficie(cueva, X).
% X = 7.

% ?- disidente(X).
% X = ab570 ; -> habilidad: armarBombas, gusto: armarBombas (coincide), vive en laSeverino con ce234 que tiene 3 crímenes.
% X = ab570 ;       trabaja en ingeniería mecánica que en este planeta no se considera militar
% X = ab570 ;
% X = ab570 ;
% X = ab570 ;
% X = ab570 ;
% X = aaa666 ; -> gusto: tirarGasPimienta, habilidad: tirarGasPimienta (coincide), tiene más de 1 registro criminal.
% X = aaa666 ;      trabaja en la universidad de pastelería que no es militar
% X = marcos ; -> habilidad: explosionEnMercadoCentral, tiene 5 gustos, vive en cueva con aaa666 que tiene 2 registros criminales.
% X = marcos ;      no tiene trabajo
% false.

% ?- disidente(a013).
% false.

% ?- trabajoMilitar(aviacionMilitar). 
% true .

% ?- viveEn(P, V).
% P = ab570,
% V = laSeverino ;
% P = ce234,
% V = laSeverino ;
% P = a013,
% V = comisaria48 ;
% P = f2682,
% V = cueva ;
% P = yo,
% V = utnLugano ;
% P = aaa666,
% V = cueva ;
% P = marcos,
% V = cueva.

% ?- viveEn(nadie, X).
% false. -> sin domicilio registado (universo cerrado)

% ?- viveEn(X,cueva).
% X = f2682 ;
% X = aaa666 ;
% X = marcos.

% ?- viviendaAbandonada(X).
% X = utnMedrano.

% ?- viviendaConGustosEnComun(X).
% X = comisaria48 ; -> vive uno solo (con 3 gustos, por eso aparece 3 veces)
% X = comisaria48 ;
% X = comisaria48 ;
% X = utnMedrano. -> no vive nadie

% ?- habilidadTerrorista(X).
% X = armarBombas ;
% X = tirarGasPimienta ;
% X = explosionEnMercadoCentral.

%%%%%%%%%%%%%%%%%%%%
% Analizar la inversibilidad de los predicados, de manera de encontrar alguno de los realizados que
% sea totalmente inversible y otro que no. Justificar. 

% Los mencionados en el punto anterior son todos totalmente inversibles.
% Un ejemplo de no inversible es "area", no es inversible porque no se instancian las variables que se pasan,
% o en algunos casos no lo es porque tiene un "is", que no es totalmente inversible.

%%%%%%%%%%%%%%%%%%%%
% Si en algún momento se agregara algún tipo nuevo de ambiente en las viviendas,
% por ejemplo bunkers donde se esconden secretos o entradas a cuevas donde se puede viajar en el tiempo...
% ¿Qué pasaría con la actual solución? 
% ¿Qué se podría hacer si se quisiera contemplar su superficie para determinar la
% superficie total de la casa? Implementar una solución con una lógica simple
% Justificar

% No sería ningún problema. Claramente la solución actual no funcionaría correctamente porque no contemplaría
% la existencia de bunkers o entradas a cuevas para viajar en el tiempo.
% De agregarse functores desconocidos a las definiciones de las viviendas, 'maplist' no podría aplicar 'area' a estos,
% lo que causaría un valor de 'falso' para el área de estas viviendas.

% Arreglar esto es muy simple: solo habría que (tras agregar los nuevos espacios a los hechos de las viviendas)
% agregar una entrada más del predicado 'area' que indique cómo calcular el área de estos nuevos espacios,
% y el problema estaría resuelto.
% Ejemplo: (esto debería ir junto con la definición de los otros hechos, pero lo pongo acá por comodidad)

% vivienda(cosaRara, [pasadizo, tunel(73,c), bunker(15,15), cuevaTemporal(11)]).
% area(bunker(LadoA, LadoB), S):-
%   S is LadoA * LadoB.
% area(cuevaTemporal(X),S):-
%   S is X*X.