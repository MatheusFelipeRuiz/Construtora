DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.

PROMPT-FOR dependente.id  COLUMN-LABEL 'Identificador do depdente' 
WITH FRAME depdenteframe CENTERED.
FIND dependente USING dependente.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME depdenteframe.

IF AVAILABLE dependente
THEN DO:
    
    FORM 
        dependente.id                    COLON 1  COLUMN-LABEL 'ID'
        dependente.nome_completo        COLON 10 COLUMN-LABEL 'Nome Completo'
        dependente.data_nascimento      COLON 50 COLUMN-LABEL 'Data Nasc.'
        dependente.sexo                 COLON 10 COLUMN-LABEL 'Sexo'
        dependente.cpf                  COLON 50 COLUMN-LABEL 'CPF' 
        dependente.func_id              COLON 10 COLUMN-LABEL 'Func. ID'
        dependente.endereco             COLON 50 COLUMN-LABEL 'Endereco'
        WITH FRAME formfuncionarioframe.
    
    DISP 
        dependente.id
        dependente.nome_completo
        dependente.data_nascimento
        dependente.sexo
        dependente.cpf
        dependente.func_id
        dependente.endereco
        s
    WITH SIDE-LABELS FRAME depdenteframe CENTERED TITLE 'Deletar dependente'. 
            
    MESSAGE 'Deseja deletar o depdente informado?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME depdenteframe.
    
    IF wconfirmaroperacao
    THEN DO:
        DELETE dependente.
        MESSAGE 'Dependente deletado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/dependente/tela-escolha-dependente.p.
    END.
    ELSE DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/dependente/tela-escolha-dependente.p.
    END.
     
END.



