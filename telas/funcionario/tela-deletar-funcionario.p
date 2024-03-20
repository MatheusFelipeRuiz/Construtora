DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.
DEF VAR wqtdeocupacoes      AS INT NO-UNDO.
DEF VAR wqtdedependentes    AS INT NO-UNDO.

PROMPT-FOR funcionario.id  COLUMN-LABEL 'Identificador do funcionario' 
WITH FRAME inputfuncionarioframe CENTERED.
FIND funcionario USING funcionario.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME inputfuncionarioframe.

IF AVAILABLE funcionario
THEN DO:
    
    {includes/funcionario/formulario-delecao.i}
    
    DISP 
        funcionario.id
        funcionario.nome_completo
        funcionario.data_nascimento
        funcionario.sexo
        funcionario.cpf
    WITH 1 COL FRAME displayfuncionarioframe CENTERED TITLE 'Funcionario'. 
            
    MESSAGE 'Deseja deletar o funcionario informado?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME displayfuncionarioframe.
    
    
    FIND ocupacao   WHERE ocupacao.func_id   = funcionario.id NO-ERROR.
    FIND dependente WHERE dependente.func_id = funcionario.id NO-ERROR.
    
    
    
    IF wconfirmaroperacao AND NOT AVAILABLE ocupacao AND NOT AVAILABLE dependente
    THEN DO:
        DELETE funcionario.
        MESSAGE 'Funcionario deletado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
    ELSE IF wconfirmaroperacao AND  AVAILABLE ocupacao 
    THEN DO:
        FOR EACH ocupacao WHERE ocupacao.func_id = funcionario.id:
            ASSIGN wqtdeocupacoes = wqtdeocupacoes + 1.
        END.
        
        IF wqtdeocupacoes > 1
        THEN DO:
            MESSAGE 
            'Erro, esse funcionario tem uma ' + STRING(wqtdeocupacoes) + ' ocupacoes associadas.' SKIP(1)
            'Por favor, exclua primeiramente todas as ocupacoes desse funcionario' 
            VIEW-AS ALERT-BOX.
        END.
        ELSE 
        DO:
            MESSAGE 
            'Erro, esse funcionario tem uma ' + STRING(wqtdeocupacoes) + ' ocupacao associada.'   SKIP(1)
            'Por favor, exclua primeiramente essa ocupacao  desse funcionario' 
            VIEW-AS ALERT-BOX.
        END.

        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
    ELSE IF wconfirmaroperacao AND AVAILABLE dependente
    THEN DO:
        FOR EACH dependente WHERE dependente.func_id = funcionario.id:
            ASSIGN wqtdedependentes = wqtdedependentes + 1.
        END.
        
        IF wqtdedependentes > 1
        THEN DO:
            MESSAGE 
            'Erro, esse funcionario tem  ' + STRING(wqtdedependentes) + ' dependentes associados.' SKIP(1)
            'Por favor, exclua primeiramente todas os dependentes desse funcionario' 
            VIEW-AS ALERT-BOX.
        END. 
        ELSE
        DO:
            MESSAGE 
            'Erro, esse funcionario tem um ' + STRING(wqtdedependentes) + ' dependente associado.' SKIP(1)
            'Por favor, exclua primeiramente esse dependente desse funcionario' 
            VIEW-AS ALERT-BOX.
        END.
        
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
    ELSE DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
END.
ELSE 
DO:
    MESSAGE 'Nenhum funcionario disponivel com esse identificador'
    VIEW-AS ALERT-BOX.
    RUN telas/funcionario/tela-escolha-funcionario.p.
END.



