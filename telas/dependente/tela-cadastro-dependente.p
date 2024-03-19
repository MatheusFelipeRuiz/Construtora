DEF VAR wultimoidentificador AS INT NO-UNDO.
DEF VAR wconfirmaroperacao AS LOG NO-UNDO.


FIND LAST  dependente NO-LOCK NO-ERROR.

// Define o ID do registro que está sendo criado
IF AVAILABLE dependente THEN    ASSIGN  wultimoidentificador = dependente.id + 1.
ELSE ASSIGN wultimoidentificador = 1. 

CREATE dependente.
ASSIGN 
    dependente.id = wultimoidentificador.


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
                
    WITH SIDE-LABELS  TITLE 'Cadastro Dependente' CENTERED ROW 4 FRAME cadastrodepframe .
 
dependente.nome_completo = TRIM(dependente.nome_completo).


HIDE FRAME cadastrodepframe.

MESSAGE 'Confirma o cadastro do dependente?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.

IF wconfirmaroperacao THEN  RUN telas/dependente/tela-escolha-dependente.p.
ELSE 
DO:
    DELETE dependente.
    HIDE.
    RUN telas/dependente/tela-escolha-dependente.p.
END.

 
