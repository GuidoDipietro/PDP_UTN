secuencia::String->[String]
secuencia cadena = cadena:secuencia (siguiente cadena)

siguiente::String->String
siguiente [] = []
siguiente cadena = acomodar (primerosIguales cadena) ++ siguiente (quitar (primerosIguales cadena) cadena)

quitar::String->String->String
quitar _ [] = []
quitar [] xs = xs
quitar (_:ys) (_:xs) = quitar ys xs

primerosIguales::String->String
primerosIguales [] = []
primerosIguales [x] = [x]
primerosIguales (x1:x2:xs) 
  | x1 == x2 = x1:primerosIguales (x2:xs)
  | otherwise = [x1]

acomodar::String->String
acomodar cadena = show (length cadena) ++ [head cadena]
