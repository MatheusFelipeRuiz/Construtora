DEF VAR wnomecompleto             AS CHAR FORMAT 'x(90)' NO-UNDO.
DEF VAR wqtderegistrosencontrados AS INT                 NO-UNDO.
DEF VAR wconfirmaroperacao        AS LOG                 NO-UNDO. 

DEF VAR wnomecompletooriginal     LIKE dependente.nome_completo   NO-UNDO.
DEF VAR wdatanascoriginal         LIKE dependente.data_nascimento NO-UNDO.
DEF VAR wcpforiginal              LIKE dependente.cpf             NO-UNDO.
DEF VAR wrgoriginal               LIKE dependente.rg              NO-UNDO.
DEF VAR wsexooriginal             LIKE dependente.sexo            NO-UNDO.
DEF VAR wenderecooriginal         LIKE dependente.endereco        NO-UNDO.
DEF VAR wfuncidoriginal           LIKE dependente.func_id         NO-UNDO.
DEF VAR wgrauparentescooriginal   LIKE dependente.parentesco_id   NO-UNDO.

PROMPT-FOR dependente.id  COLUMN-LABEL 'Identificador do dependente' 
WITH FRAME dependenteframe CENTERED.

FIND dependente USING dependente.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME dependenteframe.

IF AVAILABLE dependente
THEN DO:
    ASSIGN 
           wnomecompletooriginal    = dependente.nome_completo
           wdatanascoriginal        = dependente.data_nascimento
           wcpforiginal             = dependente.cpf
           wrgoriginal              = dependente.rg
           wfuncidoriginal          = dependente.func_id
           wsexooriginal            = dependente.sexo
           wenderecooriginal        = dependente.endereco
           wgrauparentescooriginal  = dependente.parentesco_id.
           
    {includes/dependente/formulario-cadastro-edicao.i}

    UPDATE 
        nome_completo   
        HELP 'Digite um nome entre 2 a 90 caracteres'
        VALIDATE (LENGTH(nome_completo) >= 2 AND LENGTH(nome_completo) <= 90,'O nome deve ter entre 2 e 90 caracteres')
            
        data_nascimento 
        HELP 'Digite uma data de nascimento valida'
            
        sexo            
        HELP 'Escolha o sexo masculino ou feminino'
    
        cpf             
        HELP 'Digite um CPF valido de 11 digitos'
        VALIDATE 
        (LENGTH (cpf) = 11, 'Digite um cpf valido')
            
        rg              
        HELP 'Digite um RG valido'
        VALIDATE (LENGTH (rg) > 6, 'Digite um rg valido ')  
    
        parentesco_id
        HELP 'Digite um ID grau de parentesco já cadastrado'
        VALIDATE
        (CAN-FIND (FIRST tipo_parentesco WHERE tipo_parentesco.id = parentesco_id),
        'Deve ser inserido um ID de parantesco ja cadastrado')

        func_id
        HELP 'Digite um ID de funcionario existente'
        VALIDATE
        (CAN-FIND (FIRST funcionario WHERE funcionario.id = func_id),
        'Deve ser inserido um ID de funcionario ja cadastrado')
            
        endereco
        HELP 'Digite um endereco com no maximo 80 caracteres'
        VALIDATE (LENGTH (endereco) <= 80, 'Por favor, digite um endereco com no máximo 80 caracteres')
                
        
    WITH SIDE-LABELS  TITLE 'Edicao dependente' CENTERED FRAME edicaodepframe.
        
    MESSAGE 'Confirma a edicao do dependente?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
        
    HIDE FRAME edicaodepframe.
      
    IF wconfirmaroperacao 
    THEN DO:
        MESSAGE 'dependente editado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/dependente/tela-escolha-dependente.p.
    END.
    
    ASSIGN 
    dependente.nome_completo   = wnomecompletooriginal
    dependente.data_nascimento = wdatanascoriginal
    dependente.cpf             = wcpforiginal
    dependente.rg              = wrgoriginal
    dependente.sexo            = wsexooriginal
    dependente.endereco        = wenderecooriginal
    dependente.func_id         = wfuncidoriginal
    dependente.parentesco_id   = wgrauparentescooriginal.
    
    
    MESSAGE 'Operacao cancelada!'
    VIEW-AS ALERT-BOX BUTTONS OK.
    
    RUN telas/dependente/tela-escolha-dependente.p.
END.

MESSAGE 'Nenhum dependente encontrado com o ID informado'
VIEW-AS ALERT-BOX. 
