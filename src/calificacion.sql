-- Se utilizan estos datos para algunas tablas y se usa el id mostrado
-- tabla dia registrar los dias de la semana con id del 1 al 7, para la referencia, para quienes lo usen como atributo cambiar el id por el nombre
-- tabla salon se estara trabajando para el id 1, salon 201 edificio T3, id 2, salon 202 edificio T3, id 3, salon 203 edificio T3
-- si tienen ciclo como id tener en cuenta id 1 para 1S, 2 para 2S, 3 para VJ, 4 para VD, en este archivo se envia como atributo
-- para periodo registrar id 1 - 7:00 a 8:00, id 2 - 8:00 a 9:00, id 3 - 9:00 a 10:00, id 4 - 10:00 a 11:00, id 5 - 11:00 a 12:00, id 6 - 12:00 a 13:00, id 7 - 13:00 a 14:00, id 8 - 14:00 a 15:00, id 9 - 15:00 a 16:00, id 10 - 16:00 a 17:00, id 11 - 17:00 a 18:00, id 12 - 18:00 a 19:00, id 13 - 19:00 a 20:00, id 14 - 20:00 a 21:00, id 15 - 21:00 a 22:00
-- para plan lo unico relevante es el id, la jornada y creditos de cierre, registrar id 1 para plan matutino para industrial con 250 creditos, y 2 para plan matutino para sistemas con 40 creditos para cerrar, tambien depende de como lo hayan manejado para los años sera siempre 2024 y ciclo inicio 1s y fin 2s la verdad no son tan relevantes para la calificacion
-- registrar estos cursos, Id - nombre
-- 1-Mate 1, 2-Mate 2, 4-Fisica, 8-Fisica 2, 41-IPC 1, 42-Logica de sistemas, 105-Archivos, 106-Compi 1, 107-Bases 1, 108-Bases 2, 202 - practicas, 111 - filosofia, 205 - Seminario, 55 - Dibujo
-- trabajar solo con año 2024, como mensiona el enunciado

-- cambios en fechas para que coincidan con el formato dd-MMMM-yyyy de ORACLE
-- en algunas consultas que piden salario familiar se coloco 0 en el procedimiento

--############################ ELIMINAR TABLAS #################################
DELETE FROM ASIGNACION;
DELETE FROM INSCRITO;
DELETE FROM PRERREQ;
DELETE FROM PENSUM;
DELETE FROM PLAN;
DELETE FROM CARRERA;
DELETE FROM HORARIO;
DELETE FROM SECCION;
DELETE FROM CATEDRATICO;
DELETE FROM ESTUDIANTE;
DELETE FROM BITACORA;

DELETE FROM ASIGNACION;
DELETE FROM INSCRITO;
DELETE FROM PRERREQ;
DELETE FROM PENSUM;
DELETE FROM PLAN;
DELETE FROM CARRERA;
DELETE FROM HORARIO;
DELETE FROM SECCION;
DELETE FROM CATEDRATICO;
DELETE FROM ESTUDIANTE;
DELETE FROM BITACORA;
--############################ DECLARACION VARIABLE PARA CONSULTAS ############3
VAR CC REFCURSOR;

-- ########################### CREAR CARRERA ###########################
CALL CREARCARRERA('Ciencias y Sistemas'); -- ok
CALL CREARCARRERA('Industrial'); -- ok
CALL CREARCARRERA('Ciencias y Sistemas'); -- error duplicado
CALL CREARCARRERA('Ciencias y Sistem@s'); -- nombre inválido

SELECT * FROM CARRERA;

--############################ INSERTAR PLAN ############################
INSERT INTO "BD1"."PLAN" (PLAN, CARRERA_CARRERA, NOMBRE, ANOINICIAL, CICLOINICIAL, ANOFINAL, CICLOFINAL, NUMCREDITOSCIERRE) VALUES ('1', '2', 'MATUTINO', '2024', '1S', '2024', '2S', '250');
INSERT INTO "BD1"."PLAN" (PLAN, CARRERA_CARRERA, NOMBRE, ANOINICIAL, CICLOINICIAL, ANOFINAL, CICLOFINAL, NUMCREDITOSCIERRE) VALUES ('2', '1', 'MATUTINO', '2024', '1S', '2024', '2S', '40');


