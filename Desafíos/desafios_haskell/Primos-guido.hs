algunosFactores::Int->[Int]
algunosFactores x = [2..(raiz x)]

esPrimo::Int->Bool
esPrimo n = all (/=0) [rem n x | x <- (algunosFactores n)]

listaNumeros::[Int]
listaNumeros = [9000000000000001, 9000000000000003..]

listaPrimos::[Int]->[Int]
listaPrimos [] = []
listaPrimos (x:xs)
    | esPrimo x = x : (listaPrimos xs)
    | otherwise = listaPrimos xs

raiz::Int->Int
raiz x = floor ((fromIntegral x)**(0.5))

--last (listaPrimos (take 100 listaNumeros))
--Llegué a 9000000000000197