set serveroutput on;

CREATE OR REPLACE PROCEDURE CONSULTARDOCENTE 
(
  CODIGODOCENTE IN NUMBER 
  , cursor_ OUT SYS_REFCURSOR
) AS 
BEGIN
  DECLARE
  validarDocente NUMBER := 0; 
  
  BEGIN
    SELECT COUNT(*) INTO validarDocente FROM CATEDRATICO 
    WHERE CAT = CODIGODOCENTE;
    
    IF validarDocente > 0 THEN
    
        OPEN cursor_ FOR
        SELECT CAT
        , NOMBRE || ' ' || APELLIDO AS NOMBRECOMPLETO
        , FECHANACIMIENTO
        , CORREO
        , TELEFONO
        , DIRECCION
        , DPI
        FROM CATEDRATICO
        WHERE CAT = CODIGODOCENTE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO EXISTE EL ESTUDIANTE');
    END IF;
    
  END;
  
END CONSULTARDOCENTE;