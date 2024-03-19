DEF VAR wconfirmaroperacao AS LOG   NO-UNDO.
DEF VAR wnomecargooriginal LIKE cargo.cargo NO-UNDO.

PROMPT-FOR cargo.id COLUMN-LABEL 'Identificador do cargo' 
WITH FRAME cargo-frame CENTERED.

FIND cargo EXCLUSIVE-LOCK USING  cargo.id NO-ERROR.

ASSIGN wnomecargooriginal = cargo.cargo.

HIDE FRAME cargo-frame.


IF AVAILABLE cargo 
THEN DO:
    UPDATE 
        cargo.cargo
    WITH FRAME form-cargo-frame 1 COL TITLE 'Edicao de cargo'.
    
    MESSAGE 'Deseja confirmar a edicao do cargo?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME form-cargo-frame.
    
    IF wconfirmaroperacao
    THEN DO:
        RUN telas/cargo/tela-escolha-cargo.p.
    END.
    ELSE DO:
        ASSIGN cargo.cargo = wnomecargooriginal. 
        RUN telas/cargo/tela-escolha-cargo.p.   
    END.
END.

MESSAGE 'Cargo nao encontrado, por favor tente novamente outro codigo'
VIEW-AS ALERT-BOX.
RUN telas/cargo/tela-escolha-cargo.p.









