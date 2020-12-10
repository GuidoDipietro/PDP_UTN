generar::Int -> Int
generar x
        | (primo (x,3)) = x
        | otherwise = generar (x*4-1)

primo::(Int,Int) -> Bool
primo (num,u)
                | (num < 0) = primo (num*(-1),u)
                | (u > ceiling(fromIntegral(num)/3)) = True
                | ((rem num u) == 0) = False
                | otherwise = primo (num,u+1)