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

substituye(_,_,[],[]).
substituye(X,Y,[X|TX],[X|TY]):-substituye(X,Y,TX,TY).
substituye(X,Y,[_|TX],[_|TY]):-substituye(X,Y,TX,TY).


permutacion(_,[],[],[],[]).
permutacion(0,[X|TX],[Y|TY],[X|TX1],[Y|TY1]):-
        permutacion(1,TX,TY,TX1,TY1).
permutacion(1,[X|TX],[Y|TY],[Y|TX1],[X|TY1]):-
        permutacion(0,TX,TY,TX1,TY1).

permutacion_par(XS,YS,S1,S2):-permutacion(0,XS,YS,S1,S2).
permutacion_impar(XS,YS,S1,S2):-permutacion(1,XS,YS,S1,S2).

%% sort list

bubble([],[]).
bubble([X],[X]).
bubble([X1,X2|TX],[X1|TY]):-X2>=X1,bubble([X2|TX],TY).
bubble([X1,X2|TX],[X2|TY]):-bubble([X1|TX],TY).

my_sort(XS,XS):-bubble(XS,XS).
my_sort(XS,YS):-bubble(XS,ZS),my_sort(ZS,YS).

%% plagelao version

weird_sort([], []).
weird_sort([Element], [Element]).
weird_sort([First,Second|Tail], [First,Second|SortedTail]) :-
        First =< Second,
        weird_sort(Tail, SortedTail).
weird_sort([Head|Tail], [SortedHead|NewSortedTail]) :-
        weird_sort(Tail, [SortedHead|SortedTail]),
        weird_sort([Head|SortedTail], NewSortedTail).


nat(0).
nat(succ(X)):-nat(X).

add(0,Y,Y).
add(succ(X),Y,succ(Z)) :-
        add(X,Y,Z).

greater_than(succ(X),0).
greater_than(succ(X),succ(Y)):-greater_than(X,Y).

% Exercise 10.1
p(1).
p(2):-!.
p(3).

% p(X). X=1
% p(X),p(Y). X=1 Y=1
% p(X),!,p(Y). X=1 Y=1

% Exercise 10.2

class(Number,positive) :- Number > 0,!.
class(0,zero).
class(Number, negative) :- Number < 0,!.

% Exercise 10.3
% split([3,4,-5,-1,0,4,-9],P,N)

split([],[],[]).
split([H|T],[H|TX],Y):-
        not(class(H,negative)),
        split(T,TX,Y),!.
split([H|T],X,[H|TY]):-
        split(T,X,TY),!.
