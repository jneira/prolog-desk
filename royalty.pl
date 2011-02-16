man('Haakon VII').
man('Olav V').
man('Harald V').
man('Haakon').
woman('Martha').
woman('Mette-Marit').
woman('Maud').
woman('Sonja').
parent('Haakon VII','Olav V').
parent('Maud','Olav V').
parent('Olav V','Harald V').
parent('Martha','Harald V').
parent('Harald V','Haakon').
parent('Sonja','Haakon').
father(X,Y):- parent(X,Y), man(X).
mother(X,Y):- parent(X,Y), woman(X).
son(X,Y):- parent(Y,X), man(X).
daughter(X,Y):- parent(Y,X), woman(X).
