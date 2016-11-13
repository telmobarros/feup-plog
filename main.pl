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
        %board_initialized2(NextBoard),
        %display_board(NextBoard),
        %once(value(Board,NextBoard,1,Value)),
        %write(Value),
        \+game_over(Board,Winner),
        write('Player '), write(CurPlayer), write('  Player Type : '), write(CurPlayerType), nl, %%debug only
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
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard),nl,
        display_mssg_best_play(Board,CurPlayer,Xinitial, Yinitial, Xfinal, Yfinal).


play_turn(Board, NewBoard, CurPlayer, 1, Difficulty) :-
        valid_moves(Board, CurPlayer, ListOfMoves),
        value_moves(Board, CurPlayer, ListOfMoves, ListOfValues),
        once(choose_move(Difficulty, ListOfMoves, ListOfValues, Xinitial, Yinitial, Xfinal, Yfinal)),  
        move(CurPlayer, Board, Xinitial, Yinitial, Xfinal, Yfinal, NewBoard),nl.



display_mssg_best_play(Board,CurPlayer,Xinitial, Yinitial, Xfinal, Yfinal):-
        valid_moves(Board, CurPlayer, ListOfMoves),
        value_moves(Board, CurPlayer, ListOfMoves, ListOfValues),
        choose_move(4, ListOfMoves, ListOfValues, Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp),
        once(best_move(Xinitial, Yinitial, Xfinal, Yfinal,Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp)).



best_move(Xinitial, Yinitial, Xfinal, Yfinal,Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp):-
        Xinitial \== Xinitialcp,
        display_msg(Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp).
        

best_move(Xinitial, Yinitial, Xfinal, Yfinal,Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp):-
        Yinitial \== Yinitialcp,
        display_msg(Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp).

best_move(Xinitial, Yinitial, Xfinal, Yfinal,Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp):-
        Xfinal \== Xfinalcp,
        display_msg(Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp).

best_move(Xinitial, Yinitial, Xfinal, Yfinal,Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp):-
        Yfinal \== Yfinalcp,
        display_msg(Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp).


display_msg(Xinitialcp, Yinitialcp, Xfinalcp, Yfinalcp):-
        write('The best play was: '),nl,
        write('Xinitial: '), write(Xinitialcp),nl,
        write('Yinitial: '), write(Yinitialcp),nl,
        write('Xfinal: '), write(Xfinalcp),nl,
        write('Yfinal: '), write(Yfinalcp),nl.
