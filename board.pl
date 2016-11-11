%:-include(library(random)).


/**board_initialized(Board):-
        Board=[[0,0,0,0,0,-20,0,0,0,0,0,0],          %estado inicial
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,20,0,0,0,0,0]].*/

/**board_initialized(Board):-
        Board=[[0,0,0,-1,0,0,0,0,0,-1,0,-1],            %estado intermédio
               [0,-1,0,-1,-1,0,0,0,-1,0,0,-6],
               [0,-1,0,0,0,0,0,0,0,0,-1,0],
               [0,0,0,0,1,0,0,0,1,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,1,0,-1,0,0,0,0,0,1,0],
               [9,0,0,0,0,0,0,0,0,0,0,1],
               [0,1,0,0,0,0,-1,0,0,0,0,0]].*/

board_initialized(Board):-
     Board=[[0,0,0,0,0,0,0,0,0,0,0,0],           %estado final
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,-1,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,2,0,0,0],
           [0,0,0,0,0,-2,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0,0,0,0]].



display_board([L1|Ls]):-
        write('  1    2    3    4    5    6    7    8    9    10    11    12'), nl,        %imprime cabeçalho com letras das colunas
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

/**writeabs(X) :- X < 0 ->
               Y is -X,
               write(' '),write(Y), write('P ');   %peça preta
               X > 0 ->
               write(' '),write(X), write('B ');           %peça branca
               write('    ').   %espaço vazio*/

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
        write('2 -> Hard'), nl,
        write('Difficulty: '), read(Difficulty),
        Difficulty >= 1, Difficulty =< 2.


initializeGame(Mode, Board, Player1Type, Player2Type, CurPlayer, CurPlayerType) :-
        board_initialized(Board),
        intializePlayerTypes(Mode, Player1Type, Player2Type),
        CurPlayer is 1,
        CurPlayerType is Player1Type.

%0 -> humano, 1-> computador
intializePlayerTypes(1, Player1Type, Player2Type) :-
        Player1Type is 0,
        Player2Type is 0.

intializePlayerTypes(2, Player1Type, Player2Type) :-
        Player1Type is 0,
        Player2Type is 1.

intializePlayerTypes(3, Player1Type, Player2Type) :-
        Player1Type is 1,
        Player2Type is 1.


switchPlayer(1, NewPlayer, NewPlayerType, Player1Type, Player2Type) :-
        NewPlayer is 2,
        NewPlayerType is Player2Type.

switchPlayer(2, NewPlayer, NewPlayerType, Player1Type, Player2Type) :-
        NewPlayer is 1,
        NewPlayerType is Player1Type.



%Pedir ao utilizar a jogada a realizar, ou seja, posicao inicial da pec e posicao final
%X nome da coluna
%Y numero da linha
readMove(Xinitial, Yinitial, Xfinal, Yfinal) :-
        write('Piece to move:'), nl,
        write('Coluna->'), read(Xinitial), 
        write('Linha->'), read(Yinitial), nl,
        write('Where to move:'), nl,
        write('Coluna->'), read(Xfinal),
        write('Linha->'), read(Yfinal), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Retorna a peça que se encontra na posicao X, Y de um tabuleiro
getBoardPos([L1|Ls],X, Y, PiecePlayer):- getBoardPos([L1|Ls],X, Y, 1, PiecePlayer).

getBoardPos([L1|Ls],X, Y, Yprox,PiecePlayer):-
        Yprox < Y,
        Var is Yprox + 1,
        getBoardPos(Ls, X, Y, Var, PiecePlayer).

getBoardPos([L1|Ls], X, Y, Y,PiecePlayer):- getBoardLinePos(L1, X, 1,PiecePlayer).


%Retorna a peça que se encontra na posicao X de uma linha
getBoardLinePos([L1|Ls], X,PiecePlayer):- getBoardLinePos([L1|Ls], X, 1,PiecePlayer).

