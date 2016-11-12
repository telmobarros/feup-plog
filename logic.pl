board_initialized(Board):-
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
               [0,0,0,0,0,0,20,0,0,0,0,0]].

/*board_initialized2(NBoard):-
        NBoard=[[0,0,0,0,0,0,-1,0,0,0,0,0],          %estado inicial
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,19,0,0,0,0],
               [0,0,0,-19,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,0,0,0,1,0,0,0,0,0]].*/

/*board_initialized(Board):-
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

/**board_initialized(Board):-
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
           [0,0,0,0,0,0,0,0,0,0,0,0]].*/






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
        %write('setBoardPos'),nl,
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

setBoardLinePos([_|Ls], X, X,PiecePlayer, [PiecePlayer|Ls]).%:-
% X > 1,
%write(PiecePlayer),nl,
%write(Ls),nl,
%write('encontrei, vou trocar'), nl.



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
        %write('vou ver os moves para o baby'),nl,
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
        %write('hmmmmm'),nl,
        getQueenPos(2, Board, Xrainha, Yrainha, Value),
        distancia(Xinitial,Yinitial,Xrainha,Yrainha,Distinitial),
        distancia(Xfinal,Yfinal,Xrainha,Yrainha,Distfinal),
        Distfinal < Distinitial.

queen_aprox(Board, 2, Xfinal, Yfinal, Xinitial, Yinitial):-
        %write('hmmmmm'),nl,
        getQueenPos(1, Board, Xrainha, Yrainha, Value),
        %write('x'),write(Xrainha),nl,
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
        valid_movesAux([L1|Ls], Player, [], 1, 1,ListOfMoves).


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

valid_movesAux([L1|Ls], Player, ListOfMovesTmp, 1, 13, ListOfMovesTmp).%:- append([],ListOfMovesTmp,ListOfMoves).

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

valid_moveAux([L1|Ls], Player, ListOfMovesTmp, Xinitial, Yinitial, 1, 13, ListOfMovesTmp).%:- append([],ListOfMovesTmp,ListOfMoves).%:-        write(ListOfMoves),nl.

%avalia todas as jogadas possiveis
%5-Ganhar o jogo
%4-Comer um baby sem deixar a rainha na linha de ataque
%3-Proteger a rainha
%2-Comer um baby e deixar a rainha na linha de ataque
%1-Não comer um baby e deixar a rainha na linha de ataque
%value(+PreviousBoard, +Board, +Player, -Value)
value(PreviousBoard, Board, Player, Value):-
        game_over(Board,Winner),
        Value is 5.

value(PreviousBoard, Board, 1, Value):-
        isQueenProtected(1, Board),
        once(countBoardPieces(Board, 2, Count)),
        once(countBoardPieces(PreviousBoard, 2, PreviousCount)),
        Count < PreviousCount,
        Value is 4.

value(PreviousBoard, Board, 2, Value):-
        isQueenProtected(2, Board),
        once(countBoardPieces(PreviousBoard, 1, PreviousCount)),
        once(countBoardPieces(Board, 1, Count)),
        Count < PreviousCount,
        Value is 4.

value(PreviousBoard, Board, 1, Value):-
        isQueenProtected(1, Board),
        once(countBoardPieces(PreviousBoard, 2, PreviousCount)),
        once(countBoardPieces(Board, 2, Count)),
        Count == PreviousCount,
        Value is 3.

value(PreviousBoard, Board, 2, Value):-
        isQueenProtected(2, Board),
        once(countBoardPieces(PreviousBoard, 1, PreviousCount)),
        once(countBoardPieces(Board, 1, Count)),
        Count == PreviousCount,
        Value is 3.

value(PreviousBoard, Board, 1, Value):-
        once(countBoardPieces(Board, 2, Count)),
        once(countBoardPieces(PreviousBoard, 2, PreviousCount)),
        Count < PreviousCount,
        Value is 2.

