DEF VAR wnomecompleto             AS CHAR FORMAT 'x(90)' NO-UNDO.
DEF VAR wqtderegistrosencontrados AS INT                 NO-UNDO.
DEF VAR wconfirmaroperacao        AS LOG                 NO-UNDO. 

DEF VAR wnomecompletooriginal     LIKE funcionario.nome_completo   NO-UNDO.
DEF VAR wdatanascoriginal         LIKE funcionario.data_nascimento NO-UNDO.
DEF VAR wcpforiginal              LIKE funcionario.cpf             NO-UNDO.
DEF VAR wrgoriginal               LIKE funcionario.rg              NO-UNDO.
DEF VAR wsexooriginal             LIKE funcionario.sexo            NO-UNDO.
DEF VAR wcidadeoriginal           LIKE funcionario.cidade_id       NO-UNDO.
DEF VAR wdemitidooriginal         LIKE funcionario.demitido        NO-UNDO.

PROMPT-FOR funcionario.id  COLUMN-LABEL 'Identificador do funcionario' 
WITH FRAME funcionarioframe CENTERED.

FIND funcionario USING funcionario.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME funcionarioframe.

IF AVAILABLE funcionario
THEN DO:
    ASSIGN 
           wnomecompletooriginal = funcionario.nome_completo
           wdatanascoriginal     = funcionario.data_nascimento
           wcpforiginal          = funcionario.cpf
           wrgoriginal           = funcionario.rg
           wsexooriginal         = funcionario.sexo
           wcidadeoriginal       = funcionario.cidade_id
           wdemitidooriginal     = funcionario.demitido.
           
    {includes/funcionario/formulario-cadastro-edicao.i &titulo='Edicao'}

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
        
    WITH TITLE 'Edicao Funcionario' CENTERED FRAME cadastrofuncframe WIDTH 110.
        
    MESSAGE 'Confirma a edicao do funcionario?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
        
    HIDE FRAME cadastrofuncframe.
      
    IF wconfirmaroperacao 
    THEN DO:
        MESSAGE 'Funcionario editado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
    ELSE 
    DO:
        ASSIGN 
        funcionario.nome_completo   = wnomecompletooriginal
        funcionario.data_nascimento = wdatanascoriginal
        funcionario.cpf             = wcpforiginal
        funcionario.rg              = wrgoriginal
        funcionario.sexo            = wsexooriginal
        funcionario.cidade_id       = wcidadeoriginal
        funcionario.demitido        = wdemitidooriginal.
        
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
END.

MESSAGE 'Nenhum funcionario encontrado com o ID informado'
VIEW-AS ALERT-BOX. 
