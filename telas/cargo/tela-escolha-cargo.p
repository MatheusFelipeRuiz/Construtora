DEF VAR wopcoesdisponiveis AS INT EXTENT 4  INIT [0, 1, 2, 3] NO-UNDO.
DEF VAR wopcaoescolhida    AS INT FORMAT '9'                  NO-UNDO.

FORM SKIP(2)
'1) Cadastrar cargo'    AT 30 SKIP (1)
'2) Editar cargo'       AT 30 SKIP(1)
'3) Deletar cargo'      AT 30 SKIP(1)
'0) Sair'               AT 30 SKIP(2)
'Opcao desejada: '      AT 30
WITH TITLE 'Construtora - Cargos' CENTERED WIDTH 100.

UPDATE wopcaoescolhida NO-LABELS
HELP 'Escolha uma das opcoes entre 0 e 3'
VALIDATE (wopcaoescolhida >= 0 AND wopcaoescolhida <= (EXTENT (wopcoesdisponiveis) - 1), 'Escolha uma das opcoes entre 0 e 3').

HIDE. 
CASE wopcaoescolhida:
    WHEN 0 THEN RUN telas/tela-principal.p.
    WHEN 1 THEN RUN telas/cargo/tela-cadastro-cargo.p.
    WHEN 2 THEN RUN telas/cargo/tela-edicao-cargo.p.
    WHEN 3 THEN RUN telas/cargo/tela-delecao-cargo.p.
END CASE.

