esNPrimo x y
    |y == 1 = True
    |(y-1) == 1 = True
    |mod x (y-1) == 0 = False
    |otherwise = esNPrimo x (y-1)

imprimirPrimos x
    |esNPrimo x x == True = x:imprimirPrimos(x+1)
    |esNPrimo x x == False = imprimirPrimos(x+1)