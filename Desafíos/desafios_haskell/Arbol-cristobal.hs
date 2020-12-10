data Arbol = Nodo {
    raiz::Int,
    siguientes::[Arbol]
} | Nadie deriving(Show, Eq)

lista::[Int]
lista = [6,76,34,23,1,4,24,25]

recorrerArbol::Arbol->[Int]
recorrerArbol (Nodo raiz [Nadie, Nadie]) = [raiz]
recorrerArbol (Nodo raiz [Nadie, sig]) = [raiz] ++ recorrerArbol  sig
recorrerArbol (Nodo raiz [sig, Nadie]) = recorrerArbol sig ++ [raiz]
recorrerArbol mainNode = recorrerArbol (head (siguientes mainNode)) ++ [raiz mainNode] ++ recorrerArbol (last (siguientes mainNode))

armarArbol::[Int]->Arbol
armarArbol (x:xs) = iterarLista (Nodo x [Nadie, Nadie]) xs

iterarLista::Arbol->[Int]->Arbol
iterarLista nodoP [x] = agregarNodo nodoP x
iterarLista nodoP (x:xs) = iterarLista (agregarNodo nodoP x) xs

agregarNodo::Arbol->Int->Arbol
agregarNodo (Nodo raiz (x:xs)) eRaiz
    | eRaiz < raiz && x == Nadie = Nodo raiz ([Nodo eRaiz [Nadie, Nadie]] ++ xs)
    | eRaiz > raiz && (head xs) == Nadie = Nodo raiz ([x] ++ [Nodo eRaiz [Nadie, Nadie]])
    | eRaiz < raiz = Nodo raiz [agregarNodo x eRaiz, head xs]
    | otherwise = Nodo raiz [x, agregarNodo (head xs) eRaiz]