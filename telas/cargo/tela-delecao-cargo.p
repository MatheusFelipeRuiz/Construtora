DEF VAR wconfirmaroperacao AS LOG.

PROMPT-FOR cargo.id COLUMN-LABEL 'Identificador do cargo' 
WITH FRAME id-cargo-frame CENTERED.

FIND cargo EXCLUSIVE-LOCK USING  cargo.id NO-ERROR.

HIDE FRAME id-cargo-frame.

IF AVAILABLE cargo
THEN DO:
    
    DISP cargo WITH FRAME cargo-frame.
    
    MESSAGE 'Deseja deletar esse cargo?' 
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao .
    
    
    HIDE FRAME cargo-frame.
    
    IF wconfirmaroperacao
    THEN DO:
        MESSAGE 'Cargo deletado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        
        DELETE cargo.
        RUN telas/cargo/tela-escolha-cargo.p.
    END.
    ELSE
    DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        
        RUN telas/cargo/tela-escolha-cargo.p.
    END.
       
END.
ELSE 
DO:
    
END.