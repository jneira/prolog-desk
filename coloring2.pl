mapa(1,[(1,[2]),(2,[1])]).
mapa(2,[(1,[2,3,4]),(2,[1,4,5]),(3,[1,4,6]),
        (4,[1,2,3,5,6,7]),(5,[2,4,7]),
        (6,[3,4,7]),(7,[4,5,6])]).
mapa(3,[(1,[2,5,11]),(2,[1,3,5,11]),(3,[2,4,6,11]),
        (4,[3,6,11]),(5,[1,2,7,11]),(6,[3,4,8,11]),
        (7,[5,9,11]),(8,[6,10,11]),(9,[7,10,11]),
        (10,[9,8,11]),(11,[1,2,3,4,5,6,7,8,9,10])]).


colorearMapa(_,[],[]).
colorearMapa(IdMapa,Colores,Resultado):-
        mapa(IdMapa,Paises),
        colorearPaises(Paises,Colores,[[]],Resultado).

colorearPaises([],_,Previos,Previos).
colorearPaises([Pais|RestoPaises],Colores,Previos,Resultado):-
        colorearPais(Pais,Colores,Previos,Actuales),!,
        colorearPaises(RestoPaises,Colores,Actuales,Resultado).

colorearPais(_,_,[],[]).
colorearPais(Pais,Colores,[Previo|Previos],Resultado):-
        coloresPosibles(Pais,Colores,Previo,Posibles),
        colorearPais(Pais,Posibles,ConColores),!,
        annadirPais(ConColores,Previo,Actual),
        colorearPais(Pais,Colores,Previos,Resto),
        append(Actual,Resto,Resultado).


colorearPais(_,[],[]).
colorearPais((Id,V),[Color|TCS],[(Id,Color)|TR]):-
        colorearPais((Id,V),TCS,TR).

annadirPais([],_,[]).
annadirPais([ConColor|ConColores],Previo,[[ConColor|Previo]|Resto]):-
        annadirPais(ConColores,Previo,Resto).

coloresPosibles(_,[],_,[]).
coloresPosibles(_,Colores,[],Colores).
coloresPosibles((Id,Vecinos),Colores,
        [(IdPaisPrevio,ColorPaisPrevio)|RestoPaises],
        Resultado):-
        memberchk(IdPaisPrevio,Vecinos),
        select(ColorPaisPrevio,Colores,Filtrados),
        coloresPosibles((Id,Vecinos),Filtrados,RestoPaises,Resultado).
coloresPosibles(Pais,Colores,[_|RestoPaises],Resultado):-
        coloresPosibles(Pais,Colores,RestoPaises,Resultado).

% ?- time(colorearMapa(3,[azul,rojo,verde,amarillo],X)).
%   3,172,531 inferences, 0.938 CPU in 0.937 seconds (100% CPU, 3384033 Lips)
% ?- |time(colorearMapa(3,[azul,rojo,verde,amarillo,negro],X)).
%   78,529,961 inferences, 26.688 CPU in 26.966 seconds (99% CPU, 2942575 Lips)

