puedeGanar(Dado,Probabilidad):-
    Probabilidad is (Dado*100)/6.

probabilidadDeGanar(Dados,PuedeGanar):-
    findall(Probabilidad,(member(Dado,Dados),puedeGanar(Dado,Probabilidad)),ListaProbabilidad),
    sumlist(ListaProbabilidad,SumarProb),
    length(Dados,CantDeDados),
    PuedeGanar is (SumarProb*100)/(CantDeDados*100).