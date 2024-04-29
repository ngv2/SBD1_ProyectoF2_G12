CREATE OR REPLACE TRIGGER TRASIGNACION 
AFTER DELETE OR INSERT OR UPDATE ON ASIGNACION
BEGIN
  IF INSERTING THEN
      INSERT INTO BITACORA(FECHA, DESCRIPCION, TIPO)VALUES(SYSDATE, 'Se ha realizado una acci�n en la tabla ASIGNACION', 'INSERT');
  END IF;
  
  IF UPDATING THEN
      INSERT INTO BITACORA(FECHA, DESCRIPCION, TIPO)VALUES(SYSDATE, 'Se ha realizado una acci�n en la tabla ASIGNACION', 'UPDATE');
  END IF;
  
  IF DELETING THEN
      INSERT INTO BITACORA(FECHA, DESCRIPCION, TIPO)VALUES(SYSDATE, 'Se ha realizado una acci�n en la tabla ASIGNACION', 'DELETE');
  END IF;
  
END;