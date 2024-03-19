DEF VAR wqtdecidadeslistagem AS INT             INIT 5             NO-UNDO.
DEF VAR wconfirmaroperacao   AS LOG                                NO-UNDO.
DEF VAR wcidadeanterior      LIKE cidade.cidade                    NO-UNDO.


FIND LAST cidade NO-LOCK NO-ERROR.

PROMPT-FOR cidade.id LABEL 'Identificador cidade' WITH  FRAME inputcidadeframe CENTERED.
FIND cidade USING cidade.id EXCLUSIVE-LOCK NO-ERROR.


HIDE FRAME inputcidadeframe.

IF AVAILABLE cidade 
THEN DO: 
    
    ASSIGN 
            wcidadeanterior = cidade.cidade.
            
    {includes/cidade/formulario-cadastro-edicao.i}
    
    UPDATE
        cidade.cidade
        HELP 'A cidade deve ter entre 3 a 30 caracteres'
        VALIDATE(LENGTH (cidade.cidade) >= 3 AND LENGTH (cidade.cidade) <= 30, 'A cidade deve ter entre 3 a 30 caracteres')
        WITH FRAME edicaocidadeframe TITLE 'Edicao - cidade' CENTERED.
    
    MESSAGE 'Confirma a edicao da cidade?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME edicaocidadeframe.
    
    IF wconfirmaroperacao
    THEN DO:
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
    ELSE 
    DO:
        ASSIGN cidade = wcidadeanterior.
        
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
