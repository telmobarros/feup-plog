/** board([[0,0,0,0,0,-20,0,0,0,0,0,0],
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
	   [0,0,0,0,0,0,20,0,0,0,0,0]]).*/
	   
board([[0,0,0,0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,-1,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0,0,0,0],
	   [0,1,0,0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,7,0,0,0,0,0,-1,0],
	   [0,0,0,0,0,0,0,0,0,-1,0,0],
	   [0,0,0,0,0,0,0,0,0,0,-9,0],
	   [0,0,0,0,0,0,0,0,0,0,0,0],
	   [0,0,0,1,0,0,0,0,0,0,0,0]]).

	   
display_board([L1|Ls]):-
	write(' A   B   C   D   E   F   G   H   I   J   K   L'), nl,
	write('------------------------------------------------'), nl,
	display_lines([L1|Ls], 1).
	   
display_lines([L1|Ls], Nlines):- 
	display_line(L1), write('| '), write(Nlines), nl,
	write('------------------------------------------------'), nl,
	Nextlines is Nlines + 1,
	display_lines(Ls,Nextlines).

display_lines([], Nlines):- .

display_line([E|Es]):-
	write('|'),
	writeabs(E),
	display_line(Es).
	
writeabs(X) :- X < 0 ->
			Y is -X,
			write(Y), write('P');	%peça preta
			X > 0 ->
			write(X), write('B');		%peça branca
			write('   ').	%espaço vazio
	
	
	

moveHorizontal(X,Y,N).
moveVertical(X,Y,N).
moveDiagonal(X,Y,N).
%translate(0,'   ').
/**translate(-20,'20P').
translate(-19,'19P').
translate(-18,'18P').
translate(-17,'17P').
translate(-16,'16P').
translate(-15,'15P').
translate(-14,'14P').
translate(-13,'13P').
translate(-12,'12P').
translate(-11,'11P').
translate(-10,'10P').
translate(-9,' 9P').
translate(-8,' 8P').
translate(-7,' 7P').
translate(-6,' 6P').
translate(-5,' 5P').
translate(-4,' 4P').
translate(-3,' 3P').
translate(-2,' 2P').
translate(-1,' P').

translate(20,'20B').
translate(19,'19B').
translate(18,'18B').
translate(17,'17B').
translate(16,'16B').
translate(15,'15B').
translate(14,'14B').
translate(13,'13B').
translate(12,'12B').
translate(11,'11B').
translate(10,'10B').
translate(9,' 9B').
translate(8,' 8B').
translate(7,' 7B').
translate(6,' 6B').
translate(5,' 5B').
translate(4,' 4B').
translate(3,' 3B').
translate(2,' 2B').
translate(1,' B ').*/

display_line([]).


play_game(B):-
	board(B),
	display_board(B).