-- ########################### CREAR ESTUDIANTE ###########################
-- Formato RegistrarEstudiante(carnet, nombre, apellido, fechaNacimiento, correo, telefono, direccion, cui, carrera, plan) al registrar estudiante se le asigna un plan de estudios lo que significa que se le asigna una carrera o se inscribe en ella por lo que hay que ver las tablas afectadas
CALL REGISTRARESTUDIANTE(201506554, 'Angel', 'Marroquin', '06-01-1996', 'angel@gmail.com', '56401996', '19 avenida', '45119960101', '1', '2','0'); -- ok
CALL REGISTRARESTUDIANTE(201818477, 'Diego', 'Arriaga', '19-12-2012', 'Diego@gmail.com', 48712012, '8 avenida', 741220120101, 1, 2,0); -- ok, se acepta aunque la fecha no es tan logica verdad...
CALL REGISTRARESTUDIANTE(201902238, 'Luis', 'Lopez', '25-01-2001', 'luis@gmail.com', 42141631, '2 calle', 3006251851047, 2, 1,0); -- ok
CALL REGISTRARESTUDIANTE(202004765, 'Javier!', 'Gutierrez?', '14-03-2001', 'javier@gmail.com', 42543549, '29 avenida', 3024021520101, 1, 2,0); -- nombre inválido
CALL REGISTRARESTUDIANTE(202004765, 'Javier', 'Gutierrez', '14-03-2001', 'javiergmail.com', 42543549, '29 avenida', 3024021520101, 1, 2,0); -- correo inválido
CALL REGISTRARESTUDIANTE(201409335, 'Fabian', 'Reyna', '13-06-2001', 'Fabian@gmail.com', 49502001, '7 avenida', 53620010101, 99, 2,0); -- no existe carrera
CALL REGISTRARESTUDIANTE(201409335, 'Fabian', 'Reyna', '13-06-2001', 'Fabian@gmail.com', 49502001, '7 avenida', 53620010101, -5, 1,0); -- número inválido / no existe carrera
CALL REGISTRARESTUDIANTE(201506554, 'Angel', 'Marroquin', '06-JANUARY-1996', 'Angel@gmail.com', 46401996, '19 avenida', 45119960101, 1, 2,0); -- error duplicado
CALL REGISTRARESTUDIANTE(201905743, 'Jose', 'Choc', '06-01-1996', 'jose@gmail.com', 46401996, '12 avenida', 45119960101, 1, 1,0); -- error plan no pertenece a carrera


-- ########################### REGISTRAR DOCENTE ###########################
-- formato RegistrarDocente(codigo, nombre, apellido, fechaNacimiento, correo, telefono, direccion, cui, salario)
CALL REGISTRARDOCENTE(1234, 'Arturo', 'Samayoa', '04-05-1977', 'Arturo@gmail.com', 41412003, '4 avenida', 48520030101, 25000); -- ok
CALL REGISTRARDOCENTE(1235, 'William', 'Escobar', '10-07-1991', 'william@gmail.com', 41512012, '24 avenida', 55720120101, 20000); -- ok
CALL REGISTRARDOCENTE(1236, 'Lui5', '3spino', '01-12-2000', 'luis@gmail.com', 57812000, '12 avenida', 861220000101, 15000); -- nombre inválido
CALL REGISTRARDOCENTE(1236, 'Luis', 'Espino', '01-12-2000', 'luis@gmail.com', 57812000, '12 avenida', 861220000101, 15000); -- ok
CALL REGISTRARDOCENTE(1237, 'Jorge', 'Alvarez', '16-10-1994', 'Jorgegmail.com', 34501994, '20 avenida', 531019940101, 10000); -- correo inválido
CALL REGISTRARDOCENTE(1234, 'Arturo', 'Samayoa', '04-05-1977', 'Arturo@gmail.com', 41412003, '4 avenida', 48520030101, 25000); -- error duplicado
CALL REGISTRARDOCENTE(1237, 'Jorge', 'Alvarez', '16-10-1994', 'jorge@gmail.com', 34501994, '20 avenida', 531019940101, -10000); -- salario negativo
CALL REGISTRARDOCENTE(1237, 'Jorge', 'Alvarez', '16-10-1994', 'jorge@gmail.com', 34501994, '20 avenida', 531019940101, 100000); -- salario mayor a 99,000

