CREATE OR REPLACE TRIGGER TRCARRERA 
AFTER DELETE OR INSERT OR UPDATE ON CARRERA
BEGIN
  IF INSERTING THEN
      INSERT INTO BITACORA(FECHA, DESCRIPCION, TIPO)VALUES(SYSDATE, 'Se ha realizado una acci�n en la tabla CARRERA', 'INSERT');
  END IF;
  
  IF UPDATING THEN
      INSERT INTO BITACORA(FECHA, DESCRIPCION, TIPO)VALUES(SYSDATE, 'Se ha realizado una acci�n en la tabla CARRERA', 'UPDATE');
  END IF;
  
  IF DELETING THEN
      INSERT INTO BITACORA(FECHA, DESCRIPCION, TIPO)VALUES(SYSDATE, 'Se ha realizado una acci�n en la tabla CARRERA', 'DELETE');
  END IF;
  
END;