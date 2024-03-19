DEF VAR wopcaoescolhida AS LOG FORMAT 'sim/nao' INIT 'nao'.

FORM SKIP(2)
'Bem-vindo ao menu principal, deseja comecar o programa?' AT 1 SKIP(2)
'Opcao desejada: '                                        AT 15
WITH TITLE 'Construtora - Tela Inicial' CENTERED.

UPDATE wopcaoescolhida
HELP 'Escolha a opcao sim ou nao' NO-LABELS
VALIDATE (NOT (LOOKUP(wopcaoescolhida, 'sim,nao') = 0), 'Por favor, escolha a opcao sim ou nao').

HIDE.

IF wopcaoescolhida
THEN RUN telas/tela-principal.p.          
ELSE RUN telas/tela-programa-finalizado.p.
