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


           
display_board([L1|Ls]):-
        write('  A    B    C    D    E    F    G    H    I    J    K    L'), nl,        %imprime cabeçalho com letras das colunas
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
         

readComputerDifficulty(1, Difficulty) :- Difficulty is 0.
readComputerDifficulty(Mode, Difficulty) :-
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


switchPlayer(1, Player1Type, Player2Type, CurPlayer, CurPlayerType) :-
        CurPlayer is 2,
        CurPlayerType is Player2Type.

switchPlayer(2, Player1Type, Player2Type, CurPlayer, CurPlayerType) :-
        CurPlayer is 1,
        CurPlayerType is Player1Type.
        


%Pedir ao utilizar a jogada a realizar, ou seja, posicao inicial da pec e posicao final
%X nome da coluna
%Y numero da linha
readMove(Xinitial, Yinitial, Xfinal, Yfinal) :-
        write('Piece to move:'), nl,
        write('X->'), read(Xinitial), 
        write('Y->'), read(Yinitial), nl,
        write('Where to move:'), nl,
        write('X->'), read(Xfinal),
        write('Y->'), read(Yfinal), nl.


        
%verficar se a posicao é valida (se se encontra dentro do tabuleiro)
legal_pos(X,Y).

%verifica se os parametros introduzidos como posicoes finais nao saem do tabuleiro
%se a linha e a coluna finais forem diferentes das posicoes iniciais chama a funcao move_diagonal
%se a linha final for igual a inicial chama a funcao move_horizontal
%se a coluna final for igual a inicial chama a funcao move_vertical
legal_move(Xinitial, Yinitial, Xfinal,Yfinal).

%verifica se a rainha se movimenta para uma posicao onde se encontra um baby ou rainha da equipa adversaria
legal_queen_move(Xinitial,Yinitial,Xfinal,Yfinal).

%verfifca se as posicoes final sao posicoes validas em relacao a posicao inicial e guarda a nova posicao ou whatever
diagonal_move(Xinitial, Yinitial, Xfinal,Yfinal).

%guarda as novas posicoes apos fazer o movimento horizontal da peca
horizontal_move(Xinitial, Yinitial, Xfinal,Yfinal).

%guarda as novas posicoes apos fazer o movimento vertical da peca
vertical_move(Xinitial, Yinitial, Xfinal,Yfinal).

%pesquisa posicao rainha
queen_pos(Jog,Board).

%verifica se a peca ao movimentar-se se se aproxima da rainha
queen_aprox(Xqueen, Yqueen, Xinitial, Yinitial, Xfinal, Yfinal).

%verifica se existe um baby da equipa adversaria na posicao final
%se sim come esse baby e nao deixa um baby na posicao inicial
%se nao existir nenhuma peca na posicao final deixa um baby na posicao inicial ao deslocar se
eat(Xinitial,Yinitial,Xfinal,Yfinal).

%deixa um baby na posição inicial da rainha após esta se movimentar
dropBaby(X,Y).

%acaba o jogo?
gameEnd(Rainha1, Rainha2).