getBoardLinePos([L1|Ls], X, Xprox,PiecePlayer):-
        Xprox < X,
        Var is Xprox + 1,
        getBoardLinePos(Ls, X, Var,PiecePlayer).%funcao de pesquisa da peca na linha

getBoardLinePos([L1|Ls], X, X,PiecePlayer):- PiecePlayer is L1.


%Coloca a peça PiecePlayer na posição X,Y do tabuleiro
%setBoardPos([L1|Ls],X, Y, PiecePlayer,[L1|NewLs]):- setBoardPos([L1|Ls],X, Y, 1,PiecePlayer,[L1|NewLs]).

setBoardPos([L1|Ls],X, Y, Yprox,PiecePlayer,[L1|NewLs]):-
        Yprox < Y,
        Var is Yprox + 1,
        write('setBoardPos'),nl,
        setBoardPos(Ls, X, Y, Var, PiecePlayer, NewLs).

setBoardPos([L1|Ls], X, Y, Y,PiecePlayer ,[NewL1|Ls]):-
        setBoardLinePos(L1, X, 1, PiecePlayer , NewL1).


%Coloca a peça PiecePlayer na posição X de uma linha
%setBoardLinePos([L1|Ls], X, PiecePlayer, [L1|NewLs]):- setBoardLinePos([L1|Ls], X, 1, PiecePlayer, [L1|NewLs]).

setBoardLinePos([L1|Ls], X, Xprox,PiecePlayer, [L1|NewLs]):-
        Xprox < X,
        Var is Xprox + 1,
        setBoardLinePos(Ls, X, Var,PiecePlayer, NewLs).


/*setBoardLinePos([L1|Ls], 1, 1,PiecePlayer, [[]|NewLine]):-
                           write(PiecePlayer),nl,
                           write(Ls),nl,
                           append([PiecePlayer],Ls,NewLine),
                           write(NewLine),nl,
                           write('encontrei, vou trocar'), nl.*/

setBoardLinePos([_|Ls], X, X,PiecePlayer, [PiecePlayer|Ls]):-
        % X > 1,
        write(PiecePlayer),nl,
        write(Ls),nl,
        write('encontrei, vou trocar'), nl.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%verfica se a posicao se se encontra dentro do tabuleiro
legal_pos(X,Y):-
        X >= 1, X =< 12,
        Y >= 1, Y =< 12.

%verifica se o movimento tem uma direção válida (horizontal, vertical ou diagonal)
legal_orientation(Xinitial,Yinitial, Xinitial,Yfinal).

legal_orientation(Xinitial,Yinitial, Xfinal,Yinitial).

legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal):-
        DeltaX is Xfinal - Xinitial,
        DeltaY is Yfinal - Yinitial,
        DeltaX == DeltaY.

legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal):-
        DeltaX is Xfinal - Xinitial,
        DeltaY is -(Yfinal - Yinitial),
        DeltaX == DeltaY.

%verifica se as casas entre a posicao inicial e final estão vazias
%empty_cells(+Board, +Xinitial, +Yinitial, +Xfinal, +Yfinal)
empty_cells(Board, Xinitial, Yinitial, Xinitial, Yfinal):- %vertical para baixo
        Yfinal > Yinitial,
        Yprox is Yinitial + 1,
        (Yprox < Yfinal ->
         getBoardPos(Board,Xinitial,Yprox,Piece),
         Piece == 0,
         empty_cells(Board, Xinitial, Yprox, Xinitial, Yfinal)
        ;empty_cells(Board, Xinitial, Yprox, Xinitial, Yfinal)).

empty_cells(Board, Xinitial, Yinitial, Xinitial, Yfinal):- %vertical para cima
        Yfinal < Yinitial,
        Yprox is Yinitial - 1,
        (Yprox > Yfinal ->
         getBoardPos(Board,Xinitial,Yprox,Piece),
         Piece == 0,
         empty_cells(Board, Xinitial, Yprox, Xinitial, Yfinal)
        ;empty_cells(Board, Xinitial, Yprox, Xinitial, Yfinal)).

