DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.
DEF VAR wqtdefuncionarios   AS INT NO-UNDO.

PROMPT-FOR cidade.id LABEL 'Identificador cidade' WITH  FRAME inputcidadeframe CENTERED.
FIND cidade USING cidade.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME inputcidadeframe.

IF AVAILABLE cidade
THEN DO:
    
    {includes/cidade/formulario-delecao.i}
        
    DISP 
        cidade.id
        cidade.cidade
    WITH FRAME displaycidadeframe 1 COL CENTERED TITLE 'Cidade'.

    MESSAGE 'Deseja deletar a cidade informada?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME displaycidadeframe.
    
    FIND LAST funcionario WHERE funcionario.cidade_id = cidade.id NO-ERROR.
    
    IF wconfirmaroperacao AND NOT AVAILABLE funcionario
    THEN DO:
        DELETE cidade.
        MESSAGE 'Cidade deletada com sucesso!'
        VIEW-AS ALERT-BOX.
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
    ELSE IF wconfirmaroperacao AND AVAILABLE funcionario 
    THEN DO:
        
        FOR EACH funcionario NO-LOCK WHERE funcionario.cidade_id = cidade.id:
            ASSIGN wqtdefuncionarios = wqtdefuncionarios + 1.  
        END.
        
        IF wqtdefuncionarios > 1
        THEN DO:
            MESSAGE 
            'Erro, a cidade tem ' + STRING(wqtdefuncionarios) + ' funcionarios associados.'  SKIP(1)
            'Por favor, exclua primeiramente todos os funcionarios para deletar essa cidade'        
            VIEW-AS ALERT-BOX.
        END.
        ELSE
        DO:
            MESSAGE 
            'Erro, a cidade tem ' + STRING(wqtdefuncionarios) + ' funcionario associado.'    SKIP(1)
            'Por favor, exclua primeiramente esse funcionario para deletar essa cidade'        
            VIEW-AS ALERT-BOX.
        END.
        
        RUN telas/cidade/tela-escolha-cidade.p.
        
    END.
    ELSE DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
END.
ELSE 
DO:
    MESSAGE 'Nenhuma cidade encontrada com esse ID'
    VIEW-AS ALERT-BOX.
    RUN telas/cidade/tela-escolha-cidade.p. 
END.

 



