set serveroutput on;

CREATE OR REPLACE PROCEDURE CREARCURSOPENSUM 
(
  CODIGOCURSO IN NUMBER 
, NOMBRE IN VARCHAR2 
, CRENECESARIO IN NUMBER 
, CREOTORGA IN NUMBER 
, OBLIGATORIO IN NUMBER 
, CODIGOPLAN IN NUMBER 
, ZONA IN NUMBER 
, NOTA IN NUMBER 
) AS 
BEGIN
  DECLARE
validarCRENecesario NUMBER := 0; 
validarCREOtorga NUMBER := 0; 
validarCurso NUMBER := 0; 
validarPlan NUMBER := 0; 
carrera NUMBER := 0;
obli VARCHAR(1) := '0';
  
    BEGIN
        SELECT  COUNT(*) INTO validarCRENecesario FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(TO_CHAR(CRENECESARIO), '0123456789', ' '))) > 0;
        SELECT  COUNT(*) INTO validarCREOtorga FROM DUAL
        WHERE LENGTH(TRIM(TRANSLATE(TO_CHAR(CREOTORGA), '0123456789', ' '))) > 0;
        SELECT COUNT(*) INTO validarCurso FROM CURSO 
        WHERE CODIGO = CODIGOCURSO;
        SELECT COUNT(*) INTO validarPlan FROM PLAN 
        WHERE PLAN = CODIGOPLAN;
        
        IF validarPlan > 0 THEN
            SELECT CARRERA_CARRERA INTO carrera FROM PLAN 
            WHERE PLAN = CODIGOPLAN;
        END IF;
        
        
        IF OBLIGATORIO = 1 THEN
            obli := '1';
        END IF;
        
        IF validarCRENecesario = 0 THEN
            IF validarCREOtorga = 0 THEN
                IF validarCurso > 0 THEN
                    IF validarPlan > 0 THEN
                    
                       insert into PENSUM(
                            NUMCREDITOS
                            ,CURSO_CODIGO
                            ,OBLIGATORIEDAD
                            ,PLAN_PLAN
                            ,CREDPRERREQ
                            ,PLAN_CARRERA_CARRERA
                            ,NOTAAPROBACION
                            ,ZONAMINIMA
                        ) values (
                            CREOTORGA
                            ,CODIGOCURSO
                            ,obli
                            ,CODIGOPLAN
                            ,CRENECESARIO
                            ,carrera
                            ,NOTA
                            ,ZONA
                        );
                        
                        DBMS_OUTPUT.PUT_LINE('SE REGISTRO EL CURSO EN PENSUM');
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('VALIDAR SI EXISTE EL PLAN');
                    END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('VALIDAR SI EXISTE EL CURSO');
                END IF;
            ELSE
                DBMS_OUTPUT.PUT_LINE('VALIDAR CREDITOS OTORGA SOLO ENTEROS');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('VALIDAR CREDITOS NECESARIOS SOLO ENTEROS');
        END IF;
    
    
    END;
END CREARCURSOPENSUM;