caracteres(Num):- % cantidad de letras en el archivo
    read_file_to_codes('insistencia.txt', Codes, []), % devuelve lista con códigos ASCII de cada carácter
    length(Codes, Num).
    
agregar(Cosa):- % agrega información dada al final del archivo
    open('insistencia.txt',read,FlujoR),
    read(FlujoR,Contenido),
    close(FlujoR),
    open('insistencia.txt',write,FlujoW),
    write(FlujoW, Contenido),
    write(FlujoW, Cosa),
    close(FlujoW).

burroShrek(N):-
    caracteres(Num),Num=<N,
    write('Ya llegamos?'),nl,
    write('No.....'),
    agregar('a.').
burroShrek(N):-
    caracteres(Num),Num>N,
    write('Ya llegamos?'),nl,
    write('BASTA BURRO').

% insistencia.txt tiene que tener el contenido "a." antes de empezar %