empty_cells(Board, Xinitial, Yinitial, Xfinal, Yinitial):- %horizontal para a direita
        Xfinal > Xinitial,
        Xprox is Xinitial + 1,
        (Xprox < Xfinal ->
         getBoardPos(Board,Xprox,Yinitial,Piece),
         Piece == 0,
         empty_cells(Board, Xprox, Yinitial, Xfinal, Yinitial)
        ;empty_cells(Board, Xprox, Yinitial, Xfinal, Yinitial)).

empty_cells(Board, Xinitial, Yinitial, Xfinal, Yinitial):- %horizontal para a esquerda
        Xfinal < Xinitial,
        Xprox is Xinitial - 1,
        (Xprox > Xfinal ->
         getBoardPos(Board,Xprox,Yinitial,Piece),
         Piece == 0,
         empty_cells(Board, Xprox, Yinitial, Xfinal, Yinitial)
        ;empty_cells(Board, Xprox, Yinitial, Xfinal, Yinitial)).

empty_cells(Board, Xinitial, Yinitial, Xfinal, Yfinal):- %diagonal para baixo e para a direita
        Xfinal > Xinitial,
        Yfinal > Yinitial,
        Xprox is Xinitial + 1,
        Yprox is Yinitial + 1,
        (Xprox < Xfinal ->
         getBoardPos(Board,Xprox,Yprox,Piece),
         Piece == 0,
         empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)
        ;empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)).

empty_cells(Board, Xinitial, Yinitial, Xfinal, Yfinal):- %diagonal para baixo e para a esquerda
        Xfinal < Xinitial,
        Yfinal > Yinitial,
        Xprox is Xinitial - 1,
        Yprox is Yinitial + 1,
        (Xprox > Xfinal ->
         getBoardPos(Board,Xprox,Yprox,Piece),
         Piece == 0,
         empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)
        ;empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)).

empty_cells(Board, Xinitial, Yinitial, Xfinal, Yfinal):- %diagonal para cima e para a direita
        Xfinal > Xinitial,
        Yfinal < Yinitial,
        Xprox is Xinitial + 1,
        Yprox is Yinitial - 1,
        (Xprox < Xfinal ->
         getBoardPos(Board,Xprox,Yprox,Piece),
         Piece == 0,
         empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)
        ;empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)).

empty_cells(Board, Xinitial, Yinitial, Xfinal, Yfinal):- %diagonal para cima e para a esquerda
        Xfinal < Xinitial,
        Yfinal < Yinitial,
        Xprox is Xinitial - 1,
        Yprox is Yinitial - 1,
        (Xprox > Xfinal ->
         getBoardPos(Board,Xprox,Yprox,Piece),
         Piece == 0,
         empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)
        ;empty_cells(Board, Xprox, Yprox, Xfinal, Yfinal)).

empty_cells(Board, X, Y, X, Y).


%verifica se os parametros introduzidos como posicoes iniciais e finais nao saem do tabuleiro
%verifica se a posicao inicial corresponde a uma peça do jogador
%verifica se a posicao final corresponde a uma peça do adversário ou uma casa vazia
%verifica se o movimento tem uma direção válida (horizontal, vertical ou diagonal)
%verifica se as casas entre a posicao inicial e a posicao final estao livres
%legal_move(+Player, +Board, +Xinitial, +Yinitial, +Xfinal, -PieceInitial, -PieceFinal)
legal_move(1, Board, Xinitial, Yinitial, Xfinal,Yfinal):-
        legal_pos(Xinitial,Yinitial), legal_pos(Xfinal,Yfinal), legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal),
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        PieceInitial > 2,
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        PieceFinal =< 0,
        empty_cells(Board,Xinitial, Yinitial, Xfinal, Yfinal).
