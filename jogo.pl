% vim: set ft=prolog:

:- use_module(library(plunit)).

% Um jogo é representado por uma estrutura jogo com 3 argumentos. O primeiro é
% o número de linhas (L), o segundo o número de colunas (C) e o terceiro uma
% lista (Blocos - de tamanho linhas x colunas) com os blocos do jogo. Nessa
% representação os primeiros L elementos da lista Blocos correspondem aos
% blocos da primeira linha do jogo, os próximos L blocos correspondem aos
% blocos da segunda linha do jogo e assim por diante.
%
% Dessa forma, em jogo com 3 linhas e 5 colunas (total de 15 blocos), os
% blocos são indexados da seguinte forma:
%
%  0  1  2  3  4
%  5  6  7  8  9
% 10 11 12 13 14
%
% Cada bloco é representado por uma estrutura bloco com 4 argumentos. Os
% argumentos representam os valores da borda superior, direita, inferior e
% esquerda (sentido horário começando do topo). Por exemplo o bloco
%
% |  3  |
% |4   6|  é representado por bloco(3, 6, 7, 4).
% |  7  |
%
% Dizemos que um bloco está em posição adequada se ...
% TODO: completar a descrição!



%% jogo_solucao(+JogoInicial, ?JogoFinal) is semidet
%
%  Verdadeiro se JogoInicial é uma estrutura jogo(L, C, Blocos) e JogoFinal é
%  uma estrutura jogo(L, C, Solucao), onde Solucao é uma solução válida para o
%  JogoInicial, isto é, os blocos que aparecem em Solucao são os mesmos de
%  Blocos e estão em posições adequadas.

jogo_solucao(JogoInicial, JogoFinal) :-
    jogo(L, C, Blocos) = JogoInicial,
    jogo(L, C, Solucao) = JogoFinal,
    blocos_adequados(JogoFinal),
    permutation(Blocos, Solucao).


:- begin_tests(pequeno).

test(j1x1, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 6, 7, 5)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(1, 1, Inicial), jogo(1, 1, Final)).


test(j2x2, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 4, 7, 9),
        bloco(6, 9, 5, 4),
        bloco(7, 6, 5, 2),
        bloco(5, 3, 1, 6)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(2, 2, Inicial), jogo(2, 2, Final)).

test(j3x3, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(7, 3, 4, 9),
        bloco(3, 4, 8, 3),
        bloco(7, 4, 2, 4),
        bloco(4, 4, 8, 5),
        bloco(8, 3, 6, 4),
        bloco(2, 2, 7, 3),
        bloco(8, 9, 1, 3),
        bloco(6, 6, 6, 9),
        bloco(7, 8, 5, 6)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(3, 3, Inicial), jogo(3, 3, Final)).

:- end_tests(pequeno).


:- begin_tests(medio).

test(j4x4, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(7, 7, 4, 8),
        bloco(3, 0, 2, 7),
        bloco(7, 9, 1, 0),
        bloco(1, 6, 3, 9),
        bloco(4, 2, 5, 5),
        bloco(2, 4, 5, 2),
        bloco(1, 5, 7, 4),
        bloco(3, 8, 0, 5),
        bloco(5, 5, 8, 0),
        bloco(5, 5, 9, 5),
        bloco(7, 6, 7, 5),
        bloco(0, 2, 1, 6),
        bloco(8, 7, 9, 5),
        bloco(9, 2, 8, 7),
        bloco(7, 3, 3, 2),
        bloco(1, 0, 4, 3)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(4, 4, Inicial), jogo(4, 4, Final)).

test(j5x5, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(1, 6, 7, 5),
        bloco(4, 0, 0, 6),
        bloco(9, 2, 0, 0),
        bloco(8, 3, 5, 2),
        bloco(0, 4, 5, 3),
        bloco(7, 1, 2, 6),
        bloco(0, 4, 5, 1),
        bloco(0, 0, 3, 4),
        bloco(5, 1, 1, 0),
        bloco(5, 3, 2, 1),
        bloco(2, 9, 1, 0),
        bloco(5, 5, 5, 9),
        bloco(3, 2, 2, 5),
        bloco(1, 0, 6, 2),
        bloco(2, 9, 0, 0),
        bloco(1, 0, 7, 0),
        bloco(5, 0, 7, 0),
        bloco(2, 4, 8, 0),
        bloco(6, 9, 4, 4),
        bloco(0, 0, 6, 9),
        bloco(7, 0, 2, 5),
        bloco(7, 2, 0, 0),
        bloco(8, 6, 1, 2),
        bloco(4, 4, 6, 6),
        bloco(6, 5, 8, 4)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(5, 5, Inicial), jogo(5, 5, Final)).

