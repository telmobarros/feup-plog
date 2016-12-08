:-use_module(library(clpfd)).
:-use_module(library(lists)).

ano_escolar(NDisciplinas, NTurmas, NSemanas,ListaTestes1, ListaTestes2):-
	criar_lista_testes(NDisciplinas, NTurmas, ListaTestes1),
	criar_lista_testes(NDisciplinas, NTurmas, ListaTestes2),
	
	%calcula semanas em que pode haver teste e define os dominios das duas fases de testes
	NSemanas >= NDisciplinas,
	MinSemana1 is integer(NSemanas/2 - NDisciplinas/2),
	MaxSemana1 is integer(NSemanas/2),
	MinSemana2 is integer(NSemanas - NDisciplinas/2),
	MaxSemana2 is integer(NSemanas),
	impoeDominiosTeste(ListaTestes1,MinSemana1, MaxSemana1),
	impoeDominiosTeste(ListaTestes2,MinSemana2, MaxSemana2),
	
	%impoe dois testes por semana
	doisTestesSemana(ListaTestes1, NDisciplinas, MinSemana1, MaxSemana1),
	doisTestesSemana(ListaTestes2, NDisciplinas, MinSemana2, MaxSemana2),
	
	%impoe testes na mesma semana com distancia de 2 dias
	testesNaoConsecutivos(ListaTestes1, ListaTestes1),
	testesNaoConsecutivos(ListaTestes2, ListaTestes2),
	
	labeling([],ListaTestes1),
	labeling([],ListaTestes2),
	write(ListaTestes1), nl, write(ListaTestes2).


%%%criador da lista inicial de testes para cada fase de testes%%%%%%%%%%%%%%%%%%%%%%
	
%cria uma lista do tipo [1, 1, _, _, ... , NTurmas, NDisciplinas, _, _]
%criar_lista_testes(+NDisciplinas, +NTurmas, -ListaTestes).
criar_lista_testes(NDisciplinas, NTurmas, ListaTestes):-
	once(criar_lista_testes_aux(1, 1, NDisciplinas, NTurmas, ListaTestes)).

criar_lista_testes_aux(1, TurmaCounter, _, NTurmas, []):-
	TurmaCounter > NTurmas.
	
criar_lista_testes_aux(NDisciplinas, TurmaCounter, NDisciplinas, NTurmas, [TurmaCounter , NDisciplinas , _ , _| Ls]):-
	TurmaCounter =< NTurmas,
	NextTurmaCounter is TurmaCounter + 1,
	criar_lista_testes_aux(1, NextTurmaCounter, NDisciplinas, NTurmas, Ls).

criar_lista_testes_aux(DisciplinaCounter, TurmaCounter, NDisciplinas, NTurmas, [TurmaCounter , DisciplinaCounter , _, _| Ls]):-
	DisciplinaCounter < NDisciplinas,
	TurmaCounter =< NTurmas,
	NextDisciplinaCounter is DisciplinaCounter + 1,
	criar_lista_testes_aux(NextDisciplinaCounter , TurmaCounter, NDisciplinas, NTurmas, Ls).


%%Dominios de semanas(meio e final do periodo) e dias da semana
	
impoeDominiosTeste(Lista, MinSemana, MaxSemana):-
	getSemanas_DiasSemana(Lista , Semanas, DiasSemana),
	domain(Semanas, MinSemana, MaxSemana),
	domain(DiasSemana, 1, 5).


getSemanas_DiasSemana([], [], []).
getSemanas_DiasSemana([_, _, Semana , DiaSemana | Ls], [Semana | Ss], [DiaSemana | Ds]):-
	getSemanas_DiasSemana(Ls, Ss, Ds).


%%%Restrição testes não consecutivos%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
%caso base
testesNaoConsecutivos([],[]).

%final da segunda lista
testesNaoConsecutivos([_, _, _, _| Ls1],[]):-
testesNaoConsecutivos(Ls1,Ls1).

%mesma turma, mesma semana (necessidade de restricao)
testesNaoConsecutivos([Turma, Disciplina1, Semana1 , DiaSemana1 | Ls1],[Turma, Disciplina2, Semana2 , DiaSemana2 | Ls2]):-
Disciplina1 =\= Disciplina2,
((abs(DiaSemana1 - DiaSemana2) #> 1) #/\ (Semana1 #= Semana2)) #\ (Semana1 #\= Semana2),
testesNaoConsecutivos([Turma, Disciplina1, Semana1 , DiaSemana1 | Ls1], Ls2).

%mesma turma, mesma disciplina
testesNaoConsecutivos([Turma, Disciplina, Semana1 , DiaSemana1 | Ls],[Turma, Disciplina, _, _| Ls]):-
testesNaoConsecutivos([Turma, Disciplina, Semana1 , DiaSemana1 | Ls], Ls).

%turmas diferentes
testesNaoConsecutivos([Turma1, Disciplina1, Semana1 , DiaSemana1 | Ls1],[Turma2, _, _, _| Ls2]):-
Turma1 =\= Turma2,
testesNaoConsecutivos([Turma1, Disciplina1, Semana1 , DiaSemana1 | Ls1], Ls2).


%%%Restrição dois testes por semana%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%caso base
doisTestesSemana([], _, _, _).

%turma feita
doisTestesSemana(Lista, NDisciplinas, MinSemana, MaxSemana):-
	getSemanas(Lista, NDisciplinas, Semanas, RestoLista),
	impoeDoisTestesCadaSemana(Semanas, MinSemana, MaxSemana),
	doisTestesSemana(RestoLista, NDisciplinas, MinSemana, MaxSemana).
	
getSemanas(Ls, 0, [], Ls).
getSemanas([_, _, Semana, _| Ls], Counter, [Semana|Ss], _):-
	NextCounter is Counter - 1,
	getSemanas(Ls, NextCounter, Ss, _).
	
impoeDoisTestesCadaSemana(_, MinSemana, MaxSemana):-
	MinSemana > MaxSemana.

impoeDoisTestesCadaSemana(Semanas, MinSemana, MaxSemana):-
		MinSemana =< MaxSemana,
		count(MinSemana,Semanas,#=<,2),
		NextMinSemana is MinSemana + 1,
		impoeDoisTestesCadaSemana(Semanas, NextMinSemana, MaxSemana).