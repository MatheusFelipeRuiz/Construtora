

/*Exportacao dos cargos */
/*OUTPUT TO cargos.txt.  */
/*FOR EACH cargo NO-LOCK:*/
/*    EXPORT cargo.id    */
/*           cargo.cargo.*/
/*END.                   */

/*Exportar grau de parentescos*/

/*OUTPUT TO parentescos.txt.       */
/*FOR EACH tipo_parentesco NO-LOCK:*/
/*    EXPORT  tipo_parentesco.     */
/*END.                             */

/*                           */
/*REPEAT:                    */
/*    CREATE tipo_parentesco.*/
/*    UPDATE tipo_parentesco.*/
/*END.                       */

/*FOR EACH tipo_parentesco EXCLUSIVE-LOCK:*/
/*    DELETE tipo_parentesco.             */
/*END.                                    */

/*Exportacao dos funcionarios       */
/*REPEAT:                           */
/*    CREATE funcionario.           */
/*    UPDATE funcionario WITH 1 COL.*/
/*END.                              */

/*FOR EACH funcionario EXCLUSIVE-LOCK:*/
/*    DELETE funcionario.             */
/*END.                                */

/*OUTPUT to funcionarios.txt.*/
/*FOR EACH funcionario:      */
/*    EXPORT funcionario.    */
/*END.                       */

/*Importar funcionarios*/
/*INPUT FROM funcionarios.txt.       */
/*REPEAT:                            */
/*    CREATE funcionario.            */
/*    SET funcionario.id             */
/*        funcionario.cpf            */
/*        funcionario.data_nascimento*/
/*        funcionario.sexo           */
/*        funcionario.nome_completo  */
/*        funcionario.rg             */
/*        funcionario.demitido.      */
/*END.                               */



/*CREATE dependente.           */
/*UPDATE dependente WITH 1 COL.*/



/*FOR EACH funcionario EXCLUSIVE-LOCK:*/
/*    DELETE funcionario.             */
/*END.                                */

 


