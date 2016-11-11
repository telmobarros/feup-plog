:-include('board.pl').

monkey_queen:- 
        repeat,
                once(readGameMode(Mode)),
        readComputerDifficulty(Mode,Difficulty),
        initializeGame(Mode, Board, Player1Type, Player2Type, CurPlayer, CurPlayerType),
        play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty).
        


play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty) :-
        display_board(Board),
        write('Player '), write(CurPlayer), write('  Player Type : '), write(CurPlayerType), nl, %%debug only
        getQueenPos(2, Board, X, Y, Value),
        write(X),nl,
        write(Y),nl,
        write(Value),nl,
        play_turn(Board, NewBoard, CurPlayer, CurPlayerType, Difficulty),
        switchPlayer(CurPlayer, NewPlayer, NewPlayerType, Player1Type, Player2Type),
        play_game(NewBoard, Player1Type, Player2Type, NewPlayer, NewPlayerType, Difficulty).

play_turn(Board, NewBoard, CurPlayer, 0, Difficulty) :-
        repeat,
        once(readMove(Xinitial, Yinitial, Xfinal, Yfinal)),
        legal_move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal),
        %write('Movimento valido'),nl,
        %write(PieceInitial),nl,
        %write(PieceFinal),nl,
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard).
        %write('Movimento efetuado'),nl.


play_turn(Board, NewBoard, CurPlayer, 1, Difficulty) :-
        valid_moves(Board, CurPlayer, ListOfMoves),
        choose_move(Difficulty,Board, ListOfMoves, Xinitial, Yinitial, Xfinal, Yfinal),    
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard).
