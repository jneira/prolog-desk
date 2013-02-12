%% Febrero 2011-2

objeto([a,b]).
bloque([[a],[b]]).

sobre(X,Y):-
        bloque(XS),
        sobre(X,Y,XS).

sobre(_,_,[]):-fail.
sobre(X,Y,[[X,Y]|_]).
sobre(X,Y,[_|XS]):-sobre(X,Y,XS).
        
mover_bloque([X,Y],Res):-
        bloque(XS),
        mover_bloque([X,Y],XS,Res).

mover_bloque([_,_],[],[]).
mover_bloque([X,Y],[[X,Y]|XS],[[X],[Y]|YS]):-
        mover_bloque([X,Y],XS,YS).
mover_bloque([X,Y],[[X]|XS],YS):-
        mover_bloque([X,Y],XS,YS).
mover_bloque([X,Y],[[Y]|XS],[[X,Y]|YS]):-
        mover_bloque([X,Y],XS,YS).
mover_bloque([X,Y],[Z|XS],[Z|YS]):-
        mover_bloque([X,Y],XS,YS).

%% Septiembre 2011-1

%%Codigo con errores
% repetir:-repetir.
% repetir.

repetir.
% repetir:-repetir.

nombre(pedro).
nombre(ana).
nombre(juan).
nombre(lola).

% nombres:-repetir,nombre(X),write(X),nl,fail.
nombres:-repetir,nombre(X),write(X),nl,fail.
%% El predicado repetir es un loop recursivo infinito ya que
%% la condicion de de terminacion esta despues de la que establece
%% la llamada recursiva.
%% El predicado nombres tambien entra en un loop infinito ya que
%% el ultimo fail provoca que el bactracking vuelva al primer predicado,
%% intentando la llamada recursiva y volviendo a imprimir los 4 nombres

%% Problema 4

%% buscar(3,[[1,0,3],[1,2,-1]],3,1).
%% yes.
%% buscar(1,[[1,0,3],[1,2,-1]],X,Y).
%% X=1,Y=1
%% X=1,Y=2
%% buscar(X,[[1,0,3],[1,2,-1]],3,2).
%% X=-1

buscar(X,[[X|_]|_],1,1).
buscar(E,[[_|XS]|S],I,1):-
        buscar(E,[XS|S],I2,1),I is I2+1.
buscar(E,[_|XS],I,J):-
        buscar(E,XS,I,J2),J is J2+1.

%% Septiembre 2010-1

%% Problema 3
%% triangulo_siguiente_fila([1,2,1],X).
%% X=[1,3,3,1]
%% triangulo_siguiente_fila([1,3,3,1],X).
%% X=[1,4,6,4,1]
pascal_next([X|T],[X|TR]):-
        pascal_next_tail([X|T],TR).
pascal_next_tail([X],[X]).
pascal_next_tail([X,Y|T],[XY|TR]):-
        pascal_next_tail([Y|T],TR),XY is X+Y.

%% Problema 4
%% triangulo(0,Fila).
%% Fila=[1]
%% triangulo(3,Fila).
%% Fila=[1,4,6,4,1]

pascal_row(0,[1]).
pascal_row(1,[1,2,1]).
pascal_row(X,Row):-
        Y is X-1,
        pascal_row(Y,NextRow),
        pascal_next(NextRow,Row).
        
%% Septieembre 2010-2

%% numeros(2,7,[2,3,4,5,6,7])

numeros(X,X,[X]).
numeros(X,Y,[X|XS]):-
        X<Y,XN is X+1,numeros(XN,Y,XS).

% numeros(2,7,[2|[3,4,5,6,7])
% 2<7,XN is 3
% numeros(3,7,[3|[4,5,6,7])
% 3<7,XN is 4
% numeros(4,7,[4,5,6,7])
% 4<7, XN is 5
% numeros(5,7,[5,6,7])
% 4<7, XN is 6
% numeros(4,7,[4,5,6,7])
% 4<7, XN is 5

%% Problema 4

aplanar([],[]).
aplanar([[X]|XS],[X|RS]):-aplanar(XS,RS).

