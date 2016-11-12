:-include(library(random)).
%choose_move(+Difficulty, +ListOfMoves, +ListOfValues, -Xinitial, -Yinitial, -Xfinal, -Yfinal).
choose_move(Difficulty, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal):-
        %ESTE É O CASO QUE CORRE sempre se houver uma jogada de nivel 5 porque todos fazem essa jogada se for possivel
        write('ListofValues'),write(ListOfValues),nl,
        max(ListOfValues,MaxValue),
        write('sai do max MaxValue  '),write(MaxValue),nl,
        MaxValue == 5,
        write('vou crashar'),nl,
        getMoveWithValue(ListOfMoves, ListOfValues, Value, Xinitial, Yinitial, Xfinal, Yfinal),
        write('Xinitial'),write(Xinitial),nl,
        write('Yinitial'),write(Yinitial),nl,
        write('Xfinal'),write(Xfinal),nl,
        write('Yfinal'),write(Yfinal),nl.

choose_move(Difficulty, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal):-
        %se não houver uma jogada de nivel 5 vai sortear o numero depois em baixo esta uma
        %funcao que pensei que pode retornar o valor da jogaDA CONSOANTE O random que sair
        write('NÃO HAVIA MOVES TIPO 5 POR ISSO VOU ESCOLHER OUTRO'),nl,
        random(0, 100, Random),
        write('Random '),write(Random),nl,
        once(getValue(Difficulty, Random, Value)),
        getMoveWithValue(ListOfMoves, ListOfValues, Value, Xinitial, Yinitial, Xfinal, Yfinal),
        write('Xinitial'),write(Xinitial),nl,
        write('Yinitial'),write(Yinitial),nl,
        write('Xfinal'),write(Xfinal),nl,
        write('Yfinal'),write(Yfinal),nl.

getValue(1, Random, Value):-
        Random =< 40,
        Value is  1,
        write('Value1'),write(Value),nl.

getValue(1, Random, Value):-
        Random =< 70,
        Random > 40,
        Value is  2,
        write('Value1'),write(Value),nl.

getValue(1, Random, Value):-
        Random =< 90, 
        Random > 70,
        Value is  3,
        write('Value1'),write(Value),nl.

getValue(1, Random, Value):-
        Random > 90,
        Random =< 100,
        Value is  4,
        write('Value1'),write(Value),nl.





getValue(2, Random, Value):-
        Random =< 20,
        Value is  1,
        write('Value1'),write(Value),nl.

getValue(2, Random, Value):-
        Random =< 50,
        Random > 20,
        Value is  2,
        write('Value1'),write(Value),nl.

getValue(2, Random, Value):-
        Random =< 80, 
        Random > 50,
        Value is  3,
        write('Value1'),write(Value),nl.

getValue(2, Random, Value):-
        Random > 80,
        Random =< 100,
        Value is  4,
        write('Value1'),write(Value),nl.


getValue(3, Random, Value):-
        Random =< 10,
        Value is  1.

getValue(3, Random, Value):-
        Random =< 30, 
        Random > 10,
        Value is  2.
getValue(3, Random, Value):-
        Random =< 60, 
        Random > 30,
        Value is  3.
getValue(3, Random, Value):-
        Random =< 100,
        Random > 60,
        Value is  4.


%sempre que a dificuldade for 4 independemente do random ele ia escolher o valor maximo possivel
getValue(4, Random, Value):-
        max(ListOfValues,V),
        Value is V.


%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOTAS %%%%%%%%%%%%%%%%%%%


getMoveWithValue([L1|Ls], [V1|Vs], Value, Xinitial, Yinitial, Xfinal, Yfinal):-
        write('hmmmmmm1111'),nl,
        V1 == Value,
        write('found'),nl,
        write('L1'),nl, write(L1),nl,
        getCoordsFromMove(L1, Xinitial,Yinitial,Xfinal,Yfinal,0),
        write('Xinitial 2  '),write(Xinitial),nl,
        write('Yinitial 2  '),write(Yinitial),nl,
        write('Xfinal 2  '),write(Xfinal),nl,
        write('Yfinal 2  '),write(Yfinal),nl.

getMoveWithValue([L1|Ls], [V1|Vs], Value, Xinitial, Yinitial, Xfinal, Yfinal):-
        write('recursivo'),nl,
        getMoveWithValue(Ls, Vs, Value, Xinitial, Yinitial, Xfinal, Yfinal).


/*      
   max(ListOfValues, MaxValue):-
   once(maxAux(ListOfValues, 0, MaxValue)).

   maxAux([V1|Vs], MaxValueTmp, MaxValue):-
   V1 > MaxValueTmp,
   maxAux(Vs, V1, MaxValue).
   maxAux([V1|Vs], MaxValueTmp, MaxValue):-
   maxAux(Vs, MaxValueTmp, MaxValue).


   maxAux([], MaxValueTmp, MaxValueTmp).

*/
%pensei em fazer uma funcao getMovesWithValue(+ListOfMoves, +ListOfValues, +Value, -SelectedMoves) 
%que vai buscar os moves com um certo value
%ou entao logo uma funcao que faz basicamente a anterior que falei 
%e depois faz logo um random dentro dos moves selecionados 
%e retorna logo um move com um certo value ---> 
%getMoveWithValue(ListOfMoves, ListOfValues, Value, Xinitial, Yinitial, Xfinal, Yfinal). 
%FOI ESTA QUE "CHAMEI" LÁ EM CIMA

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
%para esta pensei em fazer uma funcao max que retorna o maior valor da lista de values
%depois era só chamar a funcao getMovesWithValue que falei em cima, acho que assim deve funcionar mas se vires outra ideia melhor diz
