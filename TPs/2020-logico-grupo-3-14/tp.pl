%%%%%%%%%% Habilidades %%%%%%%%%%

% habilidad(nombre,sabe)
habilidad(juan, cobol).
habilidad(juan, visualBasic).
habilidad(juan, java).
habilidad(julieta, java).
habilidad(marcos, java).
habilidad(santiago, ecmaScript).
habilidad(santiago, java).
habilidad(carlos, cebarMate).
habilidad(cristobal, ecmaScript).

%%%%%%%%%% Roles %%%%%%%%%%

% rol(nombre,rol)
rol(carlos, gerenteDeVentas).
rol(fernando, analistaFuncional).
rol(ana, projectLeader).
rol(Persona, programador) :-
    sabeLenguaje(Persona,_).

sabeLenguaje(Persona, Lenguaje) :-
    habilidad(Persona, Lenguaje),
    lenguaje(Lenguaje,_).

lenguaje(assembler,1949).
lenguaje(cobol,1959).
lenguaje(visualBasic,1992).
lenguaje(java,1996).
lenguaje(go,2009).
lenguaje(ecmaScript,1997).

% lenguaje(L) :-
%     member(L, [cobol, visualBasic, java, ecmaScript]).

%%%%%%%%%% Consultas parte "Habilidades" %%%%%%%%%%

% ¿Qué lenguajes sabe programar Juan?
% ?- sabeLenguaje(juan, X).
%   X = cobol ;
%   X = visualBasic ;
%   X = java

% ¿Quiénes programan en Java?
% ?- sabeLenguaje(X, java).
%   X = juan ;
%   X = julieta ;
%   X = marcos ;
%   X = santiago

% ¿Existe algún programador de Assembler?
% ?- sabeLenguaje(_, assembler).
%   false.

% Fernando, ¿es programador?
% ?- rol(fernando, programador).
%   false.

% ¿Qué roles cumple Juan?
% ?- rol(juan, X).
%   X = programador ;
%   X = programador ;
%   X = programador.

% ¿Quiénes son programadores?
% ?- rol(X, programador).
%   X = juan ;
%   X = juan ;
%   X = juan ;
%   X = julieta ;
%   X = marcos ;
%   X = santiago ;
%   X = santiago ;
%   X = cristobal.

% ¿Existe algún project leader?
% ?- rol(_, projectLeader).
%   true.

%%%%%%%%%% Proyectos %%%%%%%%%%
% proyecto(nombre, año, lenguaje)
proyecto(inquisicion,1184,cobol).
proyecto(sumatra, 1999, java).
proyecto(sumatra, 1999, ecmaScript).
proyecto(renovarSiga,2000,ecmaScript).
proyecto(prometeus, 2020, cobol).
proyecto(odiarProlog, 2020, ecmaScript).

% trabajaEn(proyecto, persona)
trabajaEn(prometeus, juan).
trabajaEn(prometeus, santiago).
trabajaEn(sumatra, julieta).
trabajaEn(sumatra, marcos).
trabajaEn(sumatra, ana).
trabajaEn(inquisicion, cristobal).
trabajaEn(inquisicion, fernando).
trabajaEn(odiarProlog, cristobal).
trabajaEn(renovarSiga, juan).

% Verifica que la persona esté asignada y que sepa al menos uno de los lenguajes
asignadoCorrectamente(Persona, Proyecto) :- 
    trabajaEn(Proyecto, Persona),
    proyecto(Proyecto, _, Lenguaje),
    sabeLenguaje(Persona, Lenguaje).

% Verifica que la persona esté asignada al proyecto y sea analista funcional
asignadoCorrectamente(Persona, Proyecto) :-
    trabajaEn(Proyecto, Persona),
    rol(Persona, analistaFuncional).

% Verifica que la persona esté asignada al proyecto y sea project leader
asignadoCorrectamente(Persona, Proyecto) :-
    trabajaEn(Proyecto, Persona),
    rol(Persona, projectLeader).

%%%%%%%%%% Evaluación %%%%%%%%%%

% Predicado auxiliar
noEsRol(Persona, RolDado):-
    rol(Persona, Rol),
    Rol \= RolDado.

% El proyecto más reciente
reciente(Proyecto) :-
    proyecto(Proyecto,Anio,_),
    forall(proyecto(_,Anio2,_), Anio>=Anio2).

% Proyecto con todos bien asignados y un solo projectLeader
consistente(Proyecto):-
    proyecto(Proyecto,_,_),
    forall(trabajaEn(Proyecto, Persona), asignadoCorrectamente(Persona, Proyecto)),
    trabajaEn(Proyecto, Per1),
    trabajaEn(Proyecto, Per2),
    rol(Per1, projectLeader),
    rol(Per2, projectLeader),
    Per1 == Per2.

% Consistente, ningún analista funcional, y un lenguaje de al menos 10 años respecto al proyecto
innovador(Proyecto):-
    proyecto(Proyecto,AnioProy,Lenguaje),
    consistente(Proyecto),
    forall(trabajaEn(Proyecto, Persona), noEsRol(Persona,analistaFuncional)),
    %not(lenguajeViejoX(10,Proyecto,Lenguaje)). -> no anduvo, hm
    lenguaje(Lenguaje,AnioLeng),
    AnioProy - AnioLeng =< 10.

% Todos los lenguajes tienen más de 15
desactualizado(Proyecto):-
    proyecto(Proyecto,_,_),
    forall(proyecto(Proyecto,_,Lenguaje), lenguajeViejoX(15,Proyecto,Lenguaje)).
lenguajeViejoX(Anios,Proyecto,Lenguaje):-
    proyecto(Proyecto,AnioProy,Lenguaje),
    lenguaje(Lenguaje,AnioLeng),
    AnioProy-AnioLeng > Anios.

% desactualizado(prometeus). true.
% consistente(sumatra) true.
% reciente(prometeus / odiarProlog). true.
% innovador(sumatra). true.

%%%%%%%%%% Seniority %%%%%%%%%%

% tarea(Persona, lista de tareas).
% supervisada(tareaDeOtro, DeEsteProgramador) -> esta es la notación que usamos
tarea(fernando, [
        evolutiva(compleja),
        correctiva(6969, perl),
        correctiva(8, brainfuck), 
        correctiva(58, brainfuck),
        supervisada(correctiva(5, prolog), marcos) %ej: fernando supervisa la correctiva de 5 lineas de marcos
    ]).
tarea(marcos, [
        algoritmica(20),
        algoritmica(35),
        algoritmica(700),
        correctiva(5, prolog)
    ]).
tarea(pablopelle, [
        correctiva(14, prolog), % = 0
        supervisada(evolutiva(compleja), fernando), % = 2*5 = 10
        supervisada(algoritmica(1000), cristobal), % = 2*100 = 200
        evolutiva(compleja) % = 5
    ]). % total = 215
tarea(cristobal, [
        evolutiva(simple), % = 3
        algoritmica(1000), % = 100
        supervisada(correctiva(8, brainfuck), fernando), % = 2*4 = 8
        correctiva(300, cobol), % = 4
        correctiva(10000000, brainfuck) % = 4
    ]). % total = 119 (fua)
tarea(brucelee, [
        correctiva(500, perl),
        correctiva(1000, assembler),
        correctiva(7000000, folders)
    ]).
tarea(vago, []). % grande

% puntajeTarea(Tarea, Puntaje) es verdadero cuando el puntaje de Tarea es Puntaje.
% Es inversible así que lo usaremos para calcular los puntajes!
puntajeTarea(Tarea, P):-
    Tarea = evolutiva(compleja), P is 5.

puntajeTarea(Tarea, P):-
    Tarea = evolutiva(simple), P is 3.

puntajeTarea(Tarea, P):-
    Tarea = correctiva(Lineas,_), Lineas>50, P is 4.

puntajeTarea(Tarea, P):-
    Tarea = correctiva(_,brainfuck), P is 4.
% Si no incluimos esta definición que viene ahora, tareas como correctiva(1,cobol)
% hacen que este predicado sea "false" y eso arruina todo.
puntajeTarea(Tarea, P):-
    Tarea = correctiva(Lineas, Lenguaje),
    Lineas =< 50, Lenguaje \= brainfuck,
    P is 0.

puntajeTarea(Tarea, P):-
    Tarea = algoritmica(Lineas), P is Lineas/10.

% Recursividad para permitir cosas como
% puntajeTarea(
%   supervisada(
%       supervisada(
%           supervisada(
%               correctiva(100,cobol),
%               pedro
%               ),
%           pedro),
%       pedro), 
%   X).
% Esperamos que sea de tu agrado.
puntajeTarea(Tarea, P):-
    Tarea = supervisada(OtraTarea,_), puntajeTarea(OtraTarea, SemiP), P is SemiP * 2.

% Gracias Google por maplist y sumlist
% Prolog y Haskell un solo corazón
seniority(Persona, Seniority):-
    tarea(Persona, Tareas),
    maplist(puntajeTarea, Tareas, Puntajes),
    sumlist(Puntajes, Seniority).


%%%%%%%%%% NINJAS %%%%%%%%%%

programadorNinja(Persona):-
    tarea(Persona, Tareas),
    length(Tareas, L), L>0, % Si no, alguien sin tareas (como "vago") se considera ninja
    forall(
            member(Tarea, Tareas),
            (
                Tarea = correctiva(_,Lenguaje),
                not(sabeLenguaje(Persona, Lenguaje))
            )
        ).
puntajeTotalCorrectivas(Puntaje):-
    findall(
            Puntos,
            (
                tarea(_,Tareas),
                member(Tarea,Tareas),
                Tarea = correctiva(_,_),
                puntajeTarea(Tarea, Puntos)
            ),
            Lista
        ),
    sumlist(Lista, Puntaje).
puntajeNinjasCorrectivas(Puntaje):-
    findall(
            Puntos,
            (
                tarea(Persona,Tareas),
                member(Tarea,Tareas),
                Tarea = correctiva(_,_),
                puntajeTarea(Tarea, Puntos),
                programadorNinja(Persona)
            ),
            Lista
        ),
    sumlist(Lista, Puntaje).
porcentajePedido(Porcentaje):-
    puntajeTotalCorrectivas(A),
    puntajeNinjasCorrectivas(B),
    Porcentaje is 100*(B/A).



%%%%%%%%% REFLEXIONES %%%%%%%%%

%%%%%%% Explicar la utilidad de usar listas y functores

% Los functores son una herramienta muy útil a la hora de realizar el modelado de estructuras de información,
% porque permiten la creación de una "variable" muy flexible. En nuestro ejemplo, el predicado tarea/2 tiene
% el nombre de una Persona, y una lista de functores que son los tipos de las tareas.
% Como cada tarea tiene distinta cantidad de argumentos (evolutiva tiene solo 1, correctiva tiene 2, etc.),
% no se puede modelar de una única forma. En otros lenguajes se deberían hacer distintos tipos de estructuras,
% o almacenar estas variables en estructuras separadas y luego enlazarlas de alguna manera. Con functores
% esto no hace falta y es posible "mezclar" estructuras distintas pero que se usan con un propósito similar.

% Las listas, por otro lado, son una buena forma de organizar las bases de conocimiento, para evitar declarar
% decenas de líneas (una por cada dato que se tiene), y también son extremadamente útiles cuando se quiere contar
% la cantidad de elementos que cumplen cierta condición. Parecería que la única forma de contar elementos en este
% paradigma es creando una lista y contando su longitud, por lo que es vital en este aspecto.

%%%%%%% Mostrar ejemplos de consulta para cada predicado


% Ejemplos de consultas: Grado Senority

% ?- seniority(X, 215).
% X = pablopelle
% ?- seniority(cristobal, X).
% X = 119
% ?- seniority(fernando, 17).
% true.
% ?- puntajeTarea(supervisada(supervisada(supervisada(correctiva(70,prolog),pedro),pedro),pedro), X).
% X = 32.
% ?- puntajeTarea(X, 4).
% Error, no es totalmente inversible, los argumentos no están completamente instanciados
% ?- tarea(cristobal, X).
% X = [
%   evolutiva(simple),
%   algoritmica(1000),
%   supervisada(correctiva(8, brainfuck), fernando),
%   correctiva(300, cobol),
%   correctiva(10000000, brainfuck)
% ].


% Ejemplos de consultas: Porcentaje de tareas correctivas realizadas por Programadores Ninjas

% ?- programadorNinja(X).
% X = brucelee.
% ?- puntajeTotalCorrectivas(X).
% X = 40.
% ?- puntajeNinjasCorrectivas(12). -> son solo las de brucelee, es el único ninja
% true.
% ?- porcentajePedido(X).
% X = 30.0.


%%%%%%% Agregar hechos y mostrar un ejemplo de consulta que entre en loop infinito. Explicar los motivos

% Si quisiéramos saber quiénes tienen la tarea evolutiva(compleja), podríamos hacer esta consulta:
% tarea(Persona,Tareas); member(evolutiva(compleja), Tareas).
% Y esto retorna efectivamente:
    % Persona = fernando,
    % Tareas = [evolutiva(compleja), correctiva(6969, perl), correctiva(8, brainfuck), correctiva(58, brainfuck), supervisada(correctiva(5, prolog), marcos)] ;
    % Persona = marcos,
    % Tareas = [algoritmica(20), algoritmica(35), algoritmica(700), correctiva(5, prolog)] ;
    % Persona = pablopelle,
    % Tareas = [correctiva(14, prolog), supervisada(evolutiva(compleja), fernando), supervisada(algoritmica(1000), cristobal), evolutiva(compleja)] ;
    % Persona = cristobal,
    % Tareas = [evolutiva(simple), algoritmica(1000), supervisada(correctiva(8, brainfuck), fernando), correctiva(300, cobol), correctiva(10000000, brainfuck)] ;
    % Persona = brucelee,
    % Tareas = [correctiva(500, perl), correctiva(1000, assembler), correctiva(7000000, folders)] ;
    % Persona = vago,
    % Tareas = [] ;
% Pero después de eso, no hay más Personas, por lo tanto, no hay más lista de Tareas, así que
% el predicado "member/2" empieza a inventar valores de listas que tienen evolutiva(compleja) como miembro:
    % Tareas = [evolutiva(compleja)|_13394] ;
    % Tareas = [_13392, evolutiva(compleja)|_14140] ;
    % Tareas = [_13392, _14138, evolutiva(compleja)|_14886] ;
    % Tareas = [_13392, _14138, _14884, evolutiva(compleja)|_15632] ;
    % Tareas = [_13392, _14138, _14884, _15630, evolutiva(compleja)|_16378] ;
    % Tareas = [_13392, _14138, _14884, _15630, _16376, evolutiva(compleja)|_17124] ... etc
% Y esto no termina nunca, a no ser que se indique la finalización con un "."