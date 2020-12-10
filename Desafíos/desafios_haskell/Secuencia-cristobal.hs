import Data.List

iterarLista::[String]->String
iterarLista [] = ""
iterarLista (x:xs) = show (length x) ++ [head x] ++ iterarLista xs

mostrarLista::String->[String]
mostrarLista x = [x] ++ mostrarLista (iterarLista (groupBy (==) x))