:-include('board.pl').

monkey_queen:- 
        repeat,
                once(readGameMode(Mode)),
        readComputerDifficulty(Mode,Difficulty),
        initializeGame(Mode, Board, Player1Type, Player2Type, CurPlayer, CurPlayerType),
        play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty).
        


play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty) :-
        write('Player1'),nl,
        valid_moves(Board, 1, ListOfMoves),
        write(ListOfMoves),nl,
        write('Player2'),nl,
        valid_moves(Board, 2, ListOfMoves2),
        write(ListOfMoves2),nl,
        write('Play game'),nl,
        \+game_over(Board,Winner),
        once(display_board(Board)),
        write('Player '), write(CurPlayer), write('  Player Type : '), write(CurPlayerType), nl, %%debug only
        play_turn(Board, NewBoard, CurPlayer, CurPlayerType, Difficulty),
        switchPlayer(CurPlayer, NewPlayer, NewPlayerType, Player1Type, Player2Type),
        play_game(NewBoard, Player1Type, Player2Type, NewPlayer, NewPlayerType, Difficulty).

play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty):-
        game_over(Board,Winner),
        write('winner of the game player '), write(Winner),nl.

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
