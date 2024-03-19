DEF VAR wultimoidentificador AS INT NO-UNDO.
DEF VAR wconfirmaroperacao   AS LOG NO-UNDO.

FIND LAST  cargo NO-LOCK NO-ERROR.
ASSIGN wultimoidentificador = cargo.id + 1.

DO TRANSACTION:
    CREATE cargo.
    ASSIGN cargo.id = wultimoidentificador.
    
    {includes/cargo/formulario-cadastro-edicao.i}
    MESSAGE 'Confirma o cadastro do cargo?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    IF wconfirmaroperacao 
    THEN DO:
        HIDE.
        RUN telas/cargo/tela-escolha-cargo.p.
    END.
    ELSE DO:
        DELETE cargo.
        HIDE.
        RUN telas/cargo/tela-edicao-cargo.p.
    END.
END. 