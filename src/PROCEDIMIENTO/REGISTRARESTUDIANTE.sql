set serveroutput on;


CREATE OR REPLACE PROCEDURE REGISTRARESTUDIANTE 
(
  CARNET IN NUMBER 
, NOMBRES IN VARCHAR2 
, APELLIDOS IN VARCHAR2 
, FECHADENACIMIENTO IN DATE 
, CORREO IN VARCHAR2 
, TELEFONO IN NUMBER 
, DIRECCION IN VARCHAR2 
, DPI IN NUMBER 
, CARRERA IN NUMBER 
, PLAN IN NUMBER 
, INGRESOS IN NUMBER
) AS
BEGIN

DECLARE
validarNombre NUMBER := 0; 
validarApellido NUMBER := 0; 
validarCorreo NUMBER := 0; 
validarCarrera NUMBER := 0; 
validarPlan NUMBER := 0; 
  
    BEGIN
        SELECT  COUNT(*) INTO validarNombre FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(NOMBRES, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
        SELECT  COUNT(*) INTO validarApellido FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(APELLIDOS, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0;
        validarCorreo := EMAILVALIDATE_V1(CORREO);
        SELECT COUNT(*) INTO validarCarrera FROM CARRERA 
        WHERE CARRERA = CARRERA;
        SELECT COUNT(*) INTO validarPlan FROM PLAN 
        WHERE PLAN = PLAN;
    
        IF validarNombre = 0 THEN
            IF validarApellido = 0 THEN
                IF validarCorreo > 0 THEN
                    IF validarCarrera > 0 THEN
                        IF validarPlan > 0 THEN
                            insert into ESTUDIANTE(
                                DIRECCION
                                ,APELLIDO
                                ,CORREO
                                ,CARNET
                                ,TELEFONO
                                ,DPI
                                ,NOMBRE
                                ,INGRESOFAMILIAR
                                ,FECHANACIMIENTO
                            ) values (
                                DIRECCION
                                ,APELLIDOS
                                ,CORREO
                                ,CARNET
                                ,TELEFONO
                                ,DPI
                                ,NOMBRES
                                ,INGRESOS
                                ,FECHADENACIMIENTO
                            );
                            
                            insert into INSCRITO(
                                CARRERA_CARRERA
                                ,ESTUDIANTE_CARNET
                                ,FECHAINSCRIPCION
                            ) values (
                                CARRERA
                                ,CARNET
                                ,SYSDATE
                            );
                            
                            DBMS_OUTPUT.PUT_LINE('SE INSCRIBIO AL ESTUDIANTE');
                        ELSE
                            DBMS_OUTPUT.PUT_LINE('VALIDAR SI EXISTE EL PLAN');
                        END IF;
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('VALIDAR SI EXISTE LA CARRERA');
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
  
END REGISTRARESTUDIANTE;


SELECT 
E.*
FROM ESTUDIANTE E
INNER JOIN SECCION S ON S.SECCION = 1
WHERE E.CARNET = 201114117