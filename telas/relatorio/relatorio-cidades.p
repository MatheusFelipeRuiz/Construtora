DEF VAR wvoltarparaomenu AS LOG NO-UNDO.


DEF VAR wqtdecidadeslistagem AS INT  NO-UNDO INIT 4.

FOR EACH cidade NO-LOCK:
    
    {includes/cidade/formulario-relatorio-cidade.i}

    DISP
        cidade.id
        cidade.cidade
    WITH wqtdecidadeslistagem DOWN FRAME viewcidadeframe 
    TITLE 'Lista de cidades' CENTERED.
END.


MESSAGE 'Listagem completada!'
VIEW-AS ALERT-BOX.

RUN telas/relatorio/tela-escolha-relatorio.p.
