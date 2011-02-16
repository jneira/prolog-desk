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
