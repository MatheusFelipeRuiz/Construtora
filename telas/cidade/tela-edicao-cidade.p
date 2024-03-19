DEF VAR wqtdefuncionarioslistagem AS INT           NO-UNDO INIT 5.
DEF VAR wultimoidentificador      LIKE cidade.id   NO-UNDO.
DEF VAR wconfirmaroperacao        AS LOG           NO-UNDO.
DEF VAR wnomecidade               AS CHAR          NO-UNDO.


FIND LAST cidade NO-LOCK NO-ERROR.


PROMPT-FOR cidade.id LABEL 'Identificador cidade' WITH  FRAME inputcidadeframe CENTERED.
FIND cidade USING cidade.id EXCLUSIVE-LOCK NO-ERROR.


HIDE FRAME inputcidadeframe.

IF AVAILABLE cidade 
THEN DO: 

    {includes/cidade/formulario-cadastro-edicao-cidade.i}
    
    UPDATE
        cidade.cidade
        HELP 'A cidade deve ter entre 3 a 30 caracteres'
        VALIDATE(LENGTH (cidade.cidade) >= 3 AND LENGTH (cidade.cidade) <= 30, 'A cidade deve ter entre 3 a 30 caracteres')
        WITH FRAME cadastrocidadeframe TITLE 'Cadastro - cidade' CENTERED.
    
    MESSAGE 'Confirma a edicao da cidade?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME cadastrocidadeframe.
    
    IF wconfirmaroperacao
    THEN DO:
        HIDE.
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
    ELSE DO:
        HIDE.
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
END.


MESSAGE 'Nenhuma cidade encontrada com esse ID'
VIEW-AS ALERT-BOX.
RUN telas/cidade/tela-escolha-cidade.p. 

