import Data.List (nub)
import Text.Show.Functions()

-- DATAS
data Pollo = UnPollo{
    nombre :: String,
    diasVivos :: Float,
    peso :: Float,
    artesMarciales :: [String]
} deriving Show

data Raton = UnRaton {
    pesoR :: Float,
    altura :: Float,
    bigotes :: Int
} deriving (Show)

data Entrenador = UnEntrenador {
    nombreE :: String,
    entrenamiento :: (Pollo->Pollo)
} deriving Show

data Planeta = UnPlaneta{
    habitantes::[Pollo],
    entrenador::Entrenador
} deriving Show

-- POLLOS
gin::Pollo
gin = UnPollo "ginger" 10 150 ["karate", "tai chi chuan", "saltar"]
roc::Pollo
roc = UnPollo "rocky" 1 3000 []
pau::Pollo
pau = UnPollo "Paula" 2 300 ["judo","karate"]
cristobal::Pollo
cristobal = UnPollo "Cristobal" 7000 90 ["rugby", "nodejs"]
guido::Pollo
guido = UnPollo "Guido" 7500 10 ["python", "pseudocodigo"]
vraco::Pollo
vraco = UnPollo "Oscar L" 25000 100 ["kung fu","tai chi chuan","judo","aikido"]
polloTonto::Pollo
polloTonto = UnPollo "Tonto" 2 2 []

-- 1. Engordar a un pollo una cierta cantidad de gramos
engordarPollo :: Pollo -> Float -> Pollo
engordarPollo pollo gramos = pollo { peso = peso pollo + gramos }

-- 2. Es mayor el pollo (se consideran meses de 30 dias)
esMayor :: Pollo -> Bool
esMayor pollo = diasVivos pollo > 180

-- 3. Saber si el último atributo de un pollo es vacío.
esVacio :: Pollo -> Bool
esVacio pollo = (artesMarciales pollo) == []

-- 4. Cruzar un conjunto de pollos
fusionPollos :: [Pollo] -> Pollo
fusionPollos listaPollos = UnPollo {
    nombre = combinarNombres (map nombre listaPollos),
    diasVivos = sum(map (\ x -> (diasVivos x)**2) listaPollos),
    peso = sum(map peso listaPollos),
    artesMarciales = nub (concat (map artesMarciales listaPollos))
}

combinarNombres :: [String] -> String
combinarNombres lista = foldl (++) "" (map (\ x -> take 2 x) lista)

--
-- Parte pollos ninja
--

ratonPerez::Raton
ratonPerez = UnRaton 20.5 5.5 20

-- ENTRENADORES
arguiniano::Entrenador
arguiniano = UnEntrenador "arguiniano" entrenaArguiniano
miyagi::Entrenador
miyagi = UnEntrenador "miyagi" entrenaMiyagi
marcelito::Entrenador
marcelito = UnEntrenador "marcelito" entrenaMarcelito
brujaTapita::Entrenador
brujaTapita = UnEntrenador "brujaTapita" (entrenaBrujaTapita ratonPerez)
marioBros::Entrenador
marioBros = UnEntrenador "marioBros" (entrenaMarioBros "karate")

agregarSiNoEsta::String->[String]->[String]
agregarSiNoEsta elemento lista
    | not (elem elemento lista) = lista++[elemento]
    | otherwise = lista

entrenaArguiniano::Pollo->Pollo
entrenaArguiniano pollo = engordarPollo pollo 100

entrenaMiyagi::Pollo->Pollo
entrenaMiyagi pollo = pollo{artesMarciales = (agregarSiNoEsta "karate" (artesMarciales pollo))}

entrenaMarcelito::Pollo->Pollo
entrenaMarcelito pollo = entrenaMiyagi (pollo {artesMarciales = []})

-- Al peso del raton no se le puede poner solo 'peso' porque Haskell interpreta peso como el peso del data Pollo
entrenaBrujaTapita::Raton->Pollo->Pollo
entrenaBrujaTapita raton pollo = engordarPollo pollo (pesoR raton * altura raton - fromIntegral (bigotes raton))

entrenaMarioBros::String->Pollo->Pollo
entrenaMarioBros nuevaArte pollo = pollo {
    nombre = "super mario " ++ (nombre pollo),
    artesMarciales = agregarSiNoEsta nuevaArte (agregarSiNoEsta "saltar" (artesMarciales pollo))
    }

