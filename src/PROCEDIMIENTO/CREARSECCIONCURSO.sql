set serveroutput on;

CREATE OR REPLACE PROCEDURE CREARSECCIONCURSO 
(
  CODIGOCURSO IN NUMBER 
, CICLO IN VARCHAR2 
, DOCENTE IN NUMBER 
, SECCION IN VARCHAR2 
) AS 
BEGIN
DECLARE 
validarSeccion NUMBER := 0; 
validarCurso NUMBER := 0; 
validarDocente NUMBER := 0; 

BEGIN
    SELECT  COUNT(*) INTO validarSeccion FROM DUAL
    WHERE LENGTH(TRIM(TRANSLATE(SECCION, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
    SELECT COUNT(*) INTO validarCurso FROM CURSO 
    WHERE CODIGO = CODIGOCURSO;
    SELECT COUNT(*) INTO validarDocente FROM CATEDRATICO 
    WHERE CAT = DOCENTE;
    
   IF LENGTH(SECCION) = 1 AND  validarSeccion = 0 THEN
    IF validarCurso > 0 THEN
        IF CICLO = '1S' OR CICLO = '2S' OR CICLO = 'VJ' OR CICLO = 'VD' THEN
            IF validarDocente > 0 THEN
                insert into SECCION(
                    CICLO
                    ,CURSO_CODIGO
                    ,SECCION
                    ,CATEDRATICO_CAT
                    ,ANIO
                ) values (
                    CICLO
                    ,CODIGOCURSO
                    ,SECCION
                    ,DOCENTE
                    ,EXTRACT(YEAR FROM SYSDATE)
                );
                DBMS_OUTPUT.PUT_LINE('SE CREO LA SECCION');
            ELSE
                DBMS_OUTPUT.PUT_LINE('VALIDAR EL DOCENTE');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('VALIDAR EL CICLO');
        END IF;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('VALIDAR EL CURSO');
    END IF;
   ELSE 
    DBMS_OUTPUT.PUT_LINE('VALIDAR LA SECCION');
   END IF;
   
END;
END CREARSECCIONCURSO;