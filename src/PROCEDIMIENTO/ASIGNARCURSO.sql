set serveroutput on;

CREATE OR REPLACE PROCEDURE ASIGNARCURSO 
(
  CODIGOSECCION IN VARCHAR 
, CARNET IN NUMBER 
) AS 
BEGIN
  DECLARE
validarSeccion NUMBER := 0; 
validarEstudiante NUMBER := 0; 

    BEGIN
        SELECT COUNT(*) INTO validarSeccion FROM SECCION 
        WHERE SECCION = CODIGOSECCION;
        SELECT COUNT(*) INTO validarEstudiante FROM ESTUDIANTE 
        WHERE CARNET = CARNET;
        
        IF validarSeccion > 0 THEN
            IF validarEstudiante > 0 THEN
                insert into ASIGNACION(
                    SECCION_CURSO_CODIGO
                    ,SECCION_CICLO
                    ,ZONA
                    ,ESTUDIANTE_CARNET
                    ,NOTA
                    ,SECCION_SECCION
                    ,SECCION_ANIO
                ) 
                SELECT 
                CURSO_CODIGO
                , CICLO
                , 0
                , CARNET
                , 0
                , CODIGOSECCION
                , ANIO
                FROM SECCION
                WHERE SECCION = CODIGOSECCION;
                
                DBMS_OUTPUT.PUT_LINE('SE CREO DE FORMA CORRECTA LA ASIGNACION');
            ELSE 
                DBMS_OUTPUT.PUT_LINE('VALIDAR SI EXISTE EL ESTUDIANTE');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('VALIDAR SI EXISTE LA SECCION');
        END IF;
    END;
END ASIGNARCURSO;