type Contenido = Int

data Arbol = Nada | Nodo Contenido Arbol Arbol

ordenar::[Contenido]->[Contenido]
ordenar conjunto = recorrer (insertarSucesivamente conjunto Nada)
--variante hacker
--ordenar = recorrer.foldr insertar Nada  

recorrer::Arbol->[Contenido]
recorrer Nada = []
recorrer (Nodo valor izq der) = recorrer izq ++ [valor] ++ recorrer der

insertar::Contenido->Arbol->Arbol
insertar nuevo Nada = Nodo nuevo Nada Nada
insertar nuevo (Nodo valor izq der) 
  | nuevo < valor = Nodo valor (insertar nuevo izq) der
  | otherwise = Nodo valor izq (insertar nuevo der)

insertarSucesivamente::[Contenido] -> Arbol -> Arbol
insertarSucesivamente [] arbol = arbol
insertarSucesivamente (x:xs) arbol = insertar x (insertarSucesivamente xs arbol)
