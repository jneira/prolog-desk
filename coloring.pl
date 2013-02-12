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
colorearPaises([(Id,Vecinos)|RestoPaises],
           Colores,Previos,Resultado):-
    colorearPais(Id,Colores,Opciones),
    annadirOpcionesPaisColoreado(Opciones,Previos,Vecinos,Actuales),
    append(Actuales,Aux),
    colorearPaises(RestoPaises,Colores,Aux,Resultado).


colorearPais(_,[],[]).
colorearPais(Id,[Color|TCS],[(Id,Color)|TR]):-
        colorearPais(Id,TCS,TR).

annadirOpcionesPaisColoreado([],_,_,[]).
annadirOpcionesPaisColoreado([Opcion|RestoOpciones],
                Previos,Vecinos,[Actuales|Resultado]):-
    annadirPaisColoreado(Opcion,Previos,Vecinos,Actuales),
    annadirOpcionesPaisColoreado(RestoOpciones,Previos,Vecinos,Resultado).

annadirPaisColoreado(Opcion,[[]],_,[[Opcion]]).
annadirPaisColoreado(_,[],_,[]).
annadirPaisColoreado(Opcion,[Previo|RestoPrevios],
            Vecinos,[[Opcion|Previo]|Resto]):-
    compatible(Opcion,Previo,Vecinos),!,
    annadirPaisColoreado(Opcion,RestoPrevios,Vecinos,Resto).
annadirPaisColoreado(Opcion,[_|RestoPrevios],Vecinos,Resultado):-
    annadirPaisColoreado(Opcion,RestoPrevios,Vecinos,Resultado).

compatible(_,_,[]).
compatible(_,[],_).
compatible((_,Color),[(IdPrevio,Color)|_],Vecinos):-
    member(IdPrevio,Vecinos),!,fail.
compatible(Opcion,[_|Previos],Vecinos):-
    compatible(Opcion,Previos,Vecinos).
