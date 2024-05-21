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

CREATE OR REPLACE TRIGGER trg_validar_password
    BEFORE INSERT OR UPDATE ON cuenta
    FOR EACH ROW
DECLARE
    v_old_password cuenta.password%TYPE;
BEGIN
    IF :NEW.password IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'La contraseña no puede estar vacía.');
    END IF;

    SELECT password INTO v_old_password
    FROM cuenta
    WHERE codigocuenta = :NEW.codigocuenta;

    IF :NEW.password = v_old_password THEN
        RAISE_APPLICATION_ERROR(-20002, 'La nueva contraseña no puede ser igual a la anterior.');
    END IF;

END;
/

CREATE OR REPLACE TRIGGER trg_validar_correo_y_cedula
    BEFORE INSERT OR UPDATE ON cuenta
    FOR EACH ROW
DECLARE
    v_correo_existente NUMBER;
    v_cedula_existente NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_correo_existente
    FROM cuenta
    WHERE email = :NEW.email;

    IF v_correo_existente > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'El correo electrónico ya está registrado.');
    END IF;

    SELECT COUNT(*)
    INTO v_cedula_existente
    FROM usuario
    WHERE cedula = :NEW.cedula;

    IF v_cedula_existente > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'La cédula ya está registrada.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_crear_docente
    INSTEAD OF INSERT ON VW_DOCENTES
    FOR EACH ROW
DECLARE
    v_usuario_codigocuenta INTEGER;
    v_usuario_cuenta_codigocuenta INTEGER;
BEGIN
    INSERT INTO cuenta (codigocuenta, email, password, estado)
    VALUES (:NEW.idDocente, :NEW.correo, :NEW.passwordcuenta, 'Activo')
    RETURNING codigocuenta INTO v_usuario_codigocuenta;

    INSERT INTO usuario (cuenta_codigocuenta, cedula, nombre)
    VALUES (v_usuario_codigocuenta, :NEW.ceduladocente, :NEW.nombredocente);

    INSERT INTO docente (usuario_codigousuario, usuario_cuenta_codigo)
    VALUES (:NEW.idDocente, v_usuario_codigocuenta);
END;
/

CREATE OR REPLACE TRIGGER trg_crear_alumno
    INSTEAD OF INSERT ON VW_ALUMNOS
    FOR EACH ROW
DECLARE
    v_usuario_codigocuenta INTEGER;
    v_usuario_cuenta_codigocuenta INTEGER;
BEGIN
    INSERT INTO cuenta (codigocuenta, email, password, estado)
    VALUES (:NEW.idAlumno, :NEW.correo, :NEW.passwordcuenta, 'Activo')
    RETURNING codigocuenta INTO v_usuario_codigocuenta;

    -- Insertar en la tabla usuario
    INSERT INTO usuario (cuenta_codigocuenta, cedula, nombre)
    VALUES (v_usuario_codigocuenta, :NEW.cedulaalumno, :NEW.nombrealumno);

    -- Insertar en la tabla alumno
    INSERT INTO alumno (usuario_codigousuario, usuario_cuenta_codigo)
    VALUES (:NEW.idAlumno, v_usuario_codigocuenta);
END;
/

--------------------------------PROCEDIMIENTOS----------------------------------------------------------