value(PreviousBoard, Board, 2, Value):-
        once(countBoardPieces(PreviousBoard, 1, PreviousCount)),
        once(countBoardPieces(Board, 1, Count)),
        Count < PreviousCount,
        Value is 2.

value(PreviousBoard, Board, 1, Value):-
        once(countBoardPieces(PreviousBoard, 2, PreviousCount)),
        once(countBoardPieces(Board, 2, Count)),
        Count == PreviousCount,
        Value is 1.

value(PreviousBoard, Board, 2, Value):-
        once(countBoardPieces(PreviousBoard, 1, PreviousCount)),
        once(countBoardPieces(Board, 1, Count)),
        Count == PreviousCount,
        Value is 1.

%cria lista com valores de uma lista de jogadas
value_moves(Board, CurPlayer, [Move|Ms], [Value|Vs]):-
        getCoordsFromMove(Move, Xinitial,Yinitial,Xfinal,Yfinal),
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard),
        value(Board, NewBoard, CurPlayer, Value),
        value_moves(Board, CurPlayer, Ms, Vs).


value_moves(Board, CurPlayer, [], []).




%conta as peças de um jogador no board
%countBoardPieces(+Board, +Player, -Count)
%countBoardPieces(Board, Player, Count):-
countBoardPieces([L1|Ls], Player, Count):-
        countBoardPiecesLine(L1, Player, CountLineTmp),
        countBoardPieces(Ls, Player, CountTmp),
        Count is CountTmp + CountLineTmp.

countBoardPieces([], Player, 0).

countBoardPiecesLine([L1|Ls], 1, Count):-
        L1 > 0,
        countBoardPiecesLine(Ls, 1, CountTmp),
        Count is CountTmp + 1.

countBoardPiecesLine([L1|Ls], 2, Count):-
        L1 < 0,
        countBoardPiecesLine(Ls, 2, CountTmp),
        Count is CountTmp + 1.

countBoardPiecesLine([L1|Ls], Player, Count):-
        countBoardPiecesLine(Ls, Player, Count).

countBoardPiecesLine([], Player, 0).

isQueenProtected(Player, Board):-
        getQueenPos(Player,Board,X,Y,Value),
        once(isQueenProtectedAux(Board, 1, 1, X, Y, Value)).

%percorre todas as linhas até à ultima
isQueenProtectedAux([L1|Ls], X, Y, Xqueen, Yqueen , ValueQueen):-
        isQueenProtectedLineAux(L1, X, Y, Xqueen, Yqueen, ValueQueen),
        Yprox is Y + 1,
        isQueenProtectedAux(Ls, 1, Yprox, Xqueen, Yqueen, ValueQueen).

isQueenProtectedAux([], X, Y, Xqueen, Yqueen, ValueQueen).

%linhas com 0 ou peças da mesma cor
isQueenProtectedLineAux([L1|Ls], X, Y, Xqueen, Yqueen, ValueQueen):-
        legal_orientation(X,Y,Xqueen,Yqueen),
        Var is L1 * ValueQueen,
        Var >= 0,
        Xprox is X + 1,
        isQueenProtectedLineAux(Ls, Xprox, Y, Xqueen, Yqueen, ValueQueen).

isQueenProtectedLineAux([L1|Ls], X, Y, Xqueen, Yqueen, ValueQueen):-
        \+legal_orientation(X,Y,Xqueen,Yqueen),
        Xprox is X + 1,
        isQueenProtectedLineAux(Ls, Xprox, Y, Xqueen, Yqueen, ValueQueen).

isQueenProtectedLineAux([], X, Y, Xqueen, Yqueen, ValueQueen).


max(ListOfValues, MaxValue):-
        once(maxAux(ListOfValues, 0, MaxValue)).

maxAux([V1|Vs], MaxValueTmp, MaxValue):-
        V1 > MaxValueTmp,
        maxAux(Vs, V1, MaxValue).
maxAux([V1|Vs], MaxValueTmp, MaxValue):-
        maxAux(Vs, MaxValueTmp, MaxValue).


maxAux([], MaxValueTmp, MaxValueTmp).

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




