pre(v,[]). 
pre(h(X),[X]). 
pre(n(X,I,D),L) :- 
        append([X|L1],L2,L), 
        pre(I,L1), 
        pre(D,L2). 

in(v,[]). 
in(h(X),[X]). 
in(n(X,I,D),L) :- 
        append(L1,[X|L2],L), 
        in(I,L1), 
        in(D,L2). 

post(v,[]). 
post(h(X),[X]). 
post(n(X,I,D),L) :- 
        post(I,L1), 
        post(D,L2), 
        append(L1,L2,L3), 
        append(L3,[X],L). 

% Ejemplo; 
%    ?- pre(A,[2,7,3,6,5,11,8,9,4]), in(A,[3,7,5,6,11,2,8,9,4]), post(A,L). 
%    A = n(2,n(7,h(3),n(6,h(5),h(11))),n(8,v,n(9,v,h(4)))), 
%    L = [3,5,11,6,7,4,9,8,2] 
