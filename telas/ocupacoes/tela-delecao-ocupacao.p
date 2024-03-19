DEF VAR widocupacao      AS INT NO-UNDO.
DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.


    
UPDATE widocupacao LABEL 'Identificador ocupacao' 
WITH  FRAME formpesquisaframe ROW 5 CENTERED TITLE 'Pesquisa por ID'.

HIDE FRAME  formpesquisaframe.

FIND ocupacao EXCLUSIVE-LOCK WHERE ocupacao.id = widocupacao.

IF AVAILABLE ocupacao
THEN DO:
    FIND funcionario WHERE funcionario.id = ocupacao.func_id  NO-ERROR.
    FIND cargo       WHERE cargo.id       = ocupacao.cargo_id NO-ERROR. 
    
    {includes/ocupacao/formulario-cadastro-edicao-ocupacao.i}
        
    DISP 
        ocupacao.id
        funcionario.nome_completo
        ocupacao.salario
        cargo.cargo
        ocupacao.data_inicio
        ocupacao.data_final 
    WITH FRAME ocupacaoframe 1 COL CENTERED TITLE 'Ocupacao'.

    MESSAGE 'Deseja deletar a ocupacao informado?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME ocupacaoframe.
    
    IF wconfirmaroperacao
    THEN DO:
        DELETE ocupacao.
        MESSAGE 'Ocupacao deletado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/ocupacoes/tela-escolha-ocupacao.p.
    END.
    ELSE DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/ocupacoes/tela-escolha-ocupacao.p.
    END.
END.





