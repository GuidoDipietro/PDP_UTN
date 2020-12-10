divisible:: Int -> Int -> Bool
divisible n m = mod n m == 0

raizEntera::Int->Int
raizEntera nro = (ceiling.sqrt.fromIntegral) nro

todosLosPrimos::[Int]
todosLosPrimos = iterate primerPrimoDesde 2 

primerPrimoDesde:: Int->Int
primerPrimoDesde nro
  | esPrimo nro = nro
  | otherwise = primerPrimoDesde (nro+1)

esPrimo::Int->Bool
esPrimo nro = not (tieneUnDivisor [2..raizEntera nro] nro) 

tieneUnDivisor::[Int]->Int->Bool
tieneUnDivisor [] _ = False
tieneUnDivisor (divisor:divisores) nro = divisible nro divisor ||  tieneUnDivisor divisores nro


------------------variante------------------
losPrimos = secuenciaPrimos 2 [2]

secuenciaPrimos::Int->[Int]->[Int]
secuenciaPrimos nro previos = nro: secuenciaPrimos (siguientePrimo previos nro) (previos++[nro])

siguientePrimo:: [Int]->Int->Int
siguientePrimo [] primo = 2
siguientePrimo divisores primo =  primerPrimo divisores [primo + 1..]

primerPrimo:: [Int]->[Int]->Int
primerPrimo divisores (nro:nros)
  | primo posiblesDivisores nro = nro
  | otherwise = primerPrimo divisores nros
       where posiblesDivisores = takeWhile (<= raizEntera nro) divisores

primo::[Int]->Int->Bool
primo [] _ = True
primo (divisor:divisores) nro = not (divisible nro divisor) && primo divisores nro
