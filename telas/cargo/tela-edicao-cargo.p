DEF VAR wconfirmaroperacao AS LOG           NO-UNDO.
DEF VAR wcargoanterior     LIKE cargo.cargo NO-UNDO.

PROMPT-FOR cargo.id COLUMN-LABEL 'Identificador do cargo' 
WITH FRAME inputcargoframe CENTERED.

FIND cargo EXCLUSIVE-LOCK USING  cargo.id NO-ERROR.

ASSIGN wcargoanterior = cargo.cargo.

HIDE FRAME inputcargoframe.


IF AVAILABLE cargo 
THEN DO:
    
    {includes/cargo/formulario-cadastro-edicao.i}
    
    UPDATE 
        cargo.cargo
    WITH TITLE 'Edicao de cargo' FRAME edicaocargoframe 1 COL CENTERED .
    
    MESSAGE 'Deseja confirmar a edicao do cargo?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME edicaocargoframe.
    
    IF wconfirmaroperacao
    THEN DO:
        RUN telas/cargo/tela-escolha-cargo.p.
    END.
    ELSE DO:
        ASSIGN cargo.cargo = wcargoanterior. 
        RUN telas/cargo/tela-escolha-cargo.p.   
    END.
END.
ELSE
DO:
    MESSAGE 'Cargo nao encontrado, por favor tente novamente outro codigo'
    VIEW-AS ALERT-BOX.
    RUN telas/cargo/tela-escolha-cargo.p.
END.









