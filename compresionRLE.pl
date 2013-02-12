comprimir([],[]).
comprimir(In,[Num,X|TR]):-
    agrupar(In,5,[Num,X|T]),
    comprimir(T,TR).

agrupar([],_,[]).
agrupar([X],_,[1,X]).
agrupar([X|T],1,[1,X|T]).
agrupar([X,X|T],Max,[Num|TY]):-
    Sig is Max-1,
    agrupar([X|T],Sig,[Prev|TY]),
    Num is Prev+1.
agrupar([X|T],_,[1,X|T]).
