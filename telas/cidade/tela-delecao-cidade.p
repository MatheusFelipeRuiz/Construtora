DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.




PROMPT-FOR cidade.id LABEL 'Identificador cidade' WITH  FRAME inputcidadeframe CENTERED.
FIND cidade USING cidade.id EXCLUSIVE-LOCK NO-ERROR.


HIDE FRAME inputcidadeframe.

IF AVAILABLE cidade
THEN DO:
    
    {includes/cidade/formulario-cadastro-edicao-cidade.i}
        
    DISP 
        cidade.id
        cidade.cidade
    WITH FRAME cidadeframe 1 COL CENTERED TITLE 'Cidade'.

    MESSAGE 'Deseja deletar a cidade informada?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME cidadeframe.
    
    IF wconfirmaroperacao
    THEN DO:
        DELETE cidade.
        MESSAGE 'Cidade deletada com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
    ELSE DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/cidade/tela-escolha-cidade.p.
    END.
END.

MESSAGE 'Nenhuma cidade encontrada com esse ID'
VIEW-AS ALERT-BOX.
RUN telas/cidade/tela-escolha-cidade.p. 





