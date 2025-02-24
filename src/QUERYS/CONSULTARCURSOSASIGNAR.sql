set serveroutput on;

CREATE OR REPLACE PROCEDURE CONSULTARCURSOSASIGNAR 
(
  CARNET IN NUMBER 
, cursor_ OUT SYS_REFCURSOR
) AS 
BEGIN
    DECLARE 
validarCarnet NUMBER := 0; 

BEGIN
    SELECT COUNT(*) INTO validarCarnet FROM ESTUDIANTE 
    WHERE CARNET = CARNET;
    
    IF validarCarnet > 0 THEN
        
        OPEN cursor_ FOR
        SELECT C.CODIGO
        , C.NOMBRE AS NOMBRECURSO
        , PN.NUMCREDITOS AS CREDITOS
        , C1.CODIGO AS CODIGOPRE
        , C1.NOMBRE AS PRERREQUISTO
        FROM PRERREQ P
        INNER JOIN CURSO C ON P.CURSO_CODIGO = C.CODIGO
        INNER JOIN CURSO C1 ON P.PENSUM_CURSO_CODIGO = C1.CODIGO
        INNER JOIN PENSUM PN ON P.PENSUM_CURSO_CODIGO = PN.CURSO_CODIGO AND P.PENSUM_PLAN_PLAN = PN.PLAN_PLAN AND P.PENSUM_PLAN_CARRERA_CARRERA = PN.PLAN_CARRERA_CARRERA 
        INNER JOIN PLAN PL ON PN.PLAN_PLAN = PL.PLAN AND PN.PLAN_CARRERA_CARRERA = PL.CARRERA_CARRERA
        INNER JOIN CARRERA CA ON PL.CARRERA_CARRERA = CA.CARRERA
        INNER JOIN INSCRITO I ON CA.CARRERA = I.CARRERA_CARRERA AND I.ESTUDIANTE_CARNET = CARNET
        WHERE P.PENSUM_CURSO_CODIGO IN (
            SELECT A.SECCION_CURSO_CODIGO
            FROM ASIGNACION A
            INNER JOIN ESTUDIANTE E ON A.ESTUDIANTE_CARNET = E.CARNET
            WHERE E.CARNET = CARNET AND A.NOTA + A.ZONA >= 61
        );
    ELSE 
        DBMS_OUTPUT.PUT_LINE('VALIDAR EL ESTUDIANTE');
    END IF;
   
END;

END CONSULTARCURSOSASIGNAR;