-- Guido Dipietro

type Miedo = String
type Gusto = String

data Persona = UnaPersona {
    gustos :: [Gusto],
    miedos :: [(Miedo, Int)],
    estabilidad :: Float -- 0 al 100
} deriving Show

maria, juanCarlos, tipo, carmen, celio, chuckNorris :: Persona
maria = UnaPersona ["mecanica"] [("extraterrestres", 600), ("desempleo", 300)] 85
juanCarlos = UnaPersona ["maquillaje","trenes"] [("insectos",100),("coronavirus",10),("vacunas",20)] 50
tipo = UnaPersona ["ddl","ddl","ddl","ddl","bujias"] [("parciales",500),("peronistas",600),("toroides",300)] 40
carmen = UnaPersona ["chocolate","pureDePapas"] [] 55
celio = UnaPersona ["chocolate"] [("convertirseEnVerdura",300)] 49
chuckNorris = UnaPersona ["artesMarciales","chocolate","extraterrestres"] [] 100

-- Que una persona se vuelva miedosa a algo en cierta medida,
-- agregándole el nuevo miedo o aumentando su medida, en caso de ya tener ese miedo previamente.

nivelMiedo :: Miedo->Persona->Int
nivelMiedo miedo persona
    | (filter (\(x,_)->x==miedo) (miedos persona)) /= [] = snd (head (filter (\(x,_)->x==miedo) (miedos persona)))
    | otherwise = 0

agregarMiedo :: (Miedo,Int)->Persona->Persona
agregarMiedo (miedo, medida) persona
    | (nivelMiedo miedo persona) > medida = persona --solo puede aumentar el nivel actual
    | otherwise = persona{
    miedos = (filter (\(x,_)->x/=miedo) (miedos persona)) ++ [(miedo, medida)]
}

-- Que una persona pierda pierda el miedo a algo, lo que independiente de en qué medida lo tuviera,
-- lo deja de tener. (En caso de no tener ese miedo, no cambia nada)

sacarMiedo :: Miedo->Persona->Persona
sacarMiedo miedo persona = persona {
    miedos = filter (\(x,_)->x/=miedo) (miedos persona)
}

-- Que una persona pueda variar su estabilidad en una cierta proporción dada,
-- pero sin salirse de los límites de la escala.

variarEstabilidad :: Float->Persona->Persona
variarEstabilidad n persona
    | (estabilidad persona)+n > 100 = persona {estabilidad = 100}
    | (estabilidad persona)+n < 0 = persona {estabilidad = 0}
    | otherwise = persona {estabilidad = n + (estabilidad persona)}

-- Que una persona se vuelva fan de otra persona, en ese caso asume como propios todos los gustos de la otra persona
-- (si ya tenía previamente alguno de esos gustos, lo va a tener repetido)

-- Le agrega al primero los gustos del segundo
fanatizar :: Persona->Persona->Persona
fanatizar fan target = fan {
    gustos = (gustos fan) ++ (gustos target)
}

-- Averiguar si una persona es fanática de un gusto dado, que es cuando tiene más de tres veces dicho gusto.

repeticionesGusto :: Gusto->Persona->Int
repeticionesGusto gusto persona = length (filter (==gusto) (gustos persona))

fanaticoGusto :: Gusto->Persona->Bool
fanaticoGusto gusto = (>3).(repeticionesGusto gusto)

-- Averiguar si una persona es miedosa, cuando el total de la medida de todos sus miedos sumados supera 1000.

personaMiedosa :: Persona->Bool
personaMiedosa persona = (sum (map snd (miedos persona))) > 1000

------ INFLUENCIADORES ------

-- No se sabe si los influencers son personas, seres de otra especie o conglomerados anónimos de bits,
-- pero lo que sí sabemos es que existen y afectan a las personas de distintas formas.
-- Pese a que muchas personas se creen que son inmunes a las influencias externas,
-- lo cierto es que el influencer actúa directamente sobre una persona sin que esta persona lo sepa. Algunos de ellos son:

type Influencer = Persona->Persona

-- Hay uno, llamado Stanchas, que podría intervenirle la televisión a María para hacerle creer
-- que los extraterrestres están instalando una falsa pandemia. El impacto sería que se disminuya su estabilidad en 20 unidades,
-- que tenga miedo a los extraterrestres en 100 y al coronavirus en 50.

-- Por commit de Lucas pensé varias soluciones:
-- (varias comentadas para que deje compilar bien)