cualEntrenaMejor::Entrenador->Entrenador->Pollo->Entrenador
cualEntrenaMejor ent1 ent2 pollo
    | length (artesMarciales ((entrenamiento ent1) pollo)) > length (artesMarciales ((entrenamiento ent2) pollo)) = ent1
    | otherwise = ent2

---Parte Pollos Ninjas Espaciales

tlon::Planeta
tlon = UnPlaneta [gin, roc] arguiniano
kosovo::Planeta
kosovo = UnPlaneta [cristobal,pau] marioBros
noobium::Planeta
noobium = UnPlaneta [polloTonto, roc, vraco] brujaTapita
nameku :: Planeta
nameku = UnPlaneta [polloTonto, roc] arguiniano

getCantidadArtes::Planeta->[Int]
getCantidadArtes planeta = map length (map artesMarciales (habitantes planeta))

-- 1. elMejorPollo
cantArtesMarciales :: Pollo -> Pollo -> Pollo --dados dos pollos retorna el que más a.m. sabe
cantArtesMarciales pollo1 pollo2
   | length(artesMarciales pollo1) > length(artesMarciales pollo2) = pollo1
   | otherwise = pollo2

mejorPolloLista :: [Pollo] -> Pollo
mejorPolloLista listaPollos = foldl1 (cantArtesMarciales) listaPollos

elMejorPollo :: Planeta -> Pollo
elMejorPollo planeta = mejorPolloLista (habitantes planeta)

-- 2. esDebil
esDebil::Planeta->Bool
esDebil planeta =  
    (all (<=2) (getCantidadArtes planeta)) || (length (filter (==0) (getCantidadArtes planeta)) >= 2)

-- 3. entrenar
entrenar::Planeta->Planeta
entrenar planeta = planeta{habitantes = map (entrenamiento (entrenador planeta)) (habitantes planeta)}

-- 4.  entrenamientoKaio
--usando "entrenar" del punto anterior
entrenamientoKaio :: Planeta -> Planeta -> Planeta
entrenamientoKaio planetaA planetaB = planetaA{
    habitantes =  map (entrenamiento (entrenador planetaB)) (habitantes (entrenar planetaA))
}

-- 5. The Chicken One
hacerViajeEspiritual::[Entrenador]->Pollo->Pollo
hacerViajeEspiritual entrenadores pollo = foldr (entrenamiento) pollo entrenadores

-- 6. Planeta Debil Entrenado
planetaEntrenadoEsDebil :: Planeta -> [Entrenador] -> Bool
planetaEntrenadoEsDebil planeta entrenadores =  
    esDebil (planeta {habitantes = hacerViajarATodos entrenadores (habitantes planeta)})

hacerViajarATodos::[Entrenador]->[Pollo]->[Pollo] --asignación parcial
hacerViajarATodos ents = map (hacerViajeEspiritual ents)

-- Pollos Ninjas Espaciales Mutantes

-- 1. ChickenNorris
chickenNorris::Pollo
chickenNorris = UnPollo "Chicken Norris" 9000000 100000 ["karate" ++ (show i) | i <- [1..]]

-- Los entrenamientos que agregan un arte marcial no funcionan porque
-- nunca se termina de evaluar la lista infinita, y no se puede concatenar nada al final,
-- mucho menos mostrarla.
-- Por ejemplo:
--              entrenaMiyagi chickenNorris -> bucle infinito
-- En cambio, los entrenamientos que modifican otros campos andan bien, por ej.
--              entrenaArguiniano chickenNorris -> anda bien porque sólo modifica el peso
-- En los casos exitosos, igual, nunca se termina de mostrar la lista porque es infinita.
-- Ver capturas de pantalla en el repo.

-- 2. Graduar al mejor pollo de un planeta
graduarPollo :: Planeta -> Entrenador
graduarPollo planeta = UnEntrenador{
    nombreE = nombre (elMejorPollo planeta),
    entrenamiento = entrenaPolloGraduado (elMejorPollo planeta)
}

entrenaPolloGraduado :: Pollo -> Pollo -> Pollo
entrenaPolloGraduado polloGraduado pollo = pollo {
    artesMarciales = nub (artesMarciales pollo ++ artesMarciales polloGraduado)
}

-- 3. Definir a Marceñano
marceniano::Entrenador
marceniano = UnEntrenador "Marceniano" ((entrenamiento marcelito).(entrenamiento arguiniano))