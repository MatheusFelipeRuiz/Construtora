DEF VAR wvoltarparaomenu AS LOG NO-UNDO.


DEF VAR wqtdefuncionarioslistagem AS INT  NO-UNDO INIT 4.
DEF VAR wdataencerramento         AS DATE NO-UNDO. 

FOR EACH ocupacao NO-LOCK:
    FIND funcionario WHERE funcionario.id = ocupacao.func_id  NO-LOCK NO-ERROR.
    FIND cargo       WHERE cargo.id       = ocupacao.cargo_id NO-LOCK NO-ERROR. 
    
    FORM
        ocupacao.id                 LABEL 'Ocupacao'         
        funcionario.nome_completo   COLUMN-LABEL 'Funcionario'
        ocupacao.salario            COLUMN-LABEL 'Salario'
        ocupacao.data_inicio        COLUMN-LABEL 'Data Inicio'
        ocupacao.data_final         COLUMN-LABEL 'Data Final'
    WITH  FRAME formocupacaoframe.
    
    DISP
        ocupacao.id
        funcionario.nome_completo
        ocupacao.salario
        ocupacao.data_inicio
        ocupacao.data_final
    WITH wqtdefuncionarioslistagem DOWN FRAME formocupacaoframe 
    TITLE 'Relatorio de Ocupacoes' CENTERED WIDTH 100.
    
END.


MESSAGE 'Listagem completada!'
VIEW-AS ALERT-BOX.

RUN telas/relatorio/tela-escolha-relatorio.p.