legal_move(1, Board, Xinitial, Yinitial, Xfinal,Yfinal):-
        legal_pos(Xinitial,Yinitial), legal_pos(Xfinal,Yfinal), legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal),
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        PieceInitial == 2,
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        PieceFinal < 0,
        empty_cells(Board,Xinitial, Yinitial, Xfinal, Yfinal).

%move para o baby do player 1
legal_move(1, Board, Xinitial, Yinitial, Xfinal,Yfinal):-
        legal_pos(Xinitial,Yinitial), legal_pos(Xfinal,Yfinal), legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal),
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        PieceInitial == 1,
        queen_aprox(Board, 1, Xfinal, Yfinal, Xinitial, Yinitial),
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        PieceFinal =< 0,
        empty_cells(Board,Xinitial, Yinitial, Xfinal, Yfinal).

legal_move(2, Board, Xinitial, Yinitial, Xfinal,Yfinal):-
        legal_pos(Xinitial,Yinitial), legal_pos(Xfinal,Yfinal), legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal),
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        PieceInitial < -2,
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        PieceFinal >= 0,
        empty_cells(Board,Xinitial, Yinitial, Xfinal, Yfinal).

legal_move(2, Board, Xinitial, Yinitial, Xfinal,Yfinal):-
        legal_pos(Xinitial,Yinitial), legal_pos(Xfinal,Yfinal), legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal),
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        PieceInitial == -2,
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        PieceFinal > 0,
        empty_cells(Board,Xinitial, Yinitial, Xfinal, Yfinal).

%move para o baby do player 2
legal_move(2, Board, Xinitial, Yinitial, Xfinal,Yfinal):-
        legal_pos(Xinitial,Yinitial), legal_pos(Xfinal,Yfinal), legal_orientation(Xinitial,Yinitial, Xfinal,Yfinal),
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        PieceInitial == -1,
        write('vou ver os moves para o baby'),nl,
        queen_aprox(Board, 2, Xfinal, Yfinal, Xinitial, Yinitial),
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        PieceFinal >= 0,
        empty_cells(Board,Xinitial, Yinitial, Xfinal, Yfinal).

%move a peça da posição inicial para a final
%move(+Player, +Board, +Xinitial, +Yinitial, +Xfinal, +Yfinal, -NewBoard)
move(Player, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard):-
        getBoardPos(Board, Xinitial, Yinitial, PieceInitial),
        getBoardPos(Board, Xfinal, Yfinal, PieceFinal),
        move(Player, Board, Xinitial, Yinitial, Xfinal, Yfinal, PieceInitial, PieceFinal, NewBoard).


move(1, Board, Xinitial, Yinitial, Xfinal, Yfinal, PieceInitial, PieceFinal, NewBoard):-
	PieceInitial >=2,
	PieceFinal < 0,
	setBoardPos(Board, Xfinal, Yfinal, 1, PieceInitial, Board1),
	setBoardPos(Board1, Xinitial, Yinitial, 1, 0, NewBoard).

move(1, Board, Xinitial, Yinitial, Xfinal, Yfinal, PieceInitial, 0, NewBoard):-
	PieceInitial > 2,
        NewPieceInitial is PieceInitial - 1,
	setBoardPos(Board, Xfinal, Yfinal, 1, NewPieceInitial, Board1),
	setBoardPos(Board1, Xinitial, Yinitial, 1, 1, NewBoard).

move(1, Board, Xinitial, Yinitial, Xfinal, Yfinal, 1, PieceFinal,NewBoard):-
	PieceFinal < 0,
	setBoardPos(Board, Xfinal, Yfinal, 1, 1, Board1),
	setBoardPos(Board1, Xinitial, Yinitial, 1, 0, NewBoard).


%movimento do baby quando nao come nenhuma peca
move(1, Board, Xinitial, Yinitial, Xfinal, Yfinal, 1, 0, NewBoard):-
	setBoardPos(Board, Xfinal, Yfinal, 1, 1, Board1),
	setBoardPos(Board1, Xinitial, Yinitial, 1, 0, NewBoard).


