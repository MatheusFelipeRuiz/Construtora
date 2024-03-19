DEF VAR wopcaodisponiveis      AS INT EXTENT 7 INIT [0, 1, 2, 3, 4, 5, 6]. 
DEF VAR wopcaoescolhida        AS INT FORMAT '9'.

FORM SKIP(2)
'1) Cadastrar, Editar ou deletar Funcionario' AT 30 SKIP (1)
'2) Cadastrar, Editar ou deletar Cargo'       AT 30 SKIP(1)
'3) Cadastrar, Editar ou deletar Cidade'      AT 30 SKIP(1)
'4) Cadastrar, Editar ou deletar Dependente'  AT 30 SKIP(1)
'5) Cadastrar, Editar ou deletar Ocupacoes'   AT 30 SKIP(1)
'6) Relatorios'                               AT 30 SKIP(1)
'7) Pesquisa por funcionario'                 AT 30 SKIP(1)
'0) Sair'                                     AT 30 SKIP(2)
'Opcao desejada: '                            AT 30
WITH TITLE 'Construtora - Menu Principal' CENTERED
ROW 5 WIDTH 100.

UPDATE wopcaoescolhida NO-LABELS
HELP 'Escolha uma das opcoes entre 0 e 6'
VALIDATE (wopcaoescolhida >= 0 AND wopcaoescolhida <= EXTENT (wopcaodisponiveis), 'Escolha uma das opcoes entre 0 e 6').

CASE wopcaoescolhida:
    WHEN 1 THEN RUN telas/funcionario/tela-escolha-funcionario.p.
    WHEN 2 THEN RUN telas/cargo/tela-escolha-cargo.p.
    WHEN 3 THEN RUN telas/cidade/tela-escolha-cidade.p.
    WHEN 4 THEN RUN telas/dependente/tela-escolha-dependente.p.
    WHEN 5 THEN RUN telas/ocupacoes/tela-escolha-ocupacao.p.
    WHEN 6 THEN RUN telas/relatorio/tela-escolha-relatorio.p.
END CASE.
    