aplicarOperaciones :: [(Persona->Persona)]->Influencer
aplicarOperaciones ops persona = foldr ($) persona ops

agregarGusto :: Gusto->Persona->Persona
agregarGusto gusto = \p -> p {gustos = (gustos p) ++ [gusto]}

-- Solución 1, la primera que hice:
-- agregarMiedos :: [(Miedo,Int)]->Influencer
-- agregarMiedos mds persona = foldl (flip agregarMiedo) persona mds
-- miedosStanchas :: [(Miedo,Int)]
-- miedosStanchas = [("extraterrestres",100),("coronavirus",50)]
-- stanchas :: Influencer
-- stanchas persona = (variarEstabilidad (-20) (agregarMiedos miedosStanchas persona))

-- Solución 2:
-- stanchas :: Influencer
-- stanchas = (agregarMiedo ("extraterrestres", 100)).(agregarMiedo ("coronavirus", 50)).(variarEstabilidad (-20))

-- Solución 3:
stanchas :: Influencer
stanchas = aplicarOperaciones [
    (agregarMiedo ("extraterrestres",100)),
    (agregarMiedo ("coronavirus",50)),
    (variarEstabilidad (-20))] -- el ] lo pongo acá porque tira warnings raros

-- Hay otro, Marcos, que hace que una persona le de miedo a la corrupción en 10, le pierda el miedo a convertirse en Venezuela
-- y que agrega el gusto por escuchar.

marcos :: Gusto->Influencer
-- marcos gusto persona = (sacarMiedo "convertirseEnVenezuela" (agregarMiedo ("corrupcion",10) persona)) {
--     gustos = (gustos persona) ++ [gusto] -- aun no tenía "agregarGusto"
-- }
marcos gusto = aplicarOperaciones [
    (sacarMiedo "convertirseEnVenezuela"),
    (agregarMiedo ("corrupcion", 10)),
    (agregarGusto gusto)]

-- El community manager de un artista es un influencer que hace que la gente se haga fan de dicho artista.

type Artista = Persona

communityManager :: Artista->Influencer
communityManager art = (flip fanatizar art)

-- Está el influencer inutil, que no lograr alterar nada.

inutil :: Influencer
inutil = id

-- Agregá uno a tu elección, pero que tambien realice uno o más cambios en una persona.
-- El influencer Vegetal, que después de presentarle a una persona su community manager
-- (con su nombre no artístico) les agrega el miedo a convertirse en una verdura en nivel 314.

juanCarlosLechuga :: Persona --nombre real de "Vegetal"
juanCarlosLechuga = UnaPersona ["tornillos","bujias","lechuga","tomate","mandioca"] [("convertirseEnFruta",1001)] 14

managerVegetal :: Persona->Persona
managerVegetal = communityManager juanCarlosLechuga

vegetal :: Influencer
-- vegetal = (managerVegetal).(agregarMiedo ("convertirseEnVerdura",314))
vegetal = aplicarOperaciones [
    (managerVegetal),
    (agregarMiedo ("convertirseEnVerdura",314))]

-- Otro influencer, te saca el miedo y te hace fan de los extraterrestres

capitanValentia :: Influencer
-- capitanValentia persona = persona {
--     gustos = (gustos persona) ++ ["extraterrestres"],
--     miedos = []
-- }
capitanValentia = aplicarOperaciones [
    (agregarGusto "extraterrestres"),
    (\p -> p{miedos=[]})]

-- Implementar las funciones que permitan:
-- Hacer una campaña de marketing básica, que dado un conjunto de personas hace que todas ellas
-- sean influenciadas por un influencer dado.

pessoal :: [Persona]
pessoal = [maria, juanCarlos, juanCarlosLechuga, carmen, celio, chuckNorris, tipo]

campania :: [Persona]->Influencer->[Persona]
campania personas inf = map inf personas

-- Saber qué influencer es más generador de miedo: dada una lista de personas y dos influencer,
-- saber cuál de ellos provoca que más personas se vuelvan miedosas.

cantidadDeMiedosos :: [Persona]->Int
cantidadDeMiedosos personas = length (filter personaMiedosa personas)

masTerrorista :: [Persona]->Influencer->Influencer->Bool
masTerrorista personas inf1 inf2 = miedosas1 > miedosas2
    where   miedosas1 = cantidadDeMiedosos (campania personas inf1)
            miedosas2 = cantidadDeMiedosos (campania personas inf2)