move(2, Board, Xinitial, Yinitial, Xfinal, Yfinal, PieceInitial, PieceFinal, NewBoard):-
        PieceInitial =< -2,
        PieceFinal > 0,
        setBoardPos(Board, Xfinal, Yfinal, 1, PieceInitial, Board1),
        setBoardPos(Board1, Xinitial, Yinitial, 1, 0, NewBoard).

move(2, Board, Xinitial, Yinitial, Xfinal, Yfinal, PieceInitial, 0, NewBoard):-
        PieceInitial < -2,
        NewPieceInitial is PieceInitial + 1,
        setBoardPos(Board, Xfinal, Yfinal, 1,NewPieceInitial, Board1),
        setBoardPos(Board1, Xinitial, Yinitial, 1,-1, NewBoard).

move(2, Board, Xinitial, Yinitial, Xfinal, Yfinal, -1, PieceFinal,NewBoard):-
        PieceFinal > 0,
        setBoardPos(Board, Xfinal, Yfinal, 1,-1, Board1),
        setBoardPos(Board1, Xinitial, Yinitial, 1, 0, NewBoard).

move(2, Board, Xinitial, Yinitial, Xfinal, Yfinal, -1, 0, NewBoard):-
        setBoardPos(Board, Xfinal, Yfinal, 1,-1, Board1),
        setBoardPos(Board1, Xinitial, Yinitial, 1, 0, NewBoard).


%verifica se a rainha se movimenta para uma posicao onde se encontra um baby ou rainha da equipa adversaria
%legal_queen_move(Xinitial,Yinitial,Xfinal,Yfinal).

%verfifca se as posicoes final sao posicoes validas em relacao a posicao inicial e guarda a nova posicao ou whatever
%diagonal_move(Xinitial, Yinitial, Xfinal,Yfinal).

%guarda as novas posicoes apos fazer o movimento horizontal da peca
%horizontal_move(Xinitial, Yinitial, Xfinal,Yfinal).

%guarda as novas posicoes apos fazer o movimento vertical da peca
%vertical_move(Xinitial, Yinitial, Xfinal,Yfinal).

%pesquisa posicao rainha e valor
getQueenPos(Player, [L1|Ls], X, Y, Value):-
        getQueenPosAux(Player, [L1|Ls], 1, X, Y, Value).

getQueenPosAux(Player, [L1|Ls], Yprox, X, Y, Value):-
        getQueenLinePosAux(Player,L1, 1, Yprox, X, Y, Value),
        Var is Yprox + 1,
        getQueenPosAux(Player, Ls, Var, X, Y, Value).


getQueenPosAux(Player, [], Yprox, X, Y, Value):-
        nonvar(Value).
%:- write('acabou tudo').

getQueenLinePosAux(1, [L1|Ls], Xprox, Yprox, X, Y, Value):-
        L1 < 2,
        Var is Xprox + 1,
        getQueenLinePosAux(1, Ls, Var, Yprox, X, Y, Value).

getQueenLinePosAux(2, [L1|Ls], Xprox, Yprox, X, Y, Value):-
        L1 > -2,
        Var is Xprox + 1,
        getQueenLinePosAux(2, Ls, Var, Yprox, X, Y, Value).

getQueenLinePosAux(1, [L1|Ls], Xprox, Yprox, X, Y, Value):-
        L1 >= 2,
        Value is L1,
        X is Xprox,
        Y is Yprox.

getQueenLinePosAux(2, [L1|Ls], Xprox, Yprox, X, Y, Value):-
        L1 =< -2,
        Value is L1,
        X is Xprox,
        Y is Yprox.

getQueenLinePosAux(Player, [], Xprox, Yprox, X, Y, Value).        %:- write(X),write('acabou a linha').

