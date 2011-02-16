%% Ejercicio 3.1

hombre('javier','grande','rubio','joven').
mujer('jander','mediana','morena','madura').
mujer('chispa','grande','rubia','anciana').

gustos('javier','jazz','ciencia ficcion','tenis').
gustos('jander','jazz','ciencia ficcion','tenis').

busca('javier','mediana','morena','madura').
busca('jander','grande','rubio','joven').

coincideBusqueda(X,Y):-
        busca(X,G1,G2,G3),
        (hombre(Y,G1,G2,G3);mujer(Y,G1,G2,G3)).   

coincideGustos(X,Y):-
        gustos(X,G1,G2,G3),gustos(Y,G1,G2,G3).

diferenteSexo(X,Y):-
        (hombre(X,_,_,_),mujer(Y,_,_,_));
        (mujer(Y,_,_,_),hombre(Y,_,_,_)).

compatible(X,Y):- 
        coincideGustos(X,Y),
        coincideBusqueda(X,Y),
        diferenteSexo(X,Y).

compatibles(X,Y):-
        compatible(X,Y),compatible(Y,X).

%% Ejercicio 3.2

par(X):-0 is mod(X,2).
impar(X):- not(par(X)).  

divide(X,Y,Z):-
        X<Y,Z is 0.
divide(X,Y,Z):-
        X1 is X-Y,divide(X1,Y,Z1),Z is Z1+1.

%% Ejercicio 3.3

substituye(X,Y,[],[]).
substituye(X,Y,[X|TX],[X|TY]):-substituye(X,Y,TX,TY).
substituye(X,Y,[_|TX],[_|TY]):-substituye(X,Y,TX,TY).


permutacion(_,[],[],[],[]).
permutacion(0,[X|TX],[Y|TY],[X|TX1],[Y|TY1]):-
        permutacion(1,TX,TY,TX1,TY1).
permutacion(1,[X|TX],[Y|TY],[Y|TX1],[X|TY1]):-
        permutacion(0,TX,TY,TX1,TY1).

permutacion_par(XS,YS,S1,S2):-permutacion(0,XS,YS,S1,S2).
permutacion_impar(XS,YS,S1,S2):-permutacion(1,XS,YS,S1,S2).

