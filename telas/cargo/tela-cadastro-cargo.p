DEF VAR wultimoidentificador AS INT NO-UNDO.
DEF VAR wconfirmaroperacao   AS LOG NO-UNDO.

// Define o identificador do cargo
FIND LAST  cargo NO-LOCK NO-ERROR.
IF AVAILABLE cargo THEN ASSIGN wultimoidentificador = cargo.id + 1.
ELSE                    ASSIGN wultimoidentificador = 1.

CREATE cargo.
ASSIGN cargo.id = wultimoidentificador.

{includes/cargo/formulario-cadastro-edicao.i}

UPDATE 
    cargo.cargo 
    WITH TITLE 'Cadastro - Cargo' FRAME cadastrocargoframe CENTERED. 

MESSAGE 'Confirma o cadastro do cargo?'
VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.

HIDE FRAME cadastrocargoframe.

IF wconfirmaroperacao 
THEN DO:
    RUN telas/cargo/tela-escolha-cargo.p.
END.
ELSE DO:
    DELETE cargo.
    RUN telas/cargo/tela-escolha-cargo.p.
END.
