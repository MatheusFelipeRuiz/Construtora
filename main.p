/*/*CREATE funcionario.*/                                 */
/*/*ASSIGN funcionario.id = NEXT-VALUE (funcionario.id).*/*/
/*/*UPDATE funcionario.*/                                 */
/*                                                        */
/*FIND LAST funcionario EXCLUSIVE-LOCK NO-ERROR NO-WAIT.  */


/*FOR EACH funcionario NO-LOCK BY funcionario.nome_completo:*/
/*    DISP funcionario.*/
/*END.*/

/*FIND funcionario WHERE funcionario.id = 0.*/
/*DELETE funcionario.*/

FOR EACH dependente NO-LOCK:
    DISP dependente WITH 1 COL.
END.