test(j6x6, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 0, 2, 4),
        bloco(9, 5, 5, 0),
        bloco(1, 1, 8, 5),
        bloco(4, 2, 0, 1),
        bloco(4, 3, 2, 2),
        bloco(8, 0, 0, 3),
        bloco(2, 2, 3, 9),
        bloco(5, 9, 1, 2),
        bloco(8, 2, 3, 9),
        bloco(0, 2, 3, 2),
        bloco(2, 9, 8, 2),
        bloco(0, 6, 9, 9),
        bloco(3, 1, 6, 9),
        bloco(1, 2, 2, 1),
        bloco(3, 0, 8, 2),
        bloco(3, 5, 8, 0),
        bloco(8, 7, 8, 5),
        bloco(9, 4, 8, 7),
        bloco(6, 0, 6, 9),
        bloco(2, 4, 5, 0),
        bloco(8, 7, 6, 4),
        bloco(8, 3, 7, 7),
        bloco(8, 7, 2, 3),
        bloco(8, 7, 1, 7),
        bloco(6, 3, 9, 0),
        bloco(5, 1, 9, 3),
        bloco(6, 9, 8, 1),
        bloco(7, 7, 0, 9),
        bloco(2, 0, 6, 7),
        bloco(1, 3, 7, 0),
        bloco(9, 9, 8, 7),
        bloco(9, 0, 6, 9),
        bloco(8, 1, 6, 0),
        bloco(0, 9, 7, 1),
        bloco(6, 1, 7, 9),
        bloco(7, 8, 1, 1)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(6, 6, Inicial), jogo(6, 6, Final)).

:- end_tests(medio).


:- begin_tests(grande).

test(j7x7, [nondet, Blocos = Final]) :-
    Blocos = [
        bloco(4, 1, 0, 8),
        bloco(7, 8, 1, 1),
        bloco(0, 3, 5, 8),
        bloco(4, 0, 9, 3),
        bloco(9, 7, 1, 0),
        bloco(6, 8, 3, 7),
        bloco(3, 5, 2, 8),
        bloco(0, 9, 5, 8),
        bloco(1, 4, 9, 9),
        bloco(5, 1, 6, 4),
        bloco(9, 3, 1, 1),
        bloco(1, 5, 6, 3),
        bloco(3, 3, 2, 5),
        bloco(2, 0, 4, 3),
        bloco(5, 1, 8, 8),
        bloco(9, 6, 8, 1),
        bloco(6, 5, 2, 6),
        bloco(1, 8, 6, 5),
        bloco(6, 4, 9, 8),
        bloco(2, 8, 2, 4),
        bloco(4, 1, 8, 8),
        bloco(8, 1, 5, 4),
        bloco(8, 2, 0, 1),
        bloco(2, 0, 2, 2),
        bloco(6, 4, 8, 0),
        bloco(9, 7, 7, 4),
        bloco(2, 8, 5, 7),
        bloco(8, 0, 7, 8),
        bloco(5, 6, 0, 8),
        bloco(0, 9, 4, 6),
        bloco(2, 2, 2, 9),
        bloco(8, 9, 5, 2),
        bloco(7, 1, 5, 9),
        bloco(5, 2, 0, 1),
        bloco(7, 9, 6, 2),
        bloco(0, 7, 5, 8),
        bloco(4, 7, 5, 7),
        bloco(2, 9, 1, 7),
        bloco(5, 7, 5, 9),
        bloco(5, 5, 4, 7),
        bloco(0, 8, 5, 5),
        bloco(6, 8, 7, 8),
        bloco(5, 7, 9, 6),
        bloco(5, 0, 2, 7),
        bloco(1, 4, 6, 0),
        bloco(5, 3, 2, 4),
        bloco(4, 9, 6, 3),
        bloco(5, 8, 1, 9),
        bloco(7, 8, 0, 8)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(7, 7, Inicial), jogo(7, 7, Final)).

:- end_tests(grande).


%% blocos_adequados(?Jogo) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), e todos os blocos de
%  Blocos estão em posições adequadas.
%
%  TODO: adicionar os exemplos
:- begin_tests(blocos_adequados).

