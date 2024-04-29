set serveroutput on;

CREATE OR REPLACE PROCEDURE AGREGARPREREQUISITO 
(
  CODIGOCURSO IN NUMBER 
, CODIGOPREREQUISITO IN NUMBER 
) AS 
BEGIN
  DECLARE
validarCurso NUMBER := 0; 
validarCursoP NUMBER := 0; 

    BEGIN
    
        SELECT COUNT(*) INTO validarCurso FROM CURSO 
        WHERE CODIGO = CODIGOCURSO;
    
        SELECT COUNT(*) INTO validarCursoP FROM CURSO 
        WHERE CODIGO = CODIGOPREREQUISITO;
        
        IF validarCurso > 0 AND validarCursoP > 0  THEN
        
            insert into PRERREQ(
                PENSUM_CURSO_CODIGO
                ,CURSO_CODIGO
                ,PENSUM_PLAN_CARRERA_CARRERA
                ,PENSUM_PLAN_PLAN
            )
                SELECT  
                CURSO_CODIGO
                , CODIGOPREREQUISITO
                , PLAN_CARRERA_CARRERA
                , PLAN_PLAN
                FROM PENSUM 
                WHERE CURSO_CODIGO = CODIGOCURSO;
                
            DBMS_OUTPUT.PUT_LINE('SE AGREGO EL PREREQUISITO');
        ELSE
            DBMS_OUTPUT.PUT_LINE('ALGUNO DE LOS CURSOS NO EXISTE');
        END IF;
        
    END;

    

END AGREGARPREREQUISITO;