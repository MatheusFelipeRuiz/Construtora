DEF VAR wultimoidentificador AS INT NO-UNDO.
DEF VAR wconfirmaroperacao   AS LOG NO-UNDO.

// Define o identificador do funcionario
FIND LAST  funcionario NO-LOCK NO-ERROR.
IF AVAILABLE funcionario THEN ASSIGN  wultimoidentificador = funcionario.id + 1.
ELSE                          ASSIGN  wultimoidentificador = 1. 



CREATE funcionario.
ASSIGN funcionario.id = wultimoidentificador.

{includes/funcionario/formulario-cadastro-edicao.i &titulo='Cadastro'}



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

        demitido        LABEL  'Demitido?'
        HELP 'Digite sim ou nao'
        
        cidade_id       COLUMN-LABEL 'Cidade.ID'
        HELP 'Digite uma cidade ja cadastrada'
        VALIDATE  (CAN-FIND (FIRST cidade WHERE cidade.id = cidade_id), 'Digite uma cidade ja cadastrada' )
        
 WITH TITLE 'Cadastro Funcionario' CENTERED FRAME cadastrofuncframe WIDTH 110.
 
funcionario.nome_completo = TRIM(funcionario.nome_completo).


HIDE FRAME cadastrofuncframe.

MESSAGE 'Confirma o cadastro do funcionario?'
VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.

IF wconfirmaroperacao THEN  RUN telas/funcionario/tela-escolha-funcionario.p.
ELSE DO:
    DELETE funcionario.
    HIDE.
    RUN telas/funcionario/tela-escolha-funcionario.p.
END.

 