test(blocos_adequados_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    blocos_adequados(Jogo).

test(blocos_adequados_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    blocos_adequados(Jogo).

test(blocos_adequados_3) :-
    jogo(3, 3, [bloco(7, 3, 4, 9), bloco(3, 4, 8, 3), bloco(7, 4, 2, 4), bloco(4, 4, 8, 5), bloco(8, 3, 6, 4), bloco(2, 2, 7, 3), bloco(8, 9, 1, 3), bloco(6, 6, 6, 9), bloco(7, 8, 5, 6)]) = Jogo,
    blocos_adequados(Jogo).

:- end_tests(blocos_adequados).

blocos_adequados(Jogo) :-
    Jogo = jogo(_, _, Blocos),
    length(Blocos, Tam),
    blocos_adequados(Jogo, Tam, 0).

blocos_adequados(Jogo, Tamanho, P) :-
    P >= Tamanho;
    bloco_adequado(Jogo, P),
    P1 is P + 1,
    blocos_adequados(Jogo, Tamanho, P1),
    !.

%% blocos_adequados(?Jogo, ?P) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), e o bloco na posição
%  P de Blocos está em uma posição adequada.
%
%  Exemplos para o predicado blocos_adequados/2:
:- begin_tests(bloco_adequado).

test(bloco_adequado_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    bloco_adequado(Jogo, 0).

test(bloco_adequado_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    bloco_adequado(Jogo, 0),
    bloco_adequado(Jogo, 1),
    bloco_adequado(Jogo, 2),
    bloco_adequado(Jogo, 3).

test(bloco_adequado_3) :-
    jogo(3, 3, [bloco(7, 3, 4, 9), bloco(3, 4, 8, 3), bloco(7, 4, 2, 4), bloco(4, 4, 8, 5), bloco(8, 3, 6, 4), bloco(2, 2, 7, 3), bloco(8, 9, 1, 3), bloco(6, 6, 6, 9), bloco(7, 8, 5, 6)]) = Jogo,
    bloco_adequado(Jogo, 0),
    bloco_adequado(Jogo, 1),
    bloco_adequado(Jogo, 2),
    bloco_adequado(Jogo, 3),
    bloco_adequado(Jogo, 4),
    bloco_adequado(Jogo, 5),
    bloco_adequado(Jogo, 6),
    bloco_adequado(Jogo, 7),
    bloco_adequado(Jogo, 8).

:- end_tests(bloco_adequado).

bloco_adequado(Jogo, P) :-
    borda_esquerda_adequada(Jogo, P),
    borda_superior_adequada(Jogo, P).

%% borda_esquerda_adequada(+Jogo, +P, +Borda) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), P é um número inteiro
%  não negativo que representa uma posição de Blocos, e Borda é um número
%  inteiro que representa a borda esquerda de um bloco, e a borda esquerda do
%  bloco na posição P é igual a Borda ou a borda direita do bloco na posição
%  P - 1 é igual a Borda.

:- begin_tests(borda_esquerda_adequada).

test(borda_esquerda_adequada_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    borda_esquerda_adequada(Jogo, 0),
    !.

test(borda_esquerda_adequada_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    borda_esquerda_adequada(Jogo, 0),
    borda_esquerda_adequada(Jogo, 1),
    borda_esquerda_adequada(Jogo, 2),
    borda_esquerda_adequada(Jogo, 3),
    !.

:- end_tests(borda_esquerda_adequada).

borda_esquerda_adequada(Jogo, P) :-
    limite_esquerda(Jogo, P),
    !.

borda_esquerda_adequada(Jogo, P) :-
    Esquerda is P - 1,
    posicao_bloco(Jogo, P, B1),
    posicao_bloco(Jogo, Esquerda, B2),
    bloco(_, _, _, R) = B1,
    bloco(_, R, _, _) = B2.

%% borda_superior_adequada(+Jogo, +P, +Borda) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), P é um número inteiro
%  não negativo que representa uma posição de Blocos, e Borda é um número
%  inteiro que representa a borda superior de um bloco, e a borda superior do
%  bloco na posição P é igual a Borda ou a borda inferior do bloco na posição
%  P - C é igual a Borda.

:- begin_tests(borda_superior_adequada).

test(borda_superior_adequada_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    borda_superior_adequada(Jogo, 0),
    !.

test(borda_superior_adequada_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    borda_superior_adequada(Jogo, 0),
    borda_superior_adequada(Jogo, 1),
    borda_superior_adequada(Jogo, 2),
    borda_superior_adequada(Jogo, 3),
    !.

:- end_tests(borda_superior_adequada).

borda_superior_adequada(Jogo, P) :-
    limite_acima(Jogo, P),
    !.

borda_superior_adequada(Jogo, P) :-
    jogo(_, C, _) = Jogo,
    Cima is P - C,
    posicao_bloco(Jogo, P, B1),
    posicao_bloco(Jogo, Cima, B2),
    bloco(U, _, _, _) = B1,
    bloco(_, _, U, _) = B2.

%% limite_esquerda(+Jogo, +P) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos) e P é um número
%  inteiro não negativo que representa uma posição de Blocos, e P está na
%  borda esquerda do Jogo.

:- begin_tests(limite_esquerda).

test(limite_esquerda_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    limite_esquerda(Jogo, 0).

test(limite_esquerda_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    limite_esquerda(Jogo, 0),
    limite_esquerda(Jogo, 2).

:- end_tests(limite_esquerda).

limite_esquerda(Jogo, P) :-
    jogo(_, C, _) = Jogo,
    0 is mod(P, C).


%% limite_acima(+Jogo, +P) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos) e P é um número
%  inteiro não negativo que representa uma posição de Blocos, e P está na
%  borda superior do Jogo.

:- begin_tests(limite_acima).

test(limite_acima_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    limite_acima(Jogo, 0).

test(limite_acima_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    limite_acima(Jogo, 0),
    limite_acima(Jogo, 1).

:- end_tests(limite_acima).

limite_acima(Jogo, P) :-
    jogo(_, C, _) = Jogo,
    P < C.

%% posicao_bloco(+Jogo, +P, -Bloco) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), P é um número
%  inteiro não negativo e Bloco é o bloco na posição P de Blocos.

%% posicao_bloco(+Jogo, +P, -Bloco) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), P é um número
%  inteiro não negativo e Bloco é o bloco na posição P de Blocos.

:- begin_tests(posicao_bloco).

test(posicao_bloco_1) :-
    jogo(1, 1, [bloco(3, 6, 7, 5)]) = Jogo,
    posicao_bloco(Jogo, 0, bloco(3, 6, 7, 5)),
    !.

test(posicao_bloco_2) :-
    jogo(2, 2, [bloco(3, 4, 7, 9), bloco(6, 9, 5, 4), bloco(7, 6, 5, 2), bloco(5, 3, 1, 6)]) = Jogo,
    posicao_bloco(Jogo, 0, bloco(3, 4, 7, 9)),
    posicao_bloco(Jogo, 1, bloco(6, 9, 5, 4)),
    posicao_bloco(Jogo, 2, bloco(7, 6, 5, 2)),
    posicao_bloco(Jogo, 3, bloco(5, 3, 1, 6)),
    !.

test(posicao_bloco_3) :-
    jogo(3, 3, [bloco(7, 3, 4, 9), bloco(3, 4, 8, 3), bloco(7, 4, 2, 4), bloco(4, 4, 8, 5), bloco(8, 3, 6, 4), bloco(2, 2, 7, 3), bloco(8, 9, 1, 3), bloco(6, 6, 6, 9), bloco(7, 8, 5, 6)]) = Jogo,
    posicao_bloco(Jogo, 0, bloco(7, 3, 4, 9)),
    posicao_bloco(Jogo, 1, bloco(3, 4, 8, 3)),
    posicao_bloco(Jogo, 2, bloco(7, 4, 2, 4)),
    posicao_bloco(Jogo, 3, bloco(4, 4, 8, 5)),
    posicao_bloco(Jogo, 4, bloco(8, 3, 6, 4)),
    posicao_bloco(Jogo, 5, bloco(2, 2, 7, 3)),
    posicao_bloco(Jogo, 6, bloco(8, 9, 1, 3)),
    posicao_bloco(Jogo, 7, bloco(6, 6, 6, 9)),
    posicao_bloco(Jogo, 8, bloco(7, 8, 5, 6)),
    !.

:- end_tests(posicao_bloco).

posicao_bloco(Jogo, P, bloco(Cima, Direita, Baixo, Esquerda)) :-
    jogo(_, _, Blocos) = Jogo,
    nth0(P, Blocos, bloco(Cima, Direita, Baixo, Esquerda)).
