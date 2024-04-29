CREATE OR REPLACE PROCEDURE REGISTRARDOCENTE 
(
  CODIGO IN NUMBER 
, NOMBRES IN VARCHAR2 
, APELLIDOS IN VARCHAR2 
, FECHADENACIMIENTO IN DATE 
, CORREO IN VARCHAR2 
, TELEFONO IN NUMBER 
, DIRECCION IN VARCHAR2 
, DPI IN NUMBER 
, SALARIO IN NUMBER 
) AS 
BEGIN
  DECLARE
validarNombre NUMBER := 0; 
validarApellido NUMBER := 0; 
validarCorreo NUMBER := 0; 
validarCatedratico NUMBER := 0; 
validarSalario NUMBER := SALARIO; 
  
    BEGIN
        SELECT  COUNT(*) INTO validarNombre FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(NOMBRES, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
        SELECT  COUNT(*) INTO validarApellido FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(APELLIDOS, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
        validarCorreo := EMAILVALIDATE_V1(CORREO);
        SELECT COUNT(*) INTO validarCatedratico FROM CATEDRATICO 
        WHERE CAT = CODIGO;
    
        IF validarNombre = 0 THEN
            IF validarApellido = 0 THEN
                IF validarCorreo > 0 THEN
                    IF validarCatedratico = 0 THEN
                        IF validarSalario > 0 AND validarSalario < 100000 THEN
                            insert into CATEDRATICO(
                                DIRECCION
                                ,APELLIDO
                                ,CORREO
                                ,CAT
                                ,TELEFONO
                                ,SUELDOMENSUAL
                                ,DPI
                                ,NOMBRE
                                ,FECHANACIMIENTO
                            ) values (
                                DIRECCION
                                ,APELLIDOS
                                ,CORREO
                                ,CODIGO
                                ,TELEFONO
                                ,SALARIO
                                ,DPI
                                ,NOMBRES
                                ,FECHADENACIMIENTO
                            );
                            
                            DBMS_OUTPUT.PUT_LINE('SE REGISRO AL DOCENTE');
                        ELSE
                            DBMS_OUTPUT.PUT_LINE('VALIDAR EL SALARIO INGRESADO');
                        END IF;
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('YA EXISTE ESTE CODIGO REGISTRADO');
                    END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('VALIDAR EL CORREO');
                END IF;
            ELSE
                DBMS_OUTPUT.PUT_LINE('VALIDAR LOS APELLIDOS');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('VALIDAR EL NOMBRE');
        END IF;
    
    
    END;
END REGISTRARDOCENTE;