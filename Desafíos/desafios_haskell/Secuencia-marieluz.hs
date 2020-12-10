import Data.List

cola::String->String
cola n =intercalate "" (cola2 n)

secuencia :: String -> [String]
secuencia x= x:(secuencia (cola x))

cola2::String->[String]
cola2 n=[show (length x)++ [head x] | x <-(group n)]