set serveroutput on;

CREATE OR REPLACE PROCEDURE CONSULTARAPROBACIONES 
(
  CODIGOCURSO IN NUMBER 
, CICLO IN VARCHAR2 
, ANIO IN NUMBER 
, SECCION IN VARCHAR2 
, cursor_ OUT SYS_REFCURSOR
) AS 
BEGIN
   DECLARE 
validarSeccion NUMBER := 0; 
validarCurso NUMBER := 0; 

BEGIN
    SELECT  COUNT(*) INTO validarSeccion FROM DUAL
    WHERE LENGTH(TRIM(TRANSLATE(SECCION, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
    SELECT COUNT(*) INTO validarCurso FROM CURSO 
    WHERE CODIGO = CODIGOCURSO;
    
   IF LENGTH(SECCION) = 1 AND  validarSeccion = 0 THEN
    IF validarCurso > 0 THEN
        IF CICLO = '1S' OR CICLO = '2S' OR CICLO = 'VJ' OR CICLO = 'VD' THEN
        
            OPEN cursor_ FOR
            SELECT A.SECCION_CURSO_CODIGO AS CURSO
            , E.CARNET
            , E.NOMBRE || ' ' || E.APELLIDO AS NOMBRECOMPLETO
            , CASE  WHEN A.NOTA + A.ZONA > 61  THEN 'APROBADO' ELSE 'REPROBADO' END AS ESTADO
            FROM ASIGNACION A
            INNER JOIN ESTUDIANTE E ON A.ESTUDIANTE_CARNET = E.CARNET
            WHERE A.SECCION_CURSO_CODIGO = CODIGOCURSO
            AND A.SECCION_CICLO = CICLO
            AND A.SECCION_ANIO = ANIO
            AND A.SECCION_SECCION = SECCION;
            
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
   
END CONSULTARAPROBACIONES;