:-include('interface.pl').
:-include('bot.pl').
:-include('logic.pl').

monkey_queen:- 
        repeat,
        once(readGameMode(Mode)),
        readComputerDifficulty(Mode,Difficulty),
        initializeGame(Mode, Board, Player1Type, Player2Type, CurPlayer, CurPlayerType),
        play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty).



play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty) :-
        display_board(Board),
        \+game_over(Board,Winner),
        write('Player '), write(CurPlayer), write(' Turn...'),nl,
        play_turn(Board, NewBoard, CurPlayer, CurPlayerType, Difficulty),
        switchPlayer(CurPlayer, NewPlayer, NewPlayerType, Player1Type, Player2Type),
        play_game(NewBoard, Player1Type, Player2Type, NewPlayer, NewPlayerType, Difficulty).

play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty):-
        game_over(Board,Winner),
        write('PLAYER '), write(Winner), write(' WINS!'),nl.

play_turn(Board, NewBoard, CurPlayer, 0, Difficulty) :-
        repeat,
        once(readMove(Xinitial, Yinitial, Xfinal, Yfinal)),
        legal_move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal),
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard),
        display_msg_best_move(CurPlayer ,Board, NewBoard).


play_turn(Board, NewBoard, CurPlayer, 1, Difficulty) :-
        valid_moves(Board, CurPlayer, ListOfMoves),
        value_moves(Board, CurPlayer, ListOfMoves, ListOfValues),
        once(choose_move(Difficulty, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal)),  
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard).

