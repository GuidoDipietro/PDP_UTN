-- Calcular los divisores 
divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], n `mod` x == 0]

-- Será primo solo si sus divisores son 1 y él mismo
esPrimo :: Int -> Bool
esPrimo n = divisores n == [1,n]

-- Filtrar los números 
primos :: Int -> [Int]
primos n = [x | x <- [2..n], esPrimo x]

-- Mayor numero primo
mayorPrimo:: Int-> Int
mayorPrimo n= maximum (primos n)