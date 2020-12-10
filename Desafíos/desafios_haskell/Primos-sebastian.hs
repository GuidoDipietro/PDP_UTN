esDivisor:: Int -> Int -> Bool
esDivisor n m = (mod n m) == 0

divisores :: Int -> Int -> Int
divisores num1 1 = 1
divisores num1 num2
    | esDivisor num1 num2 = 1 +  divisores num1 (num2-1)
    | otherwise = divisores num1 (num2-1)

esPrimo :: Int->Bool
esPrimo 2 = True
esPrimo n = divisores n n == 2

mayorPrimo :: Int -> Int
mayorPrimo n
    |esPrimo n = n
    |otherwise = mayorPrimo (n+1)

{-
Mi programa de números primos posee una función llamada esPrimo, 
la cual es la que utilizo para determinar si un número es primo o no 
(puedo ir adivinando si uno es o no y de ahí llegar al más grande). 
Sin embargo, a partir del millón, tarda dos segundos en analizar si es o no primo, 
y así demora cada vez más en calcular (un número cercano a 70 millones me demoró dos minutos). 
También poseo una función llamada mayorPrimo, la cual, dado un número, 
busca el siguiente número primo, el primero que sea mayor al número ingresado 
(el cual es más lento debido a que va comparando si son primos uno por uno).
Pude encontrar el número primo 62868991 
(a mi programa le tomó dos minutos determinar si lo es, con la función esPrimo)
-}
