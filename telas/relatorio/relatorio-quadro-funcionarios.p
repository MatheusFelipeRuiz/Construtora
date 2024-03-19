DEF VAR wvoltarparaomenu          AS LOG NO-UNDO.
DEF VAR wfiltrarporcampo          AS LOG NO-UNDO.
DEF VAR wqtdefuncionarioslistagem AS INT  NO-UNDO INIT 4.
DEF VAR wcargofuncionario         AS CHAR NO-UNDO FORMAT 'x(30)'. 
DEF VAR wfiltroescolhido          AS INT  NO-UNDO FORMAT '9'.
DEF VAR wlabelfiltros             AS CHAR NO-UNDO EXTENT 3 INIT ['Nome Completo', 'CPF', 'Cargo'].
DEF VAR wlabelatual               AS CHAR NO-UNDO FORMAT 'x(40)'.
DEF VAR i                         AS INT  NO-UNDO. 
DEF VAR texto                     AS CHAR NO-UNDO FORMAT 'x(40)'.
 
 
PROCEDURE selecionarsemfiltro:
    FOR EACH funcionario NO-LOCK:
        FIND LAST ocupacao WHERE ocupacao.func_id = funcionario.id NO-ERROR.
        FIND      cargo    WHERE cargo.id = ocupacao.cargo_id      NO-ERROR.
        
        IF AVAILABLE cargo THEN wcargofuncionario = cargo.cargo.
        ELSE wcargofuncionario = 'Sem cargo'.
    
        
        FORM
            funcionario.id              COLUMN-LABEL 'Func.ID'         
            funcionario.nome_completo   COLUMN-LABEL 'Nome Completo'
            cargo.cargo                 COLUMN-LABEL 'Cargo'
            funcionario.cpf             COLUMN-LABEL 'CPF'
        WITH  FRAME formfuncionarioframe.
        
        DISP
            funcionario.id
            funcionario.nome_completo
            wcargofuncionario @ cargo.cargo
            funcionario.cpf
        WITH wqtdefuncionarioslistagem DOWN FRAME viewfuncionarioframe 
        TITLE 'Quadro de Funcionarios' CENTERED WIDTH 120.
    
    END.
END PROCEDURE. 

PROCEDURE selecionarpornome:
    DEF VAR pcargofuncionario                      AS CHAR.
    DEF INPUT PARAMETER ipnomefuncionario          AS CHAR FORMAT 'x(40)'.
    
    FOR EACH funcionario WHERE funcionario.nome_completo MATCHES '*' + ipnomefuncionario + '*':
        FIND LAST ocupacao WHERE ocupacao.func_id = funcionario.id NO-ERROR.
        FIND      cargo    WHERE cargo.id = ocupacao.cargo_id      NO-ERROR.
        
        IF AVAILABLE cargo THEN pcargofuncionario = cargo.cargo.
        ELSE pcargofuncionario = 'Sem cargo'.
    
        
        FORM
            funcionario.id              COLUMN-LABEL 'Func.ID'         
            funcionario.nome_completo   COLUMN-LABEL 'Nome Completo'
            cargo.cargo                 COLUMN-LABEL 'Cargo'
            funcionario.cpf             COLUMN-LABEL 'CPF'
        WITH  FRAME formfuncionarioframe.
        
        DISP
            funcionario.id
            funcionario.nome_completo
            pcargofuncionario @ cargo.cargo
            funcionario.cpf
        WITH 10 DOWN FRAME viewfuncionarioframe 
        TITLE 'Quadro de Funcionarios' CENTERED WIDTH 120.
    END.
END PROCEDURE. 
 
