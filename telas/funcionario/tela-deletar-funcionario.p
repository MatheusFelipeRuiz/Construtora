DEF VAR wconfirmaroperacao  AS LOG NO-UNDO.

PROMPT-FOR funcionario.id  COLUMN-LABEL 'Identificador do funcionario' 
WITH FRAME inputfuncionarioframe CENTERED.
FIND funcionario USING funcionario.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME inputfuncionarioframe.

IF AVAILABLE funcionario
THEN DO:
    
    {includes/funcionario/formulario-delecao.i}
    
    DISP 
        funcionario.id
        funcionario.nome_completo
        funcionario.data_nascimento
        funcionario.sexo
        funcionario.cpf
    WITH 1 COL FRAME displayfuncionarioframe CENTERED TITLE 'Funcionario'. 
            
    MESSAGE 'Deseja deletar o funcionario informado?'
    VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wconfirmaroperacao.
    
    HIDE FRAME displayfuncionarioframe.
    
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
ELSE 
DO:
    MESSAGE 'Nenhum funcionario disponivel com esse identificador'
    VIEW-AS ALERT-BOX BUTTONS OK.
    RUN telas/funcionario/tela-escolha-funcionario.p.
END.



