DEF VAR wvoltarparaomenu    AS LOG          NO-UNDO.
DEF VAR wqtdecargoslistagem AS INT INIT 4   NO-UNDO.

FOR EACH cargo NO-LOCK:
    
    {includes/cargo/formulario-relatorio-cargos.i}

    DISP
        cargo.id
        cargo.cargo
    WITH wqtdecargoslistagem DOWN FRAME displaycargoframe 
    TITLE 'Lista de cargos' CENTERED.
END.


MESSAGE 'Listagem completada!'
VIEW-AS ALERT-BOX.

RUN telas/relatorio/tela-escolha-relatorio.p.
