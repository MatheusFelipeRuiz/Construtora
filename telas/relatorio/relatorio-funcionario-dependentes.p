FOR EACH funcionario NO-LOCK:
    DEF VAR qtdedependentes    AS INT INIT 0.
    DEF VAR totalsalarioscargo AS DEC INIT 0.
    
    FIND LAST ocupacao WHERE ocupacao.func_id = funcionario.id NO-ERROR.

    IF AVAILABLE ocupacao
        THEN 
    DO:

        FOR EACH dependente WHERE funcionario.id = dependente.func_id
            BREAK BY funcionario.id:
            qtdedependentes = qtdedependentes + 1.
        END.

    

        FIND cargo WHERE cargo.id = ocupacao.cargo_id NO-ERROR.
        DISP cargo.id                   COLUMN-LABEL 'Cod.Cargo'
            cargo.cargo                 COLUMN-LABEL 'Cargo'
            funcionario.nome_completo   COLUMN-LABEL 'Nome'
            ocupacao.salario            COLUMN-LABEL 'Salario'
            qtdedependentes             COLUMN-LABEL 'Dependentes'
            WITH WIDTH 120.

        ASSIGN 
            qtdedependentes = 0.
        
    END.
END.


MESSAGE 'Listagem completada!'
VIEW-AS ALERT-BOX.

RUN telas/relatorio/tela-escolha-relatorio.p.
