%% Ejercicio 4.1
%% Los polinomios estan representados como lista de coeficientes
%% en la forma 1+2x+3x^2+4x^3 >> [1,2,3,4]

%% Suma de polinomios
%% (1+2x)+(3x+4x^2)=1+5x+4x^2
%% suma([1,2],[0,3,4],S) >> S=[1,5,4]
suma([],[],[]).
suma([],YS,YS).
suma(XS,[],XS).
suma([XH|TX],[YH|TY],[S|TS]):-
        suma(TX,TY,TS),S is XH+YH.

%% Predicado auxiliar usado en lpad
repeat(_,0,[]).
repeat(Elem,1,[Elem]).
repeat(Elem,Num,[Elem|RT]):-
        Num>0,
        N1 is Num-1,
        repeat(Elem,N1,RT).
%% Predicado que añade 0 por la izquierda en la lista
%% para representar la multiplicacion 
lpad(XS,0,XS).
lpad(XS,N,RES):-
        N>0,
        repeat(0,N,S),
        append(S,XS,RES).
%% Predicado que multiplica un escalar por un polinomio
%% 3(2x+3x^2)=6x+9x^2  | mult(3,[0,2,3]) >> [0,6,9] 
mult(0,_,[]).
mult(_,[],[]).
mult(X,[HY|TY],[HS|TS]):-
        HS is X*HY,
        mult(X,TY,TS).
%% Predicado que multiplica un polinomio por una variable
%% 2x(3x^2+4x^3)=6x^3+8x^4 | mult(1,2,[0,0,3,4],S) >> [0,0,0,6,8]
mult(_,_,[],[]).
mult(_,0,_,[]).
mult(Grado,Coeficiente,Y,S):-
        mult(Coeficiente,Y,S1),
        lpad(S1,Grado,S).
%% Predicado que multiplica polinomios
%% (1+2x)(3x^2+4x^3)=3 x^2 + 10 x^3 + 8 x^4
%% multPolinomios([1,2],[0,0,3,4],S) >> [0,0,3,10,8]
multPolinomios(_,[],[]).
multPolinomios([],_,[]).
multPolinomios(X,Y,S):-
        multPolinomios(0,X,Y,S).
multPolinomios(_,[],_,[]).
multPolinomios(_,_,[],[]).
multPolinomios(N,[XH|XT],Y,S):-
        N1 is N+1,
        multPolinomios(N1,XT,Y,S1),
        mult(N,XH,Y,S2),
        suma(S1,S2,S).

derivada(X,S):-
        derivada(0,X,S).
derivada(_,[],[]).
derivada(0,[_|T],S):-
        derivada(1,T,S).
derivada(I,[XN|T],[SN|TS]):-
        I1 is I+1,
        derivada(I1,T,TS),
        SN is XN * I.

derivada(suma,X,Y,S):-
        derivada(X,D1),derivada(Y,D2),
        suma(D1,D2,S). 
derivada(mult,X,Y,S):-
        derivada(X,D1),derivada(Y,D2),
        multPolinomios(Y,D1,M1),
        multPolinomios(X,D2,M2),
        suma(M1,M2,S).


%% 4.2
%% Carta mas alta=valor carta
%% Pareja=30
%% Trio=60
%% Doble pareja=90
%% Full=120
%% Color=150
%% Poker=180
%% Escalera color=210
  
consecutivos([]).
consecutivos([_]).
consecutivos([[X|_],[Y|_]|T]):-
        Y is X+1,consecutivos(T).

agrupar(X,[],[[X]]).
agrupar([X,P1],[[[X,P2]|TX]|T],[[[X,P1],[X,P2]|TX]|T]):-!.
agrupar(X,[HS|T],[HS|TS]):-agrupar(X,T,TS).

agruparLista([],XS,XS).
agruparLista([H|T],XS,S):-
        agrupar(H,XS,S1),
        agruparLista(T,S1,S).

ocurrencias([],[]).
ocurrencias([[H|HT]|T],[[L,H]|ST]):-
        ocurrencias(T,ST),
        length([H|HT],L).

jugada(Cartas,S):-
        sort(Cartas,S1),
        agruparLista(S1,[],S2),
        ocurrencias(S2,S3),
        ((poker(S3,X),S is 180+X);
            (full(S3,[X,Y]),S is 120+X+Y); 
                (doblePareja(S3,[X,Y]),S is 90+X+Y);
                    (trio(S3,X),S is 60+X);
                        (pareja(S3,X),S is 30+X);
                            (color(Cartas,S));
                                last(S1,[S,_])).
                        
poker(XS,S):-member([4,[S|_]],XS).

full(XS,[X,Y]):-member([3,[X|_]],XS),member([2,[Y|_]],XS).

mismoPalo([[_,X]],X).
mismoPalo([[_,X]|T],X):-mismoPalo(T,X).

color(XS,S):-sort(XS,YS),mismoPalo(YS,_),
        (consecutivos(YS),last(YS,[X|_]),S is 210+X);
            S is 150.

doblePareja(XS,[X,Y]):-member([2,[X|_]],XS),member([2,[Y|_]],XS),Y\=X.

trio(XS,S):-member([3,[S|_]],XS).

pareja(XS,S):-member([2,[S|_]],XS).

jugadas([],[]).
jugadas([H|T],[[S|H]|TS]):-
        jugada(H,S),jugadas(T,TS).

mejor_jugada(JS,S):-jugadas(JS,S1),sort(S1,S2),last(S2,[_|S]).

%%4.3

arco(0,1).
arco(1,2).
arco(2,0).
arco(2,3).
arco(2,5).
arco(3,1).
arco(3,4).
arco(5,6).
arco(6,3).

camino(X,Y,S):-
        camino(X,Y,[],S).
camino(X,_,P,_):-member(X,P),!,fail.
camino(X,Y,P,[X|P]):-arco(X,Y),!.
camino(X,Y,P,S):-
        arco(X,N),
        camino(N,Y,[X|P],S).
