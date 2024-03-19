DEF VAR wqtdefuncionarioslistagem AS INT           NO-UNDO INIT 5.
DEF VAR wultimoidentificador      LIKE cidade.id   NO-UNDO.
DEF VAR wconfirmaroperacao        AS LOG           NO-UNDO.



FIND LAST cidade NO-LOCK NO-ERROR.

IF AVAILABLE cidade 
THEN DO:
    ASSIGN wultimoidentificador = cidade.id + 1.    
END.
ELSE
DO:
    ASSIGN wultimoidentificador = 1.
END.

CREATE cidade.

ASSIGN cidade.id = wultimoidentificador.

{includes/cidade/formulario-cadastro-edicao-cidade.i}

UPDATE
    cidade.cidade
    HELP 'A cidade deve ter entre 3 a 30 caracteres'
    VALIDATE(LENGTH (cidade.cidade) >= 3 AND LENGTH (cidade.cidade) <= 30, 'A cidade deve ter entre 3 a 30 caracteres')

    WITH FRAME cadastrocidadeframe TITLE 'Cadastro - cidade' CENTERED.

MESSAGE 'Confirma o cadastro da cidade?'
VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.

HIDE FRAME cadastrocidadeframe.

IF wconfirmaroperacao
THEN DO:
    HIDE.
    RUN telas/cidade/tela-escolha-cidade.p.
END.
ELSE DO:
    DELETE cidade.
    HIDE.
    RUN telas/cidade/tela-escolha-cidade.p.
END.