SELECT * FROM CATEDRATICO;
SELECT * FROM ESTUDIANTE;
-- ########################### CREAR CURSO PENSUM ###########################
-- Formato CrearCursoPensum(codigo, nombre, creditos_necesarios, creditos_otorga, obligatorio, plan)
CALL CREARCURSOPENSUM(2, 'Mate 2', 0, 5, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(1, 'Mate 1', 0, 3, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(4, 'Fisica', 0, 3, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(8, 'Fisica 2', 0, 3, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(41, 'IPC 1', 0, 4, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(42, 'Logica de sistemas', 0, 3, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(105, 'Archivos', 0, 4, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(106, 'Compi 1', 0, 5, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(107, 'Bases 1', 0, 4, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(108, 'Bases 2', 0, 4, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(202, 'Practicas', 21, 0, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(111, 'Filosofia', 12, 3, 0, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(205, 'Seminario', 25, 3, 1, 2, 0, 0); -- ok
CALL CREARCURSOPENSUM(55, 'Dibujo', 0, 2, 0, 1, 0, 0); -- ok
CALL CREARCURSOPENSUM(202, 'Practicas', 21, 0, 1, 2, 0, 0); -- error duplicado
CALL CREARCURSOPENSUM(5, 'Error 1', -25, 3, 0, 1, 0, 0); -- número inválido
CALL CREARCURSOPENSUM(6, 'Error 2', 0, -50, 0, 1, 0, 0); -- número inválido
CALL CREARCURSOPENSUM(7, 'Error 3', 1, 1, 0, 3, 0, 0); -- no existe plan-carrera

SELECT * FROM PENSUM;
-- ########################### AGREGAR PRERREQUISITO ###########################
-- Formato AgregarPrerrequisito(curso, prerrequisito)
CALL AGREGARPREREQUISITO(41, 2); -- ok
CALL AGREGARPREREQUISITO(41, 4); -- ok
CALL AGREGARPREREQUISITO(2, 1); -- ok
CALL AGREGARPREREQUISITO(8, 4); -- ok
CALL AGREGARPREREQUISITO(42, 1); -- ok
CALL AGREGARPREREQUISITO(105, 107); -- ok
CALL AGREGARPREREQUISITO(105, 41); -- ok
CALL AGREGARPREREQUISITO(106, 107); -- ok
CALL AGREGARPREREQUISITO(106, 41); -- ok
CALL AGREGARPREREQUISITO(107, 42); -- ok
CALL AGREGARPREREQUISITO(108, 107); -- ok
CALL AGREGARPREREQUISITO(108, 105); -- ok
CALL AGREGARPREREQUISITO(205, 105); -- ok
CALL AGREGARPREREQUISITO(108, 222); -- error no existe prerrequisito
CALL AGREGARPREREQUISITO(121, 108); -- error no existe curso

SELECT * FROM PRERREQ;

-- ########################### CREAR SECCION CURSO ###########################
-- Formato CrearSeccionCurso(curso, ciclo, docente, seccion), id autoincremental se considera para lo demas un orden ascendente iniciando en 1
CALL CREARSECCIONCURSO(1, '1S', 1234, 'A'); -- ok
CALL CREARSECCIONCURSO(1, '1S', 1236, 'B'); -- ok
CALL CREARSECCIONCURSO(2, 'VJ', 1234, 'A'); -- ok
CALL CREARSECCIONCURSO(4, '1S', 1235, 'B'); -- ok
CALL CREARSECCIONCURSO(8, 'VJ', 1235, 'N'); -- ok
CALL CREARSECCIONCURSO(42, 'VJ', 1236, 'A'); -- ok
CALL CREARSECCIONCURSO(41, '2S', 1236, 'B'); -- ok
CALL CREARSECCIONCURSO(107, '2S', 1234, 'A'); -- ok
CALL CREARSECCIONCURSO(111, '2S', 1235, 'P'); -- ok
CALL CREARSECCIONCURSO(105, 'VD', 1235, 'A'); -- ok
CALL CREARSECCIONCURSO(106, 'VD', 1234, 'A'); -- ok
CALL CREARSECCIONCURSO(202, '1S', 1234, 'A'); -- ok
CALL CREARSECCIONCURSO(205, '1S', 1235, 'B'); -- ok
CALL CREARSECCIONCURSO(108, '1S', 1236, 'A'); -- ok
CALL CREARSECCIONCURSO(108, '1S', 1236, 'D'); -- ok
CALL CREARSECCIONCURSO(55, '1S', 1236, 'A'); -- ok
CALL CREARSECCIONCURSO(106, 'VD', 1236, 'A'); -- error duplicado
CALL CREARSECCIONCURSO(303, 'VD', 1236, 'A'); -- error curso no existe
CALL CREARSECCIONCURSO(111, 'VB', 1236, 'A'); -- error ciclo no valido
CALL CREARSECCIONCURSO(1, 'VD', 1237, 'A'); -- error docente no existe
CALL CREARSECCIONCURSO(1, 'VD', 1236, '2'); -- error seccion no valida
SELECT * FROM SECCION;

-- ########################### AGREGAR HORARIO ###########################
-- Formato AgregarHorario(seccion, periodo, dia, salon)
CALL AGREGARHORARIO(1, 1, 2, 1); -- ok
CALL AGREGARHORARIO(2, 1, 1, 1); -- ok
CALL AGREGARHORARIO(3, 2, 2, 2); -- ok
CALL AGREGARHORARIO(4, 3, 1, 3); -- ok
CALL AGREGARHORARIO(100, 4, 2, 1); -- error seccion no existe
CALL AGREGARHORARIO(1, 50, 2, 1); -- error periodo no existe
CALL AGREGARHORARIO(1, 1, 8, 1); -- error dia no existe, solo si tienen tablas
CALL AGREGARHORARIO(1, 1, 2, 100); -- error salon no existe, solo si tienen tablas
SELECT * FROM HORARIO;
-- ########################### ASIGNAR CURSO ###########################
-- Formato AsignarCurso(id_seccion, carnet)
CALL ASIGNARCURSO(1, 201506554); -- ok
CALL ASIGNARCURSO(1, 201818477); -- ok
CALL ASIGNARCURSO(2, 201902238); -- ok
CALL ASIGNARCURSO(4, 201902238); -- ok
CALL ASIGNARCURSO(4, 201506554); -- ok
CALL ASIGNARCURSO(4, 201818477); -- ok
CALL ASIGNARCURSO(2, 201506554); -- error ya esta asignado a otra seccion 
CALL ASIGNARCURSO(1, 201506554); -- error duplicado, ya esta asignado
CALL ASIGNARCURSO(3, 201506554); -- error no tiene aprobado el curso prerrequisito
CALL ASIGNARCURSO(100, 201506554); -- error la seccion no existe
SELECT * FROM ASIGNACION;

-- ########################### Visualizacion hasta ahora ###########################
VAR CC REFCURSOR;
CALL CONSULTARPENSUM(2, :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARPENSUM(1, :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARPENSUM(3, :CC); -- error no existe carrera
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARESTUDIANTE(201506554, :CC); -- ok
PRINT CC;

VAR CC REFCURSOR;
CALL CONSULTARESTUDIANTE(201818477, :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARESTUDIANTE(201905743, :CC); -- no existe estudiante
PRINT CC;

VAR CC REFCURSOR;
CALL CONSULTARDOCENTE(1234, :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARDOCENTE(1235, :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARDOCENTE(1238, :CC); -- no existe docente
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(1, '1S', 2024, 'B', :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(1, '1S', 2024, 'A', :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(4, '1S', 2024, 'B', :CC); -- ok, deberia mostrar 3 estudiantes
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(1, '1S', 2024, 'N', :CC); -- error la seccion no existe
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(1, '2S', 2024, 'B', :CC); -- error no hay seccion en ese ciclo
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(1, '1S', 2023, 'B', :CC); -- error no hay ciclo en ese año
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(1, '1S', 2024, '8', :CC); -- error seccion no valida
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARHORARIO(201506554, '1S', 2024, :CC); -- ok
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARHORARIO(201905743, '1S', 2024, :CC); -- error el estudiante no existe
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARHORARIO(201506554, '1S', 2023, :CC); -- no deberia mostrar nada o error
PRINT CC;

-- ########################### INGRESO DE NOTAS ###########################
-- Formato IngresarNota(id_seccion, carnet, nota_zona, examen_final)
CALL INGRESARNOTA(1, 201506554, 47, 17); -- ok
CALL INGRESARNOTA(1, 201818477, 47, 17); -- ok
CALL INGRESARNOTA(2, 201902238, 47, 17); -- ok
CALL INGRESARNOTA(4, 201902238, 47, 12); -- ok, reprobo
CALL INGRESARNOTA(4, 201506554, 54, 12); -- ok
CALL INGRESARNOTA(1, 201818477,-35, 12); -- error nota inválida
CALL INGRESARNOTA(1, 987988787, 87, 12); -- error carnet no existe
SELECT * FROM ASIGNACION;
-- ########################### DESASIGNAR CURSO ###########################
-- Formato DesasignarCurso(id_seccion, carnet)
CALL DESASIGNARCURSO(4, 201818477); -- ok
CALL DESASIGNARCURSO(8, 201818477); -- error, el estudiante no esta asignado
VAR CC REFCURSOR;
CALL CONSULTARASIGNACIONES(4, '1S', 2024, 'B', :CC); -- deberia mostrar solo 2 estudiantes
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARCURSOSASIGNAR(201506554, :CC); -- ok, para ver que cursos se puede asignar, deberia mostrar mate 2, fisica 2 y logica
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARCURSOSASIGNAR(201902238, :CC); -- ok deberia mostrar solo mate 2 y logica ya que reprobo fisica
PRINT CC;

-- ########################### Continuamos con asignar curso e ingresar notas ###########################
CALL ASIGNARCURSO(3, 201506554); -- ok
CALL ASIGNARCURSO(5, 201506554); -- ok
CALL ASIGNARCURSO(6, 201506554); -- ok
CALL ASIGNARCURSO(9, 201506554); -- error, no cumple prerrequisitos, creditos

CALL INGRESARNOTA(3, 201506554, 54, 17); -- ok
CALL INGRESARNOTA(5, 201506554, 61, 7); -- ok
CALL INGRESARNOTA(6, 201506554, 58, 18); -- ok
VAR CC REFCURSOR;
CALL CONSULTARESTUDIANTE(201506554, :CC); -- ok, para ver como va
PRINT CC;

CALL ASIGNARCURSO(9, 201506554); -- ok, ahora si cumple prerrequisitos
CALL ASIGNARCURSO(7, 201506554); -- ok
CALL ASIGNARCURSO(8, 201506554); -- ok

CALL INGRESARNOTA(9, 201506554, 54, 17); -- ok
CALL INGRESARNOTA(7, 201506554, 61, 7); -- ok
CALL INGRESARNOTA(8, 201506554, 58, 18); -- ok

CALL CONSULTARESTUDIANTE(201506554, :CC); -- ok, para ver como va
PRINT CC;

CALL CONSULTARCURSOSASIGNAR(201506554, :CC);
PRINT CC;

CALL ASIGNARCURSO(11, 201506554); -- ok
CALL ASIGNARCURSO(10, 201506554); -- ok
CALL ASIGNARCURSO(12, 201506554); -- ok

CALL INGRESARNOTA(11, 201506554, 54, 17); -- ok
CALL INGRESARNOTA(10, 201506554, 61, 7); -- ok
CALL INGRESARNOTA(12, 201506554, 58, 18); -- ok

CALL CONSULTARESTUDIANTE(201506554, :CC); -- ok, para ver como va
PRINT CC;

CALL ASIGNARCURSO(13, 201506554); -- ok
CALL ASIGNARCURSO(14, 201506554); -- ok
CALL ASIGNARCURSO(15, 201506554); -- error ya esta asignado a la A

CALL INGRESARNOTA(13, 201506554, 54, 17); -- ok
CALL INGRESARNOTA(14, 201506554, 61, 7); -- ok

CALL CONSULTARESTUDIANTE(201506554, :CC); -- ok, para ver como va ya cerro en teoria
PRINT CC;

-- ########################### MAs CONSULTAS ###########################
VAR CC REFCURSOR;
CALL CONSULTARAPROBACIONES(1, '1S', 2024, 'A', :CC); 
PRINT CC;
VAR CC REFCURSOR;
CALL CONSULTARAPROBACIONES(4, '1S', 2024, 'B', :CC); 
PRINT CC;

--CALL InsertarColumna();

-- ########################### ADICIONAL ###########################

-- Deben realizar consultas select para visualizar el contenido de las tablas cuando se requiera y tambien la de los triggers
-- ejemplo select * from Historial;

SELECT * FROM BITACORA;