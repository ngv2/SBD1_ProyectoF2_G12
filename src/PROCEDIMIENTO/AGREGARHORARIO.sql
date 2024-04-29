set serveroutput on;

CREATE OR REPLACE PROCEDURE AGREGARHORARIO 
(
  CODIGOSECCION IN NUMBER 
, CODIGOPERIODO IN NUMBER 
, DIA IN NUMBER 
, SALON IN NUMBER 
) AS 
BEGIN
  DECLARE
validarSeccion NUMBER := 0; 
validarPeriodo NUMBER := 0; 
validarDia NUMBER := 0; 
validarSalon NUMBER := 0; 
    BEGIN
        SELECT COUNT(*) INTO validarSeccion FROM SECCION 
        WHERE SECCION = CODIGOSECCION;
        SELECT COUNT(*) INTO validarPeriodo FROM PERIODO 
        WHERE PERIODO = CODIGOPERIODO;
        SELECT COUNT(*) INTO validarDia FROM DIA 
        WHERE DIA = DIA;
        SELECT COUNT(*) INTO validarSalon FROM SALON 
        WHERE SALON = SALON;
    
    
        IF validarSeccion > 0 THEN
            IF validarPeriodo > 0 THEN
                IF validarDia > 0 THEN
                    IF validarSalon > 0 THEN
                        insert into HORARIO(
                            DIA_DIA
                            ,SECCION_CURSO_CODIGO
                            ,SECCION_CICLO
                            ,SALON_EDIFICIO
                            ,SALON_SALON
                            ,SECCION_SECCION
                            ,SECCION_ANIO
                            ,PERIODO_PERIODO
                        ) 
                        SELECT DIA
                        , CURSO_CODIGO
                        , CICLO
                        , (SELECT EDIFICIO FROM SALON WHERE SALON = SALON )
                        , SALON
                        , CODIGOSECCION
                        , ANIO
                        , CODIGOPERIODO
                        FROM SECCION 
                        WHERE SECCION = CODIGOSECCION;
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('VALIDAR EL SALON');
                    END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('VALIDAR EL DIA');
                END IF;
            ELSE
                DBMS_OUTPUT.PUT_LINE('VALIDAR EL PERIODO');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('VALIDAR LA SECCION');
        END IF;
    END;
END AGREGARHORARIO;