PROCEDURE selecionarporcpf:
    DEF VAR             pcargofuncionario          AS CHAR.
    DEF INPUT PARAMETER ipcpffuncionario           AS CHAR FORMAT 'x(40)'.
    
    FOR EACH funcionario WHERE funcionario.cpf MATCHES '*' + ipcpffuncionario + '*':
        FIND LAST ocupacao WHERE ocupacao.func_id = funcionario.id NO-ERROR.
        FIND      cargo    WHERE cargo.id = ocupacao.cargo_id      NO-ERROR.
        
        IF AVAILABLE cargo THEN pcargofuncionario = cargo.cargo.
        ELSE pcargofuncionario = 'Sem cargo'.
    
        
        FORM
            funcionario.id              COLUMN-LABEL 'Func.ID'         
            funcionario.nome_completo   COLUMN-LABEL 'Nome Completo'
            cargo.cargo                 COLUMN-LABEL 'Cargo'
            funcionario.cpf             COLUMN-LABEL 'CPF'
        WITH  FRAME formfuncionarioframe.
        
        DISP
            funcionario.id
            funcionario.nome_completo
            pcargofuncionario @ cargo.cargo
            funcionario.cpf
        WITH 10 DOWN FRAME viewfuncionarioframe 
        TITLE 'Quadro de Funcionarios' CENTERED WIDTH 120.
    END.
END PROCEDURE. 
 
PROCEDURE selecionarporcargo:
    DEF VAR pcargofuncionario                      AS CHAR.
    DEF INPUT PARAMETER ipcargofuncioncario        AS CHAR.
    
    FIND      cargo    WHERE  cargo.id = INT(ipcargofuncioncario) NO-ERROR.
    
    IF AVAILABLE cargo
    THEN DO:        
        FOR EACH ocupacao NO-LOCK WHERE ocupacao.cargo_id = cargo.id BREAK BY ocupacao.func_id:
            FIND funcionario WHERE funcionario.id = ocupacao.func_id NO-ERROR.
            FORM
                funcionario.id              COLUMN-LABEL 'Func.ID'         
                funcionario.nome_completo   COLUMN-LABEL 'Nome Completo'
                cargo.cargo                 COLUMN-LABEL 'Cargo'
                funcionario.cpf             COLUMN-LABEL 'CPF'
            WITH  FRAME formfuncionarioframe.
        
            DISP
                funcionario.id
                funcionario.nome_completo
                pcargofuncionario @ cargo.cargo
                funcionario.cpf
            WITH 10 DOWN FRAME viewfuncionarioframe 
            TITLE 'Quadro de Funcionarios' CENTERED WIDTH 120.
        END.
    END.
    ELSE
    DO:
        MESSAGE 'Erro, cargo nao encontrado'
        VIEW-AS ALERT-BOX.
    END.        
END PROCEDURE. 



MESSAGE 'Deseja filtrar por um campo especifico?'
VIEW-AS ALERT-BOX BUTTONS YES-NO UPDATE wfiltrarporcampo.

IF wfiltrarporcampo
THEN DO:
    DO i = 1 TO EXTENT(wlabelfiltros):        
        ASSIGN wlabelatual = STRING(i) +  ') ' + wlabelfiltros[i].
        
        DISP wlabelatual LABEL 'Opcoes' 
        WITH FRAME opcoesframe EXTENT(wlabelfiltros) DOWN CENTERED.
        
        DOWN WITH FRAME opcoesframe.
    END.
   
   UPDATE 
        wfiltroescolhido LABEL 'Opcao' 
   WITH FRAME opcaofiltroframe CENTERED SIDE-LABELS.
   
   UPDATE texto LABEL 'Pesquisar por'
   WITH FRAME campopesquisar CENTERED SIDE-LABELS.
   
   HIDE FRAME campopesquisar.
   HIDE FRAME opcoesframe.
   HIDE FRAME opcaofiltroframe. 
   
   
   CASE wfiltroescolhido:
        WHEN 1 THEN RUN selecionarpornome(texto).
        WHEN 2 THEN RUN selecionarporcpf(texto).
        WHEN 3 THEN RUN selecionarporcargo(texto). 
    END CASE.
END.
ELSE RUN selecionarsemfiltro.

RUN telas/relatorio/tela-escolha-relatorio.p.