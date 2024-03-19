DEF VAR wconfirmaroperacao  AS LOG                          NO-UNDO. 
DEF VAR wcargoatual         AS CHAR INIT 'Sem Cargo'        NO-UNDO.
DEF VAR wcidadeatual        AS CHAR INIT 'Nao informado'    NO-UNDO.

PROMPT-FOR funcionario.id  COLUMN-LABEL 'Identificador do funcionario' 
WITH FRAME inputfuncionarioframe CENTERED.

FIND funcionario USING funcionario.id EXCLUSIVE-LOCK NO-ERROR.

HIDE FRAME inputfuncionarioframe.

IF AVAILABLE funcionario
THEN DO:
     
    
    {includes/funcionario/relatorio-detalhamento.i}
    
    FIND cidade   WHERE cidade.id = funcionario.cidade_id                             NO-ERROR.
    FIND ocupacao WHERE ocupacao.func_id = funcionario.id AND ocupacao.data_final = ? NO-ERROR.
    FIND cargo    WHERE cargo.id = ocupacao.cargo_id                                  NO-ERROR.
    
    DISP 
        funcionario.nome_completo
        funcionario.data_nascimento
        funcionario.sexo
        funcionario.cpf
        funcionario.rg
        funcionario.demitido
        wcidadeatual @ cidade.cidade 
        wcargoatual  @ cargo.cargo
    WITH TITLE 'Detalhamento  - Funcionario' CENTERED FRAME displayfuncionarioframe WIDTH 120 1 COL.
        
    PAUSE.
    HIDE FRAME displayfuncionarioframe.
    RUN telas/relatorio/tela-escolha-relatorio.p. 
END.  
ELSE 
DO:
    MESSAGE 'Nenhum funcionario encontrado com esse identificador'
    VIEW-AS ALERT-BOX.
    RUN telas/relatorio/tela-escolha-relatorio.p.
END.

