DEF VAR wvoltarparaomenu     AS LOG         NO-UNDO.
DEF VAR wqtdecidadeslistagem AS INT INIT 4  NO-UNDO.

FOR EACH cidade NO-LOCK:
    
    {includes/cidade/formulario-relatorio-cidade.i}

    DISP
        cidade.id
        cidade.cidade
    WITH wqtdecidadeslistagem DOWN FRAME displaycidadeframe 
    TITLE 'Lista de cidades' CENTERED.
END.


MESSAGE 'Listagem completada!'
VIEW-AS ALERT-BOX.

RUN telas/relatorio/tela-escolha-relatorio.p.
