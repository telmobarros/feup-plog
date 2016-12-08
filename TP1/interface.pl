display_board([L1|Ls]):-
        nl,
        write('   1    2    3    4    5    6    7    8    9    10   11   12'), nl,        %imprime cabeçalho com letras das colunas
        write('-------------------------------------------------------------'), nl,     %imprime separador das linhas
        display_lines([L1|Ls], 1).

display_lines([L1|Ls], Nlines):- 
        display_line(L1), write('| '), write(Nlines), nl,
        write('-------------------------------------------------------------'), nl,     %imprime separador das linhas
        Nextlines is Nlines + 1,
        display_lines(Ls,Nextlines).

display_lines([], Nlines).

display_line([E|Es]):-
        write('|'),                                                                     %imprime separador de coluna
        translate(E,T),                                                                 %converte o número na representação da peça
        write(T),                                                                       %imprime a representação da peça
        display_line(Es).

display_line([]).


translate(0,'    ').
translate(-20,' 20P').
translate(-19,' 19P').
translate(-18,' 18P').
translate(-17,' 17P').
translate(-16,' 16P').
translate(-15,' 15P').
translate(-14,' 14P').
translate(-13,' 13P').
translate(-12,' 12P').
translate(-11,' 11P').
translate(-10,' 10P').
translate(-9,' 9P ').
translate(-8,' 8P ').
translate(-7,' 7P ').
translate(-6,' 6P ').
translate(-5,' 5P ').
translate(-4,' 4P ').
translate(-3,' 3P ').
translate(-2,' 2P ').
translate(-1,'  P ').
translate(20,' 20B').
translate(19,' 19B').
translate(18,' 18B').
translate(17,' 17B').
translate(16,' 16B').
translate(15,' 15B').
translate(14,' 14B').
translate(13,' 13B').
translate(12,' 12B').
translate(11,' 11B').
translate(10,' 10B').
translate(9,' 9B ').
translate(8,' 8B ').
translate(7,' 7B ').
translate(6,' 6B ').
translate(5,' 5B ').
translate(4,' 4B ').
translate(3,' 3B ').
translate(2,' 2B ').
translate(1,'  B ').

%Pedir ao utilizar a o modo de jogo, 1 -> Humano vs Humano, 2 -> Humado vs Computador, 3 -> Computador vs Computador
readGameMode(Mode) :-
        write('Game mode'), nl,
        write('1 -> Human vs Human'), nl,
        write('2 -> Human vs Computer'), nl,
        write('3 -> Computer vs Computer'), nl,
        write('Mode: '), read(Mode),
        Mode >= 1, Mode =< 3.


readComputerDifficulty(1, Difficulty).
readComputerDifficulty(Mode, Difficulty) :-
        Mode > 1,
        write('Computer Difficulty'), nl,
        write('1 -> Easy'), nl,
        write('2 -> Medium'), nl,
        write('3 -> Hard'), nl,
        write('4 -> Expert'), nl,
        write('Difficulty: '), read(Difficulty),
        Difficulty >= 1, Difficulty =< 4.

%Pedir ao utilizar a jogada a realizar, ou seja, posicao inicial da pec e posicao final
%X nome da coluna
%Y numero da linha
readMove(Xinitial, Yinitial, Xfinal, Yfinal) :-
        write('Piece to move:'), nl,
        write('Column->'), read(Xinitial), 
        write('Row->'), read(Yinitial), nl,
        write('Where to move:'), nl,
        write('Column->'), read(Xfinal),
        write('Row->'), read(Yfinal),nl.

waitTurn:-
        read(X).

display_msg_best_move(Player ,Board, NewBoard):-
        once(valid_moves(Board, Player, ListOfMoves)),
        once(value_moves(Board, Player, ListOfMoves, ListOfValues)),
        value(Board, NewBoard, Player, Value),
        max(ListOfValues, MaxValue),
        display_msg_best_moveAux(Value, MaxValue, ListOfMoves, ListOfValues).

display_msg_best_moveAux(Value, Value, ListOfMoves, ListOfValues):-
        write('The best move was choosen.'), nl.

display_msg_best_moveAux(Value, MaxValue, ListOfMoves, ListOfValues):-
        write('There was a better move (ex):'),nl,
        getMoveWithValue(ListOfMoves, ListOfValues, MaxValue, Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp),
        write('Xinitial: '), write(Xinitialcp),nl,
        write('Yinitial: '), write(Yinitialcp),nl,
        write('Xfinal: '), write(Xfinalcp),nl,
        write('Yfinal: '), write(Yfinalcp),nl.
                