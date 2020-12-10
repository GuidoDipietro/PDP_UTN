--agregué el campo "nombre"
--para ayudar a la resolución del punto 6)
data Enfermedad = Enfermedad{
    nombre::String,
    tasaMortalidad::Float,
    medidaDeAtaque::String
} deriving Show

--agregué un campo "victimas"
--para resolver el punto 5)
data Planeta = Planeta{
    poblacion::Float,
    continentes::[String],
    medidas::[String],
    victimas::Float
} deriving Show

--------------------------------------------

--Enfermedad nombre tasa medidaAtaque

coronaVirus::Enfermedad
coronaVirus = Enfermedad "covid19" 3.5 "cuarentena"

covid20::Enfermedad
covid20 = Enfermedad "covid20" 14.27 "cuarentena"
--el covid20 se transmite por la luz...!!
--había puesto otra medidaDeAtaque pero la funcion del punto
--6) no tiene mucho sentido si no hay enfermedades con la misma medida

pielDeAgua::Enfermedad
pielDeAgua = Enfermedad "hidrodermismo" 99.98 "transplante de piel" 
--transforma las células de la piel en agua...
--la más letal del universo...

pielColgante::Enfermedad
pielColgante = Enfermedad "dermodilatación" 44.1 "transplante de piel"
--aumenta el campo eléctrico de las células de la piel
--causando que puedan permanecer unidas a mayor distancia
--por lo que la piel se estira y se cae

flasheoProfundo::Enfermedad
flasheoProfundo = Enfermedad "esquizofreniaRealista" 11.2 "meditacion budista"
--esquizofrenia pero las alucinaciones se convierten en reales
--y pueden interactuar con otras personas

--------------------------------------------

--Nota:
--      los nombres de los planetas, planetas enanos, o planetoides,
--      junto con sus continentes, y sus medidas han sido
--      traducidas o transliteradas al español.

--Planeta poblacion [continentes] [medidas tomadas] victimas

tierraAntesDeCuarentena::Planeta
tierraAntesDeCuarentena = Planeta 7777382699 ["América", "Asia", "Africa", "Europa", "Oceanía"] ["lavarse las manos"] 0

mandrako::Planeta
mandrako = Planeta 142749007 ["Mandrako-bil", "Mandrako-paur", "Mandrako-ney"] [] 0

quaoar::Planeta
quaoar = Planeta 3141592 ["bir tawil","lopadonium","shqmeria","bortaSbir"] [] 0

disnomia::Planeta
disnomia = Planeta 166822 ["palatao","menfy"] [] 0

kepler10c::Planeta
kepler10c = Planeta 479221230014 [] [] 0

skeria::Planeta
skeria = Planeta 12884233101 ["nompen","knaburb","syeux","sdNah","utnba","llanfairpwllgwyngyllgogerychwyrndrobwlllantysiliogogogoch","AM","jasquel","nyourken","Malvinas"] [] 0

--------------------------------------------

--funcionalidad extra: combina los nombres de las dos enf
combinarEnfermedades::Enfermedad -> Enfermedad -> Enfermedad
combinarEnfermedades enfermedad1 enfermedad2 = Enfermedad (nombre enfermedad1 ++ " " ++ nombre enfermedad2) ((tasaMortalidad enfermedad1)+(tasaMortalidad enfermedad2)) (medidaDeAtaque enfermedad1)

actualizarMedidas::[String]->String->[String] --agrega la medida si no está aún
actualizarMedidas medidas medidaNueva
    | not(elem medidaNueva medidas) = medidas++[medidaNueva]
    | otherwise = medidas
tomarMedidas::Planeta->Enfermedad->Planeta
tomarMedidas planeta enfermedad = planeta {medidas = (actualizarMedidas (medidas planeta) (medidaDeAtaque enfermedad))}

mueren::Planeta->Enfermedad->Float --cuantos mueren en un planeta, dada enfermedad y sus medidas tomadas
mueren planeta enfermedad
    | not(elem (medidaDeAtaque enfermedad) (medidas planeta)) = ((tasaMortalidad enfermedad) * (poblacion planeta))/100
    | otherwise = 0
muerenMasDe::Int->Planeta->Enfermedad->Bool
muerenMasDe cantidad planeta enfermedad = (mueren planeta enfermedad) > (fromIntegral cantidad)
previene::Planeta->Enfermedad->Bool --controla si un planeta está protegido de X enfermedad
previene planeta enfermedad = elem (medidaDeAtaque enfermedad) (medidas planeta)
estaEnElHorno::Planeta->Enfermedad->Bool
estaEnElHorno planeta enfermedad = not (previene planeta enfermedad) && (muerenMasDe 1000000 planeta enfermedad)
--La función estaEnElhorno no es muy precisa, porque en planetas
--con menos de 1M de habitantes (como disnomia) puede exterminarse
--toda la población y aún "no estar en el horno".
--Sugiero utilizar llegoElApocalipsis que se fija si morirá más del 50% de la población:
llegoElApocalipsis::Planeta->Enfermedad->Bool
llegoElApocalipsis planeta enfermedad =
    not (previene planeta enfermedad) && (tasaMortalidad enfermedad > 50)

cantContinentes::Planeta->Int
cantContinentes planeta
    | length (continentes planeta) == 0 = 1
    | otherwise = length (continentes planeta)
habitantesPorContinente::Planeta->Float
habitantesPorContinente planeta = (poblacion planeta)/(fromIntegral (cantContinentes planeta))
masMedidasQueHPC::Planeta->Bool
masMedidasQueHPC planeta = (fromIntegral(length (medidas planeta))) > (habitantesPorContinente planeta)
--esta función retorna siempre false... es imposible tener tantas medidas
--si hay solo 5 enfermedades

poblacionTrasEnfermedad::Planeta->Enfermedad->Planeta --actualiza población y víctimas
poblacionTrasEnfermedad planeta enfermedad = planeta{poblacion = (poblacion planeta)-(mueren planeta enfermedad), victimas = (victimas planeta) + (mueren planeta enfermedad)}
ataque::Planeta->Enfermedad->Planeta
ataque planeta enfermedad
    | not (previene planeta enfermedad) = tomarMedidas (poblacionTrasEnfermedad planeta enfermedad) enfermedad
    | otherwise = planeta

--ataqué primero con una enfermedad y luego con otra
--en lugar de atacar con (combinarEnfermedades e1 e2)
--porque no tendría sentido hacerlo así
cualCombEsMasLetal::Planeta->Enfermedad->Enfermedad->String
cualCombEsMasLetal planeta enfermedad1 enfermedad2
    | victimas (ataque (ataque planeta enfermedad1) enfermedad2) > victimas (ataque (ataque planeta enfermedad2) enfermedad1) = (nombre enfermedad1)++" y luego "++(nombre enfermedad2)
    | otherwise = (nombre enfermedad2)++" y luego "++(nombre enfermedad1)