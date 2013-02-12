recorrer(Mapa,Direcciones,Destino):-
        string_to_list(Direcciones,ListaDirs),
        recorrer_todo(Mapa,ListaDirs,[1,1],Destino).

recorrer_todo(_,[],Final,Final):-!.
recorrer_todo(Mapa,[Dir|T],Origen,Final):-
        ir_hacia(Mapa,Dir,Origen,Destino),
        recorrer_todo(Mapa,T,Destino,Final).

ir_hacia(Mapa,Direccion,Origen,Destino):-
        mover(Direccion,Origen,Destino),
        pos_valida(Mapa,Destino).

mover(Dir,[X,Y],[DX,DY]):-
        Dir=69,DX is X,DY is Y+1,!;
        Dir=83,DX is X+1,DY is Y,!;
        Dir=79,DX is X,DY is Y-1,!;
        Dir=78,DX is X-1,DY is Y,!;
        (Dir=91;Dir=93),DX is X,DY is Y,!;
        fail.

pos_valida(Mapa,[X,Y]):-
        nth1(X,Mapa,Fila),
        nth1(Y,Fila,Celda),
        Celda is 1.

%% recorrer([[1]],"",Dest).
%% Dest = [1, 1].

%% recorrer([[1,1,1,0]],"",Dest).
%% Dest = [1, 1].

%% recorrer([[1,1,1,0]],"EE",Dest).
%% Dest = [1, 3].

%% recorrer([[1,1,1,0]],"EEE",Dest).
%% false.

%% recorrer([[1,1,1,1]],"EEEEEE",Dest).
%% false.

%% recorrer([[1,0,1],[1,1,1]],"SEEN",Dest).
%% Dest = [1, 3].

%% recorrer([[1,0,1],[1,1,1]],"SEENS",Dest).
%% Dest = [2, 3].

%% recorrer([[1,1,0],[1,1,0],[0,1,0]],"SENO",Dest).
%% Dest = [1, 1].

%% recorrer([[1,1,0],[1,1,0],[0,1,0]],"SENO",[1,1]).
%% true.
