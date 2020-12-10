--Ordena una lista de números naturales todos distintos

data Nodo = UnNodo {
    valor::Int,
    nodoMenor::Nodo,
    nodoMayor::Nodo,
    esNull::Bool
}

nodoNull::Nodo
nodoNull = UnNodo 0 nodoNull nodoNull True

-- Árbol de prueba:
--
-- nodo10::Nodo
-- nodo10 = UnNodo 10 nodo9 nodo20 False
-- nodo9::Nodo
-- nodo9 = UnNodo 9 nodo4 nodoNull False
-- nodo4::Nodo
-- nodo4 = UnNodo 4 nodo3 nodo8 False
-- nodo8::Nodo
-- nodo8 = UnNodo 8 nodoNull nodoNull False
-- nodo3::Nodo
-- nodo3 = UnNodo 3 nodo1 nodoNull False
-- nodo1::Nodo
-- nodo1 = UnNodo 1 nodoNull nodoNull False
-- nodo20::Nodo
-- nodo20 = UnNodo 20 nodo11 nodoNull False
-- nodo11::Nodo
-- nodo11 = UnNodo 11 nodoNull nodo12 False
-- nodo12::Nodo
-- nodo12 = UnNodo 12 nodoNull nodoNull False

leerArbol::Nodo->[Int]
leerArbol nodo
    | esNull nodo = []
leerArbol nodo = (leerArbol (nodoMenor nodo))++[valor nodo]++(leerArbol (nodoMayor nodo))

--mucho warning, no sé qué me faltó contemplar acá
agregarNodo::Int->Nodo->Nodo
agregarNodo num nodo
    | (esNull nodo) = nodo{valor = num, esNull = False}
    | (num < (valor nodo)) && (esNull (nodoMenor nodo)) = nodo{nodoMenor = (UnNodo num nodoNull nodoNull False)}
    | (num < (valor nodo)) && not(esNull (nodoMenor nodo)) = nodo{nodoMenor = (agregarNodo num (nodoMenor nodo))}
    | (num > (valor nodo)) && (esNull (nodoMayor nodo)) = nodo{nodoMayor = (UnNodo num nodoNull nodoNull False)}
    | (num > (valor nodo)) && not(esNull (nodoMayor nodo)) = nodo{nodoMayor = (agregarNodo num (nodoMayor nodo))}

armarArbol::[Int]->Nodo->Nodo
armarArbol [] arbol = arbol
armarArbol (x:xs) arbol = armarArbol xs (agregarNodo x arbol)

lista::[Int]
lista = [14,3,19,1,11,4,17,5,9,13,15,2,18,16,6,8,7,12,0,10]

--leerArbol (armarArbol lista nodoNull)