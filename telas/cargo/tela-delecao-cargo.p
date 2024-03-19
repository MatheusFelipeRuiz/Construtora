DEF VAR wconfirmaroperacao AS LOG.

PROMPT-FOR cargo.id COLUMN-LABEL 'Identificador do cargo' 
WITH FRAME inputcargoframe CENTERED.

FIND cargo EXCLUSIVE-LOCK USING  cargo.id NO-ERROR.

HIDE FRAME inputcargoframe.

IF AVAILABLE cargo
THEN DO:
    
    {includes/cargo/formulario-delecao.i}
    
    DISP 
        cargo.cargo 
    WITH TITLE 'Deletar - Cargo' FRAME displaycargoframe CENTERED.
    
    MESSAGE 'Deseja deletar esse cargo?' 
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao .
    
    
    HIDE FRAME displaycargoframe.
    
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
   MESSAGE 'Nenhum cargo disponivel com esse identificador'
   VIEW-AS ALERT-BOX.
   
   RUN telas/cargo/tela-escolha-cargo.p. 
END.