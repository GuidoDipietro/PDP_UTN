potencia::  Integer -> Integer -> Integer
potencia x 1 =  x
potencia x y =  x * (potencia x (y-1))


buscarNumerosPrimos numero 
    | teoremaDeFermat numero  = numero:buscarNumerosPrimos (numero+1)
    | otherwise = buscarNumerosPrimos (numero+1)

teoremaDeFermat::  Integer -> Bool
teoremaDeFermat numero =  rem (potencia 2 (numero-1))(numero) ==1