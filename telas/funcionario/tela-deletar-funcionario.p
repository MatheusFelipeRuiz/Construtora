DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.

PROMPT-FOR funcionario.id  COLUMN-LABEL 'Identificador do funcionario' 
WITH FRAME funcionarioframe CENTERED.
FIND funcionario USING funcionario.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME funcionarioframe.

IF AVAILABLE funcionario
THEN DO:
    
    FORM 
        funcionario.nome_completo
        funcionario.data_nascimento
        funcionario.sexo
        funcionario.cpf
        WITH FRAME formfuncionarioframe WIDTH 120.
    
    DISP 
        funcionario.id
        funcionario.nome_completo
        funcionario.data_nascimento
        funcionario.sexo
        funcionario.cpf
    WITH 1 COL FRAME funcionarioframe CENTERED TITLE 'Funcionario'. 
            
    MESSAGE 'Deseja deletar o funcionario informado?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME funcionarioframe.
    
    IF wconfirmaroperacao
    THEN DO:
        DELETE funcionario.
        MESSAGE 'Funcionario deletado com sucesso!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
    ELSE DO:
        MESSAGE 'Operacao cancelada!'
        VIEW-AS ALERT-BOX BUTTONS OK.
        RUN telas/funcionario/tela-escolha-funcionario.p.
    END.
     
END.



