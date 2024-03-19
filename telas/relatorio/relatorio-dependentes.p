DEF VAR wvoltarparaomenu         AS LOG         NO-UNDO.
DEF VAR wqtdedependenteslistagem AS INT INIT 4  NO-UNDO.

FOR EACH dependente NO-LOCK:
    
    {includes/dependente/formulario-relatorio-dependente.i}
    
    FIND funcionario WHERE funcionario.id = dependente.func_id NO-ERROR.

    DISP
        dependente.id               COLUMN-LABEL 'Dep.ID'
        dependente.nome_completo    COLUMN-LABEL 'Nome'
        funcionario.nome_completo   COLUMN-LABEL 'Func. Nome'
        dependente.cpf              COLUMN-LABEL 'CPF'
    WITH wqtdedependenteslistagem DOWN FRAME displaydependenteframe 
    TITLE 'Lista de dependentes' CENTERED WIDTH 120.
END.


MESSAGE 'Listagem completada!'
VIEW-AS ALERT-BOX.

RUN telas/relatorio/tela-escolha-relatorio.p.
