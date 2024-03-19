/*DEFINE BUFFER wfuncionario FOR funcionario.                 */
/*                                                            */
/*                                                            */
/*FORM                                                        */
/*    cargo.id                        COLUMN-LABEL 'Cod.Cargo'*/
/*    cargo.cargo                     COLUMN-LABEL 'Cargo'    */
/*    funcionario.nome_completo       COLUMN-LABEL 'Nome'     */
/*    ocupacao.salario                COLUMN-LABEL 'Salario'  */
/*    WITH FRAME formfuncionarioframe.                        */

    
FOR EACH funcionario NO-LOCK:
    FIND LAST ocupacao WHERE ocupacao.func_id = funcionario.id NO-ERROR.
    
    IF AVAILABLE ocupacao
    THEN DO:
        FIND cargo WHERE cargo.id = ocupacao.cargo_id NO-ERROR.
        DISP cargo.id                   COLUMN-LABEL 'Cod.Cargo'
             cargo.cargo                COLUMN-LABEL 'Cargo'
             funcionario.nome_completo  COLUMN-LABEL 'Nome'
             WITH WIDTH 120.
             
    END.
END.

FOR EACH employee-teste NO-LOCK:
    DISPLAY employee-teste.salary (COUNT).
END.