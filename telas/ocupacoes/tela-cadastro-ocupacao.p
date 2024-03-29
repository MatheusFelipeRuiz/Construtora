DEF VAR wqtdefuncionarioslistagem AS INT           NO-UNDO INIT 5.
DEF VAR wultimoidentificador    LIKE ocupacao.id   NO-UNDO.
DEF VAR wconfirmaroperacao      AS LOG             NO-UNDO.



FIND LAST ocupacao NO-LOCK NO-ERROR.

IF AVAILABLE ocupacao 
THEN DO:
    ASSIGN wultimoidentificador = ocupacao.id + 1.    
END.
ELSE
DO:
    ASSIGN wultimoidentificador = 1.
END.

CREATE ocupacao.

ASSIGN ocupacao.id = wultimoidentificador.

{includes/ocupacao/formulario-cadastro-edicao-ocupacao.i}

UPDATE
    ocupacao.func_id        COLUMN-LABEL 'Func. ID'
    HELP 'Digite um identificador de um funcionario ja cadastrado'
    VALIDATE (CAN-FIND (FIRST funcionario WHERE funcionario.id = ocupacao.func_id) ,
    'Deve ser inserido um ID de funcionario ja cadastrado')

    ocupacao.salario        COLUMN-LABEL 'Salario'
    HELP 'Digite um valor positivo maior do que zero'
    VALIDATE(ocupacao.salario > 0, 'O salario deve ser positivo e maior do que zero')

    ocupacao.cargo_id       COLUMN-LABEL 'Cargo. ID'
    HELP 'Digite um identificador de cargo ja cadastrado'
    VALIDATE
    (CAN-FIND (FIRST cargo WHERE cargo.id = ocupacao.cargo_id),
    'Deve ser inserido um ID de cargo ja cadastrado')

    ocupacao.data_inicio    COLUMN-LABEL 'Data Inicio'
    HELP 'Digite uma data de inicio da ocupacao valida'

    ocupacao.data_final     COLUMN-LABEL 'Data Fim'
    HELP 'Digite uma data de encerramento maior do que a data de inicio'

    WITH FRAME cadastroocupacaoframe TITLE 'Cadastro - ocupacao' CENTERED.

MESSAGE 'Confirma o cadastro da ocupacao?'
VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.

HIDE FRAME cadastroocupacaoframe.

IF wconfirmaroperacao
THEN DO:
    HIDE.
    RUN telas/ocupacoes/tela-escolha-ocupacao.p.
END.
ELSE DO:
    DELETE ocupacao.
    HIDE.
    RUN telas/ocupacoes/tela-escolha-ocupacao.p.
END.