/*getQueenPosAux(Player, [L1|Ls], Yprox, X, Y, Value):-
                         X == _,
                         write(X),nl,
                         getQueenLinePosAux(Player,L1, 1, Yprox, X, Y, Value).

                         getQueenPosAux(Player, [L1|Ls], 13, X, Y, Value).

                         getQueenLinePosAux(Player, [L1|Ls], Xprox, Yprox, X, Y, Value):-
                         L1 >= -1,
                         L1 =< 1,
                         Var is Xprox + 1,
                         getQueenLinePosAux(Player, Ls, Var, Yprox, X, Y, Value).

                         getQueenLinePosAux(1, [L1|Ls], Xprox, Yprox, X, Y, Value):-
                         L1 >= 2,
                         Value is L1,
                         X is Xprox,
                         Y is Yprox.

                         getQueenLinePosAux(2, [L1|Ls], Xprox, Yprox, X, Y, Value):-
                         L1 =< -2,
                         Value is L1,
                         X is Xprox,
                         Y is Yprox.

                         getQueenLinePosAux(Player, [L1|Ls], 13, Yprox, X, Y, Value):-
                         Var is Yprox+1,
                         getQueenPosAux(Player, [L1|Ls], Var, X, Y, Value).*/

%verifica se a peca ao movimentar-se se se aproxima da rainha
queen_aprox(Board, 1, Xfinal, Yfinal, Xinitial, Yinitial):-
          write('hmmmmm'),nl,
        getQueenPos(2, Board, Xrainha, Yrainha, Value),
        distancia(Xinitial,Yinitial,Xrainha,Yrainha,Distinitial),
        distancia(Xfinal,Yfinal,Xrainha,Yrainha,Distfinal),
        Distfinal < Distinitial.

queen_aprox(Board, 2, Xfinal, Yfinal, Xinitial, Yinitial):-
        write('hmmmmm'),nl,
        getQueenPos(1, Board, Xrainha, Yrainha, Value),
        write('x'),write(Xrainha),nl,
        distancia(Xinitial,Yinitial,Xrainha,Yrainha,Distinitial),
        distancia(Xfinal,Yfinal,Xrainha,Yrainha,Distfinal),
        Distfinal < Distinitial.



distancia(X,Y,Xrainha,Yrainha,Dist):-
        Xvar is Xrainha - X,
        Yvar is Yrainha - Y,
        Subx is Xvar * Xvar,
        Suby is Yvar * Yvar,
        Distint is Subx + Suby,
        Dist is sqrt(Distint).

valid_moves([L1|Ls], Player, ListOfMoves):-
        valid_movesAux([L1|Ls], Player, [], 1, 1,ListOfMoves),
        write(ListOfMoves),nl.


valid_movesAux([L1|Ls], 1, ListOfMovesTmp, X, Y, ListOfMoves):-
        X < 13,
        Y < 13,
        getBoardPos([L1|Ls],X, Y, PiecePlayer),
        (PiecePlayer >= 1 ->
         valid_moveAux([L1|Ls], 1, [], X, Y, 1, 1, ListOfMovesTmp1),
         append(ListOfMovesTmp,ListOfMovesTmp1,NewListOfMovesTmp),
         Xprox is X + 1,
         valid_movesAux([L1|Ls], 1, NewListOfMovesTmp, Xprox, Y, ListOfMoves)
        ;Xprox is X + 1,
         valid_movesAux([L1|Ls], 1, ListOfMovesTmp, Xprox, Y, ListOfMoves)).

valid_movesAux([L1|Ls], 2, ListOfMovesTmp, X, Y, ListOfMoves):-
        X < 13,
        Y < 13,
        getBoardPos([L1|Ls],X, Y, PiecePlayer),
        (PiecePlayer =< -1 ->
         valid_moveAux([L1|Ls], 2, [], X, Y, 1, 1, ListOfMovesTmp1),
         append(ListOfMovesTmp,ListOfMovesTmp1,NewListOfMovesTmp),
         Xprox is X + 1,
         valid_movesAux([L1|Ls], 2, NewListOfMovesTmp, Xprox, Y, ListOfMoves)
        ;Xprox is X + 1,
         valid_movesAux([L1|Ls], 2, ListOfMovesTmp, Xprox, Y, ListOfMoves)).

