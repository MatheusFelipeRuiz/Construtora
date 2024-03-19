/*FOR EACH funcionario NO-LOCK:*/
/*    DISP funcionario.        */
/*END.                         */



/*REPEAT:                      */
/*    CREATE registro_trabalho.*/
/*    UPDATE registro_trabalho.*/
/*END.                         */

/*FOR EACH registro_trabalho NO-LOCK:    */
/*    UPDATE registro_trabalho.id        */
/*         registro_trabalho.func_id     */
/*         registro_trabalho.salario     */
/*         registro_trabalho.cargo_id    */
/*         registro_trabalho.data_inicio.*/
/*END.                                   */


/*                                                      */
/*DEFINE VARIABLE i AS INTEGER NO-UNDO.                 */
/*                                                      */
/*DO i = 1 TO 10:                                       */
/*    DISP 'Teste' + STRING(i) WITH FRAME teste 10 DOWN.*/
/*    DOWN WITH FRAME teste.                            */
/*END.                                                  */
/*                                                      */
/*DEFINE VARIABLE cOut AS CHARACTER NO-UNDO.            */
/*DO i = 1 TO 100:                                      */
/* /* Dividable by 3: fizz */                           */
/* IF i MODULO 3 = 0 THEN                               */
/* cOut = "Fizz".                                       */
/* /* Dividable by 5: buzz */                           */
/* ELSE IF i MODULO 5 = 0 THEN                          */
/* cOut = "Buzz".                                       */
/* /* Otherwise just the number */                      */
/* ELSE                                                 */
/* cOut = STRING(i).                                    */
/* /* Display the output */                             */
/* DISPLAY cOut WITH FRAME x1 20 DOWN.                  */
/* /* Move the display position in the frame down 1 */  */
/* DOWN WITH FRAME x1.                                  */
/*END.                                                  */


/*SELECT                             */
/*    funcionario.id,                */
/*    funcionario.nome_completo      */
/*FROM funcionario                   */
/*order BY funcionario.nome_completo.*/

/*DEF VAR pcargofuncionario AS CHAR.                                  */
/*                                                                    */
/*FOR EACH funcionario:                                               */
/*                                                                    */
/*        IF AVAILABLE cargo THEN pcargofuncionario = cargo.cargo.    */
/*        ELSE pcargofuncionario = 'Sem cargo'.                       */
/*                                                                    */
/*                                                                    */
/*        FORM                                                        */
/*            funcionario.id              COLUMN-LABEL 'Func.ID'      */
/*            funcionario.nome_completo   COLUMN-LABEL 'Nome Completo'*/
/*            cargo.cargo                 COLUMN-LABEL 'Cargo'        */
/*            funcionario.cpf             COLUMN-LABEL 'CPF'          */
/*        WITH  FRAME formfuncionarioframe.                           */
/*                                                                    */
/*        DISP                                                        */
/*            funcionario.id                                          */
/*            funcionario.nome_completo                               */
/*            pcargofuncionario @ cargo.cargo                         */
/*            funcionario.cpf                                         */
/*        WITH 10 DOWN FRAME viewfuncionarioframe                     */
/*        TITLE 'Quadro de Funcionarios' CENTERED WIDTH 120.          */
/*END.                                                                */
 
/*FOR EACH project-teste, EACH assignment-teste, EACH employee-teste*/
/*    WHERE project-teste.project-id = assignment-teste.project-id  */
/*    AND employee-teste.e-id = assignment-teste.employee-i         */
/*    BREAK BY employee-teste.e-id:                                 */
/*    DISPLAY project-teste.project-id                              */
/*        employee-teste.e-id                                       */
/*        employee-teste.fname                                      */
/*        employee-teste.salary FORMAT 'R$ >,>>>,>>9'               */
/*        (TOTAL MAX AVERAGE COUNT BY employee-teste.e-id).         */
/*                                                                  */
/*END.                                                              */
 
 

/*FOR EACH funcionario, EACH dependente WHERE funcionario.id = dependente.func_id */
/*    BREAK BY funcionario.id:                                                    */
/*        DISP funcionario.nome_completo                                          */
/*             dependente.id (COUNT BY funcionario.id) COLUMN-LABEL 'Dependentes'.*/
/*END.                                                                            */






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



FOR EACH ocupacao NO-LOCK WHERE ocupacao.data_final = ? BREAK BY  ocupacao.cargo_id:
    
    
    DISP ocupacao.cargo_id COLUMN-LABEL 'Cargo ID'
         funcionario.nome_completo
         ocupacao.salario (TOTAL BY ocupacao.cargo_id).
END.



