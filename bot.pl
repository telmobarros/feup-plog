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
       

choose_move(4, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal):-
        %ESTE É O CASO QUE CORRE sempre se houver uma jogada de nivel 5 porque todos fazem essa jogada se for possivel
        max(ListOfValues,MaxValue),
        once(getMoveWithValue(ListOfMoves, ListOfValues, MaxValue, Xinitial, Yinitial, Xfinal, Yfinal)).

            

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


getMoveWithValue([L1|Ls], [V1|Vs], Value, Xinitial, Yinitial, Xfinal, Yfinal):-
        V1 == Value,
        write(L1),nl,
        getCoordsFromMove(L1, Xinitial,Yinitial,Xfinal,Yfinal,0).

getMoveWithValue([L1|Ls], [V1|Vs], Value, Xinitial, Yinitial, Xfinal, Yfinal):-
        getMoveWithValue(Ls, Vs, Value, Xinitial, Yinitial, Xfinal, Yfinal).

getMoveWithValue([], [], Value, Xinitial, Yinitial, Xfinal, Yfinal):-
        write('done'),nl.

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
