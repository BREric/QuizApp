CREATE OR REPLACE TRIGGER trg_examen_no_update
AFTER UPDATE ON examen
                 FOR EACH ROW
DECLARE
v_count NUMBER;
BEGIN
    -- Verificar si existen parciales presentados para el examen que se está intentando modificar
SELECT COUNT(*)
INTO v_count
FROM parcial_presentado
WHERE examen_codigoexamen = :OLD.codigoexamen;

-- Si se encuentra al menos un parcial presentado, generar un error
IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el examen porque ya ha sido presentado por algún alumno.');
END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_insertar_pregunt_cant
AFTER INSERT ON examen
FOR EACH ROW
DECLARE
v_exam_cod INTEGER := :NEW.codigoexamen; -- Código del examen recién insertado
BEGIN
FOR i IN 1..:NEW.cantpreguntasalumno LOOP
        -- Seleccionar de forma aleatoria una pregunta de la tabla pregunta
        INSERT INTO pregunta_examen (pregunta_codigopregunta, examen_codigoexamen)
SELECT codigopregunta, v_exam_cod
FROM (
         SELECT codigopregunta
         FROM pregunta
         ORDER BY DBMS_RANDOM.VALUE -- Ordenar aleatoriamente las preguntas
     )
WHERE ROWNUM = 1; -- Seleccionar solo una pregunta aleatoria
END LOOP;
END;
/

CREATE OR REPLACE TRIGGER trg_set_start_time
BEFORE INSERT ON parcial_presentado
FOR EACH ROW
BEGIN
    -- Establecer la fecha y hora de inicio del examen como la fecha y hora actual
    :NEW.fecha_hora_inicio := SYSDATE;
END;
/