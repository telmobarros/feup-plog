:-include(library(random)).
%choose_move(+Difficulty, +ListOfMoves, +ListOfValues, -Xinitial, -Yinitial, -Xfinal, -Yfinal).
choose_move(Difficulty, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal):-
        %ESTE É O CASO QUE CORRE sempre se houver uma jogada de nivel 5 porque todos fazem essa jogada se for possivel
        max(ListOfValues,MaxValue),
        MaxValue == 5,
        once(getMoveWithValue(ListOfMoves, ListOfValues, MaxValue, Xinitial, Yinitial, Xfinal, Yfinal)).

choose_move(Difficulty, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal):-
        %se não houver uma jogada de nivel 5 vai sortear o numero depois em baixo esta uma
        %funcao que pensei que pode retornar o valor da jogaDA CONSOANTE O random que sair
        max(ListOfValues,MaxValue),
        MaxValue \== 5,
        once(getValue(Difficulty,Value,ListOfValues)),
        once(getMoveWithValue(ListOfMoves, ListOfValues, Value, Xinitial, Yinitial, Xfinal, Yfinal)).
            

getValue(1,Value,ListOfValues):-
        getValue(1,Value).

getValue(2,Value,ListOfValues):-
        getValue(2,Value).

getValue(3,Value,ListOfValues):-
        getValue(3,Value).


getValue(1, Value):-
        maybe(30/100),
        Value is  1.

getValue(1, Value):-
        maybe(30/100),
        Value is  2.

getValue(1, Value):-
        maybe(20/100),
        Value is  3.

getValue(1, Value):-
        maybe(20/100),
        Value is  4.


getValue(2, Value):-
        maybe(20/100),
        Value is  1.

getValue(2, Value):-
        maybe(20/100),
        Value is  2.

getValue(2, Value):-
        maybe(30/100),
        Value is  3.

getValue(2,Value):-
       maybe(30/100),
        Value is  4.


getValue(3, Value):-
        maybe(10/100),
        Value is  1.

getValue(3, Value):-
        maybe(10/100),
        Value is  2.

getValue(3, Value):-
        maybe(30/100),
        Value is  3.

getValue(3, Value):-
        maybe(50/100),
        Value is  4.


%sempre que a dificuldade for 4 independemente do random ele ia escolher o valor maximo possivel
getValue(4, Value, ListOfValues):-
        max(ListOfValues,V),
        Value is V.


%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOTAS %%%%%%%%%%%%%%%%%%%

%difficulty easy 1
%5 - sempre
%4 - 10%
%3 - 20%
%2 - 30%
%1 - 40%

%difficulty medium 2
%5 - sempre
%4 - 20%
%3 - 30%
%2 - 30%
%1 - 20%

%difficulty hard 3
%5 - sempre
%4 - 40%
%3 - 30%
%2 - 20%
%1 - 10%

%difficulty expert 4
%melhor valor