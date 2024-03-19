DEF VAR wopcaodisponiveis      AS INT EXTENT 7 INIT [0, 1, 2, 3, 4, 5, 6]. 
DEF VAR wopcaoescolhida        AS INT FORMAT '9'.


FORM SKIP(2)
'1) Quadro de funcionarios'                   AT 30 SKIP(1)
'2) Listagem de cargos'                       AT 30 SKIP(1)
'3) Listagem de ocupacoes'                    AT 30 SKIP(1)
'4) Listagem de cidades'                      AT 30 SKIP(1)
'5) Relatorio de Funcionarios/Dependentes'    AT 30 SKIP(1)
'0) Sair'                                     AT 30 SKIP(1)
'Opcao desejada: '                            AT 30
WITH TITLE 'Construtora - Relatorios' CENTERED
ROW 5 WIDTH 100.

UPDATE wopcaoescolhida NO-LABELS
HELP 'Escolha uma das opcoes entre 0 e 3'
VALIDATE (wopcaoescolhida >= 0 AND wopcaoescolhida <= (EXTENT (wopcaodisponiveis) - 1), 'Escolha uma das opcoes entre 0 e 3').

HIDE. 
CASE wopcaoescolhida:
    WHEN 0 THEN RUN telas/tela-principal.p.
    WHEN 1 THEN RUN telas/relatorio/relatorio-quadro-funcionarios.p.
    WHEN 2 THEN RUN telas/relatorio/relatorio-cargos.p.
    WHEN 3 THEN RUN telas/relatorio/relatorio-ocupacoes.p.
    WHEN 4 THEN RUN telas/relatorio/relatorio-cidades.p.
END CASE.


