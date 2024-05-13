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

CREATE OR REPLACE TRIGGER calcular_puntaje_parcial
    BEFORE INSERT ON parcial_presentado
    FOR EACH ROW
DECLARE
    v_preguntas_totales INTEGER;
    v_respuestas_correctas INTEGER;
    v_respuestas_estudiante INTEGER;
    v_puntaje FLOAT;
BEGIN
    -- Obtener el total de preguntas del examen
    SELECT COUNT(*) INTO v_preguntas_totales
    FROM pregunta_examen pe
    WHERE pe.examen_codigoexamen = :NEW.examen_codigoexamen;

    -- Obtener el número de respuestas correctas proporcionadas por el estudiante
    SELECT COUNT(DISTINCT op.codigoopcion) INTO v_respuestas_correctas
    FROM opciones_pregunta op
             JOIN pregunta_examen pe ON op.pregunta_codigopregunta = pe.pregunta_codigopregunta
    WHERE pe.examen_codigoexamen = :NEW.examen_codigoexamen
      AND op.codigoopcion IN (
        SELECT po.codigoopcion
        FROM opciones_pregunta po
        WHERE po.p_a_a_usuario_codigousuario = :NEW.alumno_usuario_codigousuario
          AND po.p_p_p_e_e_codigoexamen = :NEW.examen_codigoexamen
    );

    -- Obtener el número total de respuestas proporcionadas por el estudiante
    SELECT COUNT(*) INTO v_respuestas_estudiante
    FROM opciones_pregunta po
    WHERE po.p_a_a_usuario_codigousuario = :NEW.alumno_usuario_codigousuario
      AND po.p_p_p_e_e_codigoexamen = :NEW.examen_codigoexamen;

    -- Calcular el puntaje obtenido en base a las respuestas correctas
    IF v_respuestas_estudiante > 0 THEN
        v_puntaje := (v_respuestas_correctas / v_respuestas_estudiante) * 100;
    ELSE
        v_puntaje := 0; -- En caso de que no haya respondido ninguna pregunta
    END IF;

    -- Asignar el puntaje calculado al campo puntaje_obtenido
    :NEW.puntaje_obtenido := v_puntaje;
END;
/
/