------ LA INFLUENCIACION ------

-- La influenciación
-- El objetivo principal de influenciar, sin embargo, es vender productos.
-- De cada producto se saben dos cosas: el gusto que se necesita que tenga la persona para
-- comprarlo y una condición adicional específica de ese producto.

data Producto = UnProducto {
    gustoNecesario :: Gusto,
    condicion :: Persona->Bool
}

compraProducto :: Producto->Persona->Bool
compraProducto prod persona = (elem (gustoNecesario prod) (gustos persona)) && ((condicion prod) persona)

-- Por ejemplo:

-- El desodorante Acks necesita que a la gente le guste el chocolate pero además que la estabilidad de la persona sea menor a 50.
acks :: Producto
acks = UnProducto "chocolate" ((>50).estabilidad)

-- El llavero de plato volador necesita que a la persona le gusten los extraterrestres pero que no sea miedosa.
llaveroOvni :: Producto
llaveroOvni = UnProducto "extraterrestres" (not.personaMiedosa)

-- El pollo frito Ca Efe Se necesita que a la persona le guste lo frito y que sea fanática del pollo.

caEfeSePollosNinja :: Producto
caEfeSePollosNinja = UnProducto "fritanga" (fanaticoGusto "pollo")

-- Calcular la eficiencia de un campaña de marketing con un influencer para un producto en particular.
-- Es el porcentaje de variación de la cantidad de gente que antes de la campaña
-- no hubiera comprado el producto, pero luego sí.

eficienciaCampania :: [Persona]->Producto->Influencer->Float
eficienciaCampania gente prod inf = 100*(compranDespues-compranAntes)/fromIntegral(length gente)
--entiendo variacion como eso
    where   compranAntes = fromIntegral( length (filter (compraProducto prod) gente) )
            compranDespues = fromIntegral( length (filter (compraProducto prod) (campania gente inf)) )

-- Analizar qué sucede en caso de utilizar una lista infinita.

miedosInfinitos :: [(Miedo,Int)]
miedosInfinitos = map (\x->("miedo"++(show x), x)) [1..]
chabonMuyMiedoso :: Persona
chabonMuyMiedoso = UnaPersona [] miedosInfinitos 1

-- Mostrar formas de utilizar algunas de las funciones hechas de manera que:
-- ###### Se quede iterando infinitamente sin arrojar un resultado.

-- *Main> agregarMiedo "elInfinito" chabonMuyMiedoso
-- ...
--
-- Nunca termina de agregar un elemento a la lista infinita.

-- ###### Se obtenga una respuesta finita.

-- *Main> fanaticoGusto "papasFritas" chabonMuyMiedoso
-- False
--
-- La condición que evalúa no se fija nunca en la lista de miedos infinitos, por lo que
-- se termina de resolver sin problemas.

-- ###### La respuesta que se obtiene sea a su vez infinita.

-- *Main> variarEstabilidad 50 chabonMuyMiedoso
-- UnaPersona {gustos = [], miedos = [("miedo1",1),("miedo2",2),("miedo3",3),("miedo4",4),("miedo5",5)...
--
-- Modifica cosas que no tienen que ver con la lista infinita, así que cuando termina de hacerlo muestra
-- el resultado... Pero este resultado contiene una lista infinita (mostrable en pantalla). No termina
-- nunca de mostrarse el resultado, si bien se termina de resolver.

-- Explicar la utilidad del concepto de aplicación parcial en la resolución realizada dando un ejemplo concreto donde se lo usó

-- La aplicación parcial permite definir una función en base a otra sin necesidad de pasarle argumentos.
-- En este parcial, lo usé para la función "managerVegetal", por ejemplo. Pude crear un manager para un
-- cierto artista utilizando la definición de "communityManager" y pasándole solamente el primer argumento (el influencer).
-- También lo usé en la parte de 'productos', para definir funciones de tipo (Persona->Bool) usando
-- funciones aplicadas parcialmente como (>50), o ' fanaticoGusto "pollo" '.

-- Tras ver el issue de Lucas, ahora la aplicación parcial fue extremadamente útil en el punto de los "Influencers",
-- ya que definí todos como una lista de funciones (Persona->Persona) aplicadas parcialmente que se evalúan con un
-- foldr usando "aplicarOperaciones". Quedé muy satisfecho con esta solución.

-- Este fue un parcial muy interesante en un gran lenguaje.