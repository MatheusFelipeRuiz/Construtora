DEF VAR wnomecompleto             AS CHAR FORMAT 'x(90)'           NO-UNDO.
DEF VAR wqtderegistrosencontrados AS INT                           NO-UNDO.
DEF VAR wconfirmaroperacao        AS LOG                           NO-UNDO. 

DEF VAR wnomecompletoanterior     LIKE funcionario.nome_completo   NO-UNDO.
DEF VAR wdatanascanterior         LIKE funcionario.data_nascimento NO-UNDO.
DEF VAR wcpfanterior              LIKE funcionario.cpf             NO-UNDO.
DEF VAR wrganterior               LIKE funcionario.rg              NO-UNDO.
DEF VAR wsexoanterior             LIKE funcionario.sexo            NO-UNDO.
DEF VAR wcidadeanterior           LIKE funcionario.cidade_id       NO-UNDO.
DEF VAR wdemitidoanterior         LIKE funcionario.demitido        NO-UNDO.

PROMPT-FOR funcionario.id  COLUMN-LABEL 'Identificador do funcionario' 
WITH FRAME inputfuncionarioframe CENTERED.

FIND funcionario USING funcionario.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME inputfuncionarioframe.

IF AVAILABLE funcionario
THEN DO:
    ASSIGN 
           wnomecompletoanterior = funcionario.nome_completo
           wdatanascanterior     = funcionario.data_nascimento
           wcpfanterior          = funcionario.cpf
           wrganterior           = funcionario.rg
           wsexoanterior         = funcionario.sexo
           wcidadeanterior       = funcionario.cidade_id
           wdemitidoanterior     = funcionario.demitido.
           
    {includes/funcionario/formulario-cadastro-edicao.i}

    UPDATE 
        nome_completo   COLUMN-LABEL 'Nome Completo'
        HELP 'Digite um nome entre 2 a 90 caracteres'
        VALIDATE (LENGTH(nome_completo) >= 2 AND LENGTH(nome_completo) <= 90,'O nome deve ter entre 2 e 90 caracteres')
        
        data_nascimento COLUMN-LABEL 'Data Nasc.'
        HELP 'Digite uma data de nascimento valida'
        
        sexo            COLUMN-LABEL 'Sexo'
        HELP 'Escolha o sexo masculino ou feminino'
        
        cpf             COLUMN-LABEL 'CPF'
        HELP 'Digite um CPF valido de 11 digitos'
        VALIDATE 
        (LENGTH (cpf) = 11, 'Digite um cpf valido')
        
        rg              COLUMN-LABEL 'RG'
        HELP 'Digite um RG valido'
        VALIDATE (LENGTH (rg) > 6, 'Digite um rg valido ')  
        
        funcionario.demitido        LABEL  'Demitido?'
        HELP 'Digite sim ou nao'
        
        cidade_id       COLUMN-LABEL 'Cidade.ID'
        HELP 'Digite uma cidade ja cadastrada'
        VALIDATE  (CAN-FIND (FIRST cidade WHERE cidade.id = cidade_id), 'Digite uma cidade ja cadastrada' )
        
    WITH TITLE 'Edicao  - Funcionario' CENTERED FRAME edicaofuncionarioframe WIDTH 110.
        
    MESSAGE 'Confirma a edicao do funcionario?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
        
    HIDE FRAME edicaofuncionarioframe.
      
    IF wconfirmaroperacao 
    THEN DO:
        MESSAGE 'Funcionario editado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
    ELSE 
    DO:
        ASSIGN 
        funcionario.nome_completo   = wnomecompletoanterior
        funcionario.data_nascimento = wdatanascanterior
        funcionario.cpf             = wcpfanterior
        funcionario.rg              = wrganterior
        funcionario.sexo            = wsexoanterior
        funcionario.cidade_id       = wcidadeanterior
        funcionario.demitido        = wdemitidoanterior.
        
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
END.
ELSE 
DO:
    MESSAGE 'Nenhum funcionario encontrado com o ID informado'
    VIEW-AS ALERT-BOX.
END.
 
