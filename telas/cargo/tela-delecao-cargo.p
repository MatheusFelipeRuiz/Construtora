DEF VAR wconfirmaroperacao AS LOG.
DEF VAR wqtdeocupacoes     AS INT.


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
    
    FIND LAST ocupacao WHERE ocupacao.cargo_id = cargo.id NO-ERROR.
    
    
    IF wconfirmaroperacao AND NOT AVAILABLE ocupacao
    THEN DO:
        MESSAGE 'Cargo deletado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        DELETE cargo.
    END.
    ELSE IF wconfirmaroperacao AND AVAILABLE ocupacao
    THEN DO: 
        
        FOR EACH ocupacao NO-LOCK WHERE ocupacao.cargo_id = cargo.id:
            ASSIGN wqtdeocupacoes = wqtdeocupacoes + 1.
        END.
        
        IF wqtdeocupacoes > 1
        THEN DO:
            MESSAGE 
            'Erro, esse cargo tem ' + STRING(wqtdeocupacoes) + ' ocupacoes associadas.'    SKIP(1)
            'Por favor, exclua primeiramente todos as ocupacoes para deletar esse cargo' 
            VIEW-AS ALERT-BOX.
        END.
        ELSE 
        DO:
            MESSAGE 
            'Erro, esse cargo tem uma ' + STRING(wqtdeocupacoes) + ' ocupacao associada.'  SKIP(1)
            'Por favor, exclua primeiramente essa ocupacao para deletar esse cargo' 
            VIEW-AS ALERT-BOX.
        END.
    END.
    ELSE
    DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
    END.
       
END.
ELSE 
DO:
   MESSAGE 'Nenhum cargo disponivel com esse identificador'
   VIEW-AS ALERT-BOX.
END.

RUN telas/cargo/tela-escolha-cargo.p.