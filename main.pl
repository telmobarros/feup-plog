:-include('board.pl').

queen_monkey:- 
        readGameMode(Mode),
        %readComputerDifficulty(Mode,Difficulty),
        initializeGame(Mode, Board, Player1Type, Player2Type, CurPlayer, CurPlayerType),
        play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty).
        


play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty) :-
        display_board(Board),
        write(CurPlayer),write(CurPlayerType), %%debug only
        play_turn(Board, CurPlayer, CurPlayerType, Difficulty),     
        switchPlayer(1, Player1Type, Player2Type, CurPlayer, CurPlayerType),
        write(CurPlayer),write(CurPlayerType), %%debug only
        play_game(Board, Player1Type, Player2Type, CurPlayer, CurPlayerType, Difficulty).

play_turn(Board, CurPlayer, 0, Difficulty) :-
        readMove(Xinitial, Yinitial, Xfinal, Yfinal).

play_turn(Board, CurPlayer, 1, Difficulty).