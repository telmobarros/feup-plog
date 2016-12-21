:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-include('interface.pl').

%horario(+Turma, -Horario).

horario(1, [[1,3,4,2],[2,5,7,6,9],[1,2,8],[8,4,5],[2,4,8,9,1]]).
horario(2, [[2,5,7,6,9],[1,3,4,2],[8,4,5],[1,2,8],[2,4,8,9,1]]).
horario(3, [[1,3,4,2],[2,4,8,9,1],[1,2,8],[8,4,5],[2,5,7,6,9]]).
horario(4, [[2,4,8,9,1],[1,3,4,2],[8,4,5],[2,5,7,6,9],[1,2,8]]).


ano_escolar(NDisciplinas, NTurmas, NSemanas, NTPCDia, NTPCDisc, DiaLivreTPC, ListaTestes, ListaTPCs):-
	criar_lista_testes(NDisciplinas, NTurmas, ListaTestes1),
	criar_lista_testes(NDisciplinas, NTurmas, ListaTestes2),
	criar_lista_tpcs(NDisciplinas,ListaTPCs),
        writeHorarios(1, NTurmas),
	getTPCs(ListaTPCs,ListaTpcs),
	domain(ListaTpcs,0,1),
	horario(1,Horario1),
	tpcEmDiaComDisciplina(Horario1,ListaTPCs),
	setSomaTpcDia(NTPCDia,ListaTPCs, DiaLivreTPC),
        setSomaTpcDisciplina(NTPCDisc, ListaTPCs, NDisciplinas),

	%calcula semanas em que pode haver teste e define os dominios das duas fases de testes
	NSemanas >= NDisciplinas,
	MinSemana1 is integer(NSemanas/2 - NDisciplinas/2),
	MaxSemana1 is integer(NSemanas/2),
	MinSemana2 is integer(NSemanas - NDisciplinas/2),
	MaxSemana2 is integer(NSemanas),
	impoeDominiosTeste(ListaTestes1,MinSemana1, MaxSemana1),
	impoeDominiosTeste(ListaTestes2,MinSemana2, MaxSemana2),

        testesEmDiasComDisciplina(ListaTestes1),
        testesEmDiasComDisciplina(ListaTestes2),

	%impoe dois testes por semana
	doisTestesSemana(ListaTestes1, NDisciplinas, MinSemana1, MaxSemana1),
	doisTestesSemana(ListaTestes2, NDisciplinas, MinSemana2, MaxSemana2),

	%impoe testes na mesma semana com distancia de 2 dias
	testesNaoConsecutivos(ListaTestes1, ListaTestes1),
	testesNaoConsecutivos(ListaTestes2, ListaTestes2),

        %%otimizacao dos testes proximos
        getDistanciaTestesMesmaDisciplina(ListaTestes1, ListaTestes1, Distancias1),
        sum(Distancias1,#=,TotalDistancia1),
        getDistanciaTestesMesmaDisciplina(ListaTestes2, ListaTestes2, Distancias2),
        sum(Distancias2,#=,TotalDistancia2),

	labeling([minimize(TotalDistancia1),time_out(30000,_),all],ListaTestes1),%time_out(30000,_)
	labeling([minimize(TotalDistancia2),time_out(30000,_),all],ListaTestes2),
	append(ListaTestes1, ListaTestes2, ListaTestes),

        %%labeling tpc
        sum(ListaTpcs,#=,Total),
	labeling([maximize(Total)],ListaTPCs),

        %writes
	writeTestes(ListaTestes1, ListaTestes2),
        write(TotalDistancia1),nl,write(Distancias1),nl,
        write(TotalDistancia2),nl,write(Distancias2),nl,
	write(ListaTPCs).


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

criar_lista_tpcs(NDisciplinas,Lista):-
	once(criar_lista_tpcs_aux(1, 1, NDisciplinas, Lista)).

criar_lista_tpcs_aux(6,1,_,[]).

criar_lista_tpcs_aux(Ndia,NDisciplinas,NDisciplinas,[Ndia,NDisciplinas,_|Ls]):-
        Ndia =< 5,
	NdiaVar is Ndia +1,
	criar_lista_tpcs_aux(NdiaVar,1,NDisciplinas,Ls).

criar_lista_tpcs_aux(Ndia,Ndisc,NDisciplinas,[Ndia,Ndisc,_|Ls]):-
        Ndisc < NDisciplinas,
        Ndia =< 5,
        NdiscVar is Ndisc +1,
        criar_lista_tpcs_aux(Ndia,NdiscVar,NDisciplinas,Ls).




%%Dominios de semanas(meio e final do periodo) e dias da semana

impoeDominiosTeste(Lista, MinSemana, MaxSemana):-
	getSemanas_DiasSemana(Lista , Semanas, DiasSemana),
	domain(Semanas, MinSemana, MaxSemana),
	domain(DiasSemana, 1, 5).


getSemanas_DiasSemana([], [], []).
getSemanas_DiasSemana([_, _, Semana , DiaSemana | Ls], [Semana | Ss], [DiaSemana | Ds]):-
	getSemanas_DiasSemana(Ls, Ss, Ds).

getTPCs([],[]).
getTPCs([_,_,L1|Ls],[L1|Ts]):-
        getTPCs(Ls,Ts).


%%Dias de testes apenas em dias em que a disciplina esta no horario

testesEmDiasComDisciplina([]).
testesEmDiasComDisciplina([Turma, Disciplina, _, DiaSemana | Ls]):-
        horario(Turma, Horario),
        testesEmDiasComDisciplinaAux(Horario, Disciplina, 1, DiaSemana),
        testesEmDiasComDisciplina(Ls).

testesEmDiasComDisciplinaAux([], _, _, _).

testesEmDiasComDisciplinaAux([H1|Hs], Disciplina, DiaCounter, DiaSemana):-
        member(Disciplina,H1),
        NextDiaCounter is DiaCounter + 1,
        testesEmDiasComDisciplinaAux(Hs, Disciplina, NextDiaCounter, DiaSemana).

testesEmDiasComDisciplinaAux([H1|Hs], Disciplina, DiaCounter, DiaSemana):-
        \+member(Disciplina,H1),
        DiaSemana #\= DiaCounter,
        NextDiaCounter is DiaCounter + 1,
        testesEmDiasComDisciplinaAux(Hs, Disciplina, NextDiaCounter, DiaSemana).


tpcEmDiaComDisciplina(_,[]).		
tpcEmDiaComDisciplina(Horario,[Ndia,Ndisc,Var|Ls]):-       
	once(tpcEmDiaComDisciplinaAux(Horario,Ndia,Ndisc, Var,1)),
	tpcEmDiaComDisciplina(Horario,Ls).


tpcEmDiaComDisciplinaAux([L1|Ls],Ndia,Ndisc,Var,NdiaCounter):-
        NdiaCounter < Ndia,
        NdiaVar is NdiaCounter +1,
        tpcEmDiaComDisciplinaAux(Ls,Ndia,Ndisc,Var,NdiaVar).

tpcEmDiaComDisciplinaAux([L1|Ls],Ndia,Ndisc,Var,Ndia):-
        \+member(Ndisc,L1),
        Var #= 0.

tpcEmDiaComDisciplinaAux([L1|Ls],Ndia,Ndisc,Var,Ndia):-
        member(Ndisc,L1).


%%%Restricao testes nao consecutivos%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%Otimizacao testes mesma disciplina%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%caso base
getDistanciaTestesMesmaDisciplina([],[],[0|[]]).

%final da segunda lista
getDistanciaTestesMesmaDisciplina([_, _, _, _| Ls1],[], [D1|Ds]):-
        getDistanciaTestesMesmaDisciplina(Ls1, Ls1, [D1|Ds]).

%disciplinas diferentes
getDistanciaTestesMesmaDisciplina([Turma1, Disciplina1, Semana1 , DiaSemana1 | Ls1],[Turma2, Disciplina2, Semana2 , DiaSemana2 | Ls2], [D1|Ds]):-
        Disciplina1 =\= Disciplina2,
        getDistanciaTestesMesmaDisciplina([Turma1, Disciplina1, Semana1 , DiaSemana1 | Ls1], Ls2, [D1|Ds]).

%mesma turma, mesma disciplina
getDistanciaTestesMesmaDisciplina([Turma, Disciplina, Semana1 , DiaSemana1 | Ls],[Turma, Disciplina, _, _| Ls], [D1|Ds]):-
        getDistanciaTestesMesmaDisciplina([Turma, Disciplina, Semana1 , DiaSemana1 | Ls], Ls, [D1|Ds]).

%turmas diferentes, mesma disciplina
getDistanciaTestesMesmaDisciplina([Turma1, Disciplina, Semana1 , DiaSemana1 | Ls1],[Turma2, Disciplina, Semana2, DiaSemana2| Ls2], [D1|Ds]):-
        Turma1 =\= Turma2,
        D1 #= abs((Semana1*5+DiaSemana1) - (Semana2*5+DiaSemana2)),
	%Option = min(abs(Semana1- Semana2)),%min(abs(Semana1*5+DiaSemana1 - Semana2*5+DiaSemana2)),
        getDistanciaTestesMesmaDisciplina([Turma1, Disciplina, Semana1 , DiaSemana1 | Ls1], Ls2, Ds).


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Soma do numero de tpcs por dia %%%%%%%%%%%%%%%%%%%%%%%%


setSomaTpcDia(NTPCDia,Lista, DiaLivreTPC):-
        setSomaTpcDiaAux(Lista,L1,L2,L3,L4,L5),
        sum(L1,#=<,NTPCDia),
        sum(L2,#=<,NTPCDia),
        sum(L3,#=<,NTPCDia),
        sum(L4,#=<,NTPCDia),
        sum(L5,#=<,NTPCDia),
        setDiaLivreTPC(DiaLivreTPC,L1,L2,L3,L4,L5).


setDiaLivreTPC(1,L1,_,_,_,_):-sum(L1,#=,0).
setDiaLivreTPC(2,_,L2,_,_,_):-sum(L2,#=,0).
setDiaLivreTPC(3,_,_,L3,_,_):-sum(L3,#=,0).
setDiaLivreTPC(4,_,_,_,L4,_):-sum(L4,#=,0).
setDiaLivreTPC(5,_,_,_,_,L5):-sum(L5,#=,0).
%sum(L1,#=,0).% #\/ sum(L2,#=,0).% #\/ sum(L3,#=,0) #\/ sum(L4,#=,0) #\/ sum(L5,#=,0).

setSomaTpcDiaAux([1,_,Var|Ls],[Var|Ts],L2,L3,L4,L5):-setSomaTpcDiaAux(Ls,Ts,L2,L3,L4,L5).
setSomaTpcDiaAux([2,_,Var|Ls],[],[Var|Ts],L3,L4,L5):-setSomaTpcDiaAux(Ls,[],Ts,L3,L4,L5).
setSomaTpcDiaAux([3,_,Var|Ls],[],[],[Var|Ts],L4,L5):-setSomaTpcDiaAux(Ls,[],[],Ts,L4,L5).
setSomaTpcDiaAux([4,_,Var|Ls],[],[],[],[Var|Ts],L5):-setSomaTpcDiaAux(Ls,[],[],[],Ts,L5).
setSomaTpcDiaAux([5,_,Var|Ls],[],[],[],[],[Var|Ts]):-setSomaTpcDiaAux(Ls,[],[],[],[],Ts).
setSomaTpcDiaAux([],[],[],[],[],[]).

setSomaTpcDisciplina(_, _, 0).

setSomaTpcDisciplina(NTPCDisc, ListaTPCs, NDisciplinas):-
        NDisciplinas > 0,
        getTPCDisciplina(ListaTPCs, NDisciplinas, ListaTPCDisciplina),
        sum(ListaTPCDisciplina, #=<, NTPCDisc),
        NextNDisciplinas is NDisciplinas - 1,
        setSomaTpcDisciplina(NTPCDisc, ListaTPCs, NextNDisciplinas).

getTPCDisciplina([], _, []).

getTPCDisciplina([_, NDisciplina, Var|Ls], NDisciplina, [Var|Ts]):-
        getTPCDisciplina(Ls, NDisciplina, Ts).

getTPCDisciplina([_, NDisciplina1, _|Ls], NDisciplina2, ListaTPCDisciplina):-
        NDisciplina1 =\= NDisciplina2,
        getTPCDisciplina(Ls, NDisciplina2, ListaTPCDisciplina).