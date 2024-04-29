CREATE OR REPLACE PROCEDURE CREARCARRERA 
(
  NOMBRE IN VARCHAR2 
) AS 
BEGIN
  DECLARE
  validarNombre NUMBER := 0; 
  
  BEGIN
        SELECT  COUNT(*) INTO validarNombre FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(NOMBRE, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
        
        IF validarNombre = 0 THEN
            insert into CARRERA(
                CARRERA
                ,NOMBRE
            ) values (
                NULL
                ,NOMBRE
            );
            DBMS_OUTPUT.PUT_LINE('SE CREO LA CARRERA DE FORMA CORRECTA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('VALIDAR EL NOMBRE');
        END IF;
        
    END;

END CREARCARRERA;
