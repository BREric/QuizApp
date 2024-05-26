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

c

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

CREATE OR REPLACE TRIGGER trg_actualizar_alumnos
    INSTEAD OF UPDATE ON VW_ALUMNOS
    FOR EACH ROW
BEGIN
    -- Actualizar los datos en las tablas subyacentes
    UPDATE CUENTA
    SET email = :NEW.correo,
        password = :NEW.passwordcuenta
    WHERE CODIGOCUENTA = :OLD.idAlumno;

    UPDATE USUARIO
    SET nombre = :NEW.nombrealumno
    WHERE cuenta_codigocuenta = :OLD.idAlumno;
END;
/

CREATE OR REPLACE TRIGGER trg_update_vw_docentes
    INSTEAD OF UPDATE ON VW_DOCENTES
    FOR EACH ROW
BEGIN
    -- Actualizar la tabla CUENTA
    UPDATE CUENTA
    SET email = :new.correo,
        password = :new.passwordcuenta
    WHERE codigocuenta = :old.idDocente;

    -- Actualizar la tabla USUARIO
    UPDATE USUARIO
    SET cedula = :new.ceduladocente,
        nombre = :new.nombredocente
    WHERE cuenta_codigocuenta = :old.idDocente;
END;
/

--------------------------------PROCEDIMIENTOS----------------------------------------------------------



CREATE OR REPLACE FUNCTION crear_alumno(
    p_idAlumno          IN INTEGER,
    p_correo            IN VARCHAR2,
    p_passwordcuenta    IN VARCHAR2,
    p_cedulaalumno      IN INTEGER,
    p_nombrealumno      IN VARCHAR2
) RETURN INTEGER IS
BEGIN
    -- Insertar en la vista VW_ALUMNOS
    INSERT INTO VW_ALUMNOS (idAlumno, correo, passwordcuenta, cedulaalumno, nombrealumno)
    VALUES (p_idAlumno, p_correo, p_passwordcuenta, p_cedulaalumno, p_nombrealumno);

    -- Devolver el código del alumno creado
    RETURN p_idAlumno;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores
        RAISE_APPLICATION_ERROR(-20005, 'Error al crear el alumno: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE actualizar_alumno(
    p_idAlumno IN INTEGER,
    p_correo IN VARCHAR2,
    p_passwordcuenta IN VARCHAR2,
    p_nombrealumno IN VARCHAR2
) AS
BEGIN
    -- Actualizar la vista para activar el disparador INSTEAD OF
    UPDATE VW_ALUMNOS
    SET correo = p_correo,
        passwordcuenta = p_passwordcuenta,
        nombrealumno = p_nombrealumno
    WHERE idAlumno = p_idAlumno;
END;
/

CREATE OR REPLACE FUNCTION obtener_alumno(p_idAlumno IN INTEGER) RETURN SYS_REFCURSOR AS
    v_alumno SYS_REFCURSOR;
BEGIN
    OPEN v_alumno FOR
        SELECT * FROM VW_ALUMNOS WHERE idAlumno = p_idAlumno;
    RETURN v_alumno;
END;
/

CREATE OR REPLACE FUNCTION buscar_alumno(p_idAlumno IN INTEGER) RETURN SYS_REFCURSOR AS
    v_alumno SYS_REFCURSOR;
BEGIN
    OPEN v_alumno FOR
        SELECT * FROM VW_ALUMNOS WHERE idAlumno = p_idAlumno;
    RETURN v_alumno;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_alumno(p_idAlumno IN INTEGER) AS
BEGIN
    UPDATE CUENTA
    SET estado = 'INACTIVO'
    WHERE CODIGOCUENTA = p_idAlumno;
END;
/

CREATE OR REPLACE FUNCTION listar_alumnos RETURN SYS_REFCURSOR AS
    v_alumnos SYS_REFCURSOR;
BEGIN
    OPEN v_alumnos FOR
        SELECT * FROM VW_ALUMNOS WHERE estado = 'ACTIVO';
    RETURN v_alumnos;
END;
/

CREATE OR REPLACE PROCEDURE registrar_docente(
    p_correo IN VARCHAR2,
    p_passwordcuenta IN VARCHAR2,
    p_ceduladocente IN INTEGER,
    p_nombredocente IN VARCHAR2
) AS
    v_codigoCuenta INTEGER;
BEGIN
    -- Insertar datos en la vista VW_DOCENTES
    INSERT INTO VW_DOCENTES (correo, passwordcuenta, ceduladocente, nombredocente)
    VALUES (p_correo, p_passwordcuenta, p_ceduladocente, p_nombredocente);

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE actualizarDocente(
    p_idDocente IN INTEGER,
    p_correo IN VARCHAR2,
    p_passwordcuenta IN VARCHAR2,
    p_nombredocente IN VARCHAR2
) AS
BEGIN
    -- Actualizar la vista VW_DOCENTES
    UPDATE VW_DOCENTES
    SET correo = p_correo,
        passwordcuenta = p_passwordcuenta,
        nombredocente = p_nombredocente
    WHERE idDocente = p_idDocente;
END;
/


CREATE OR REPLACE FUNCTION obtener_docente(p_idDocente IN INTEGER) RETURN SYS_REFCURSOR AS
    v_docente SYS_REFCURSOR;
BEGIN
    OPEN v_docente FOR
        SELECT * FROM VW_DOCENTES WHERE idDocente = p_idDocente;
    RETURN v_docente;
END;
/

CREATE OR REPLACE PROCEDURE eliminar_docente(p_idDocente IN INTEGER) AS
BEGIN
    -- Actualizar la tabla CUENTA para cambiar el estado a INACTIVO
    UPDATE CUENTA
    SET estado = 'INACTIVO'
    WHERE codigocuenta = p_idDocente;

    COMMIT;
END;
/

CREATE OR REPLACE FUNCTION listar_docentes RETURN SYS_REFCURSOR AS
    v_docentes SYS_REFCURSOR;
BEGIN
    OPEN v_docentes FOR
        SELECT * FROM VW_DOCENTES WHERE estado = 'ACTIVO';
    RETURN v_docentes;
END;
/