valid_movesAux([L1|Ls], Player, ListOfMovesTmp, 13, Y, ListOfMoves):-
        Y < 13,
        Yprox is Y + 1,
        valid_movesAux([L1|Ls], Player, ListOfMovesTmp, 1, Yprox, ListOfMoves).

valid_movesAux([L1|Ls], Player, ListOfMovesTmp, 1, 13, ListOfMoves):- append([],ListOfMovesTmp,ListOfMoves).

valid_moveAux([L1|Ls], Player, ListOfMovesTmp, Xinitial, Yinitial, Xfinal, Yfinal, ListOfMoves):-
        Xfinal < 13,
        Yfinal < 13,
        (legal_move(Player, [L1|Ls], Xinitial, Yinitial, Xfinal,Yfinal) ->
         append(ListOfMovesTmp,[[Xinitial,Yinitial,Xfinal,Yfinal]],NewListOfMovesTmp),
         Xprox is Xfinal + 1,
         valid_moveAux([L1|Ls], Player, NewListOfMovesTmp, Xinitial, Yinitial, Xprox, Yfinal, ListOfMoves)
        ;Xprox is Xfinal + 1,
         valid_moveAux([L1|Ls], Player, ListOfMovesTmp, Xinitial, Yinitial, Xprox, Yfinal, ListOfMoves)).

valid_moveAux([L1|Ls], Player, ListOfMovesTmp, Xinitial, Yinitial, 13, Yfinal, ListOfMoves):-
        Yfinal < 13,
        Yprox is Yfinal + 1,
        valid_moveAux([L1|Ls], Player, ListOfMovesTmp, Xinitial, Yinitial, 1, Yprox, ListOfMoves).

valid_moveAux([L1|Ls], Player, ListOfMovesTmp, Xinitial, Yinitial, 1, 13, ListOfMoves):- append([],ListOfMovesTmp,ListOfMoves).%:-        write(ListOfMoves),nl.

choose_move(Difficulty,Board, [Move|Ls], Xinitial, Yinitial, Xfinal, Yfinal):-
        %write(ListOfMoves),nl,
        %random_member(Move,ListOfMoves),
        %ESCOLHE A PRIMEIRA JOGADA POSSIVEL
        getCoordsFromMove(Move, Xinitial,Yinitial,Xfinal,Yfinal),
        write(Xinitial),write(Yinitial),write(Xfinal),write(Yfinal),nl.

getCoordsFromMove([Xinitial,Yinitial,Xfinal,Yfinal], Xinitial,Yinitial,Xfinal,Yfinal).




%verifica se existe um baby da equipa adversaria na posicao final
%se sim come esse baby e nao deixa um baby na posicao inicial
%se nao existir nenhuma peca na posicao final deixa um baby na posicao inicial ao deslocar se
%eat(Xinitial,Yinitial,Xfinal,Yfinal).

%deixa um baby na posição inicial da rainha após esta se movimentar
%dropBaby(Board,X,Y,Player). %IMPORTANTE

%acaba o jogo?
%game_over Player 2
game_over(Board, Winner):- %IMPORTANTE
        \+getQueenPos(2, Board, Xrainha, Yrainha, Value),
        Winner is 1.

game_over(Board, Winner):- %IMPORTANTE
        valid_moves(Board, 2, ListOfMoves),
        length(ListOfMoves,Len),
        Len == 0,
        Winner is 1.


%game_over Player 1
game_over(Board, Winner):- %IMPORTANTE
        \+getQueenPos(1, Board, Xrainha, Yrainha, Value),
        Winner is 2.

%game_over Player 1
game_over(Board, Winner):- %IMPORTANTE
        valid_moves(Board, 1, ListOfMoves),
        length(ListOfMoves,Len),
        Len == 0,
        Winner is 2.