CREATE OR REPLACE TRIGGER actualizar_puntaje_trigger
    AFTER INSERT OR UPDATE ON respuesta_alumno
    FOR EACH ROW
DECLARE
    nuevo_puntaje FLOAT;
BEGIN
    -- Recalcular el puntaje total para el parcial presentado
    nuevo_puntaje := calcular_puntaje_obtenido(:NEW.pa_codigopp);

    -- Actualizar el campo puntaje_obtenido en parcial_presentado
    UPDATE parcial_presentado
    SET puntaje_obtenido = nuevo_puntaje
    WHERE codigopp = :NEW.pa_codigopp;
END;



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
    SELECT COUNT(*)
    INTO v_preguntas_totales
    FROM pregunta_examen pe
    WHERE pe.examen_codigoexamen = :NEW.examen_codigoexamen;

    -- Obtener el número de respuestas correctas proporcionadas por el estudiante
    SELECT COUNT(DISTINCT op.codigoopcion)
    INTO v_respuestas_correctas
    FROM opciones_pregunta op
             JOIN pregunta_examen pe ON op.pregunta_codigopregunta = pe.pregunta_codigopregunta
             JOIN respuesta_alumno ra ON op.codigoopcion = ra.id_respuesta
    WHERE pe.examen_codigoexamen = :NEW.examen_codigoexamen
      AND ra.pa_pe_codigoexamen = :NEW.examen_codigoexamen
      AND ra.pa_codigopp = :NEW.alumno_usuario_codigousuario; -- Asegúrate de que esta columna es la correcta

    -- Obtener el número total de respuestas proporcionadas por el estudiante
    SELECT COUNT(*)
    INTO v_respuestas_estudiante
    FROM respuesta_alumno ra
    WHERE ra.pa_pe_codigoexamen = :NEW.examen_codigoexamen
      AND ra.pa_codigopp = :NEW.alumno_usuario_codigousuario; -- Asegúrate de que esta columna es la correcta

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
    SELECT COUNT(*)
    INTO v_preguntas_totales
    FROM pregunta_examen pe
    WHERE pe.examen_codigoexamen = :NEW.examen_codigoexamen;

    -- Obtener el número de respuestas correctas proporcionadas por el estudiante
    SELECT COUNT(DISTINCT op.codigoopcion)
    INTO v_respuestas_correctas
    FROM opciones_pregunta op
             JOIN pregunta_examen pe ON op.pregunta_codigopregunta = pe.pregunta_codigopregunta
             JOIN respuesta_alumno ra ON op.codigoopcion = ra.id_respuesta
    WHERE pe.examen_codigoexamen = :NEW.examen_codigoexamen
      AND ra.pa_pe_codigoexamen = :NEW.examen_codigoexamen
      AND ra.pa_codigopp = :NEW.alumno_usuario_codigousuario; -- Asegúrate de que esta columna es la correcta

    -- Obtener el número total de respuestas proporcionadas por el estudiante
    SELECT COUNT(*)
    INTO v_respuestas_estudiante
    FROM respuesta_alumno ra
    WHERE ra.pa_pe_codigoexamen = :NEW.examen_codigoexamen
      AND ra.pa_codigopp = :NEW.alumno_usuario_codigousuario; -- Asegúrate de que esta columna es la correcta

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

CREATE OR REPLACE TRIGGER trg_validar_correo_y_cedula
    BEFORE INSERT OR UPDATE ON cuenta
    FOR EACH ROW
DECLARE
    v_correo_existente NUMBER;
    v_cedula_existente NUMBER;
BEGIN
    -- Validar que el correo electrónico no esté registrado en la tabla cuenta
    SELECT COUNT(*)
    INTO v_correo_existente
    FROM cuenta
    WHERE email = :NEW.email AND codigocuenta != :NEW.codigocuenta;

    IF v_correo_existente > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'El correo electrónico ya está registrado.');
    END IF;

    -- Validar que la cédula no esté registrada en la tabla usuario
    -- Asumiendo que la cédula se pasa como un campo adicional en la tabla cuenta
    IF :NEW.codigocuenta IS NOT NULL THEN
        SELECT COUNT(*)
        INTO v_cedula_existente
        FROM usuario
        WHERE cedula = (SELECT cedula FROM usuario WHERE cuenta_codigocuenta = :NEW.codigocuenta);

        IF v_cedula_existente > 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'La cédula ya está registrada.');
        END IF;
    END IF;
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



CREATE OR REPLACE TRIGGER trg_actualizar_estado_examen
    BEFORE UPDATE ON examen
    FOR EACH ROW
BEGIN
    IF SYSTIMESTAMP BETWEEN :new.fecha_hora_inicio AND :new.fecha_hora_fin THEN
        :new.estado := 'EN CURSO';
    ELSIF SYSTIMESTAMP > :new.fecha_hora_fin THEN
        :new.estado := 'FINALIZADO';
    ELSE
        :new.estado := 'PENDIENTE';
    END IF;
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
    INSERT INTO VW_ALUMNOS (idAlumno, correo, passwordcuenta, cedulaalumno, nombrealumno, ESTADO)
    VALUES (p_idAlumno, p_correo, p_passwordcuenta, p_cedulaalumno, p_nombrealumno, 'ACTIVO');

    -- Devolver el código del alumno creado
    RETURN p_idAlumno;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores
        RAISE_APPLICATION_ERROR(-20005, 'Error al crear el alumno: ');
END crear_alumno;
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

CREATE OR REPLACE PROCEDURE listar_docentes (v_docentes OUT SYS_REFCURSOR) AS
BEGIN
    OPEN v_docentes FOR
        SELECT * FROM VW_DOCENTES WHERE estado = 'ACTIVO';
END;
/

---------------------------------------------------------------------------------
--posibles metodos
--adicionar las preguntas al examen que falten (cambio de estado a finalizado) no olvidar considerar las preguntas compuestas

-- Crear procedimiento para agregar un nuevo examen
create or replace PROCEDURE crear_examen (
    p_nombre_examen IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_tema_id IN INTEGER,
    p_cantidad_preguntas IN INTEGER,
    p_peso_examen IN INTEGER, -- Ajusta el tipo de dato según corresponda en tu base de datos
    p_fecha_inicio IN TIMESTAMP,
    p_fecha_fin IN TIMESTAMP
) AS
    v_examen_id INTEGER;
    v_pregunta_id INTEGER;
BEGIN
    -- Validar que el tema del examen exista
    BEGIN
        SELECT 1
        INTO v_examen_id
        FROM tema
        WHERE codigocontenido = p_tema_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20061, 'El tema del examen no existe.');
    END;

    -- Insertar el examen
    INSERT INTO examen (nombre, descripcion, tema_codigocontenido, cantpreguntas, pesoexamen, fecha_hora_inicio, fecha_hora_fin, estado)
    VALUES (p_nombre_examen, p_descripcion, p_tema_id, p_cantidad_preguntas, p_peso_examen, p_fecha_inicio, p_fecha_fin, 'PENDIENTE')
    RETURNING codigoexamen INTO v_examen_id;

    -- Lógica para seleccionar y agregar preguntas al examen
    FOR i IN 1..p_cantidad_preguntas LOOP
            -- Seleccionar una pregunta aleatoria del tema del examen
            SELECT codigopregunta
            INTO v_pregunta_id
            FROM (
                     SELECT codigopregunta
                     FROM pregunta
                     WHERE tema_codigocontenido = p_tema_id
                     ORDER BY DBMS_RANDOM.VALUE
                 )
            WHERE ROWNUM = 1; -- Seleccionar solo una pregunta aleatoria

            -- Agregar la pregunta al examen
            INSERT INTO pregunta_examen (pregunta_codigopregunta, examen_codigoexamen)
            VALUES (v_pregunta_id, v_examen_id);
        END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20062, 'Error al crear el examen: ' || SQLERRM);
END crear_examen;

--Adicionar las preguntas al examen del alumno:
CREATE OR REPLACE PROCEDURE agregar_preguntas_examen(
    p_idExamen IN INTEGER,
    p_idAlumno IN INTEGER
) AS
    v_count INTEGER;
BEGIN
    -- Verificar que el examen exista
    SELECT COUNT(*)
    INTO v_count
    FROM examen
    WHERE codigoexamen = p_idExamen;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20071, 'El examen especificado no existe.');
    END IF;

    -- Verificar que el alumno exista
    SELECT COUNT(*)
    INTO v_count
    FROM alumno
    WHERE usuario_codigousuario = p_idAlumno;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20072, 'El alumno especificado no existe.');
    END IF;

    -- Insertar preguntas del examen en la tabla pregunta_alumno para el alumno específico
    INSERT INTO pregunta_alumno (pe_examen_codigoexamen, pe_pregunta_codigopregunta, parcial_presentado_codigopp)
    SELECT pe.examen_codigoexamen, pe.pregunta_codigopregunta, NULL
    FROM pregunta_examen pe
    WHERE pe.examen_codigoexamen = p_idExamen;

    DBMS_OUTPUT.PUT_LINE('Preguntas agregadas al examen exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores
        RAISE_APPLICATION_ERROR(-20073, 'Error al agregar preguntas al examen: ' || SQLERRM);
END;
/

--Calificar el examen una vez finalizado:
CREATE OR REPLACE PROCEDURE calificar_examen(
    p_idExamen IN INTEGER,
    p_idAlumno IN INTEGER
) AS
    v_puntaje_total FLOAT;
BEGIN
    -- Calcular el puntaje total del examen
    SELECT SUM(pa.puntaje_obtenido)
    INTO v_puntaje_total
    FROM parcial_presentado pa
    WHERE pa.examen_codigoexamen = p_idExamen
      AND pa.alumno_usuario_codigousuario = p_idAlumno;

    -- Actualizar el registro en la tabla parcial_presentado con el puntaje total
    UPDATE parcial_presentado
    SET puntaje_obtenido = v_puntaje_total
    WHERE examen_codigoexamen = p_idExamen
      AND alumno_usuario_codigousuario = p_idAlumno;
END;
/
--Validar que el alumno pueda presentar el examen:
CREATE OR REPLACE FUNCTION validar_presentacion_examen(
    p_idExamen IN INTEGER,
    p_idAlumno IN INTEGER
) RETURN BOOLEAN AS
    v_valido NUMBER; -- Cambiado a tipo NUMBER
BEGIN
    -- Verificar si el examen está pendiente y el alumno pertenece al grupo del examen
    SELECT COUNT(*)
    INTO v_valido
    FROM VW_EXAMENES_PENDIENTES ep
             JOIN VW_ESTUDIANTES_POR_GRUPO eg ON ep.idExamen = p_idExamen
    WHERE ep.idExamen = p_idExamen
      AND eg.idEstudiante = p_idAlumno;

    -- Si v_valido es mayor que cero, significa que el alumno puede presentar el examen
    IF v_valido = 1 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END;
/

--Validar la finalización del examen:
CREATE OR REPLACE PROCEDURE validar_finalizacion_examen (
    p_idExamen IN INTEGER
) AS
    v_tiempo_transcurrido NUMBER;
    v_duracion_maxima TIMESTAMP WITH TIME ZONE; -- Cambiada la variable a TIMESTAMP WITH TIME ZONE
BEGIN
    -- Obtener el tiempo transcurrido desde el inicio del examen
    SELECT EXTRACT(HOUR FROM (SYSTIMESTAMP - fecha_hora_inicio)) -- Extraer horas desde el inicio del examen
    INTO v_tiempo_transcurrido
    FROM examen
    WHERE codigoexamen = p_idExamen;

    -- Obtener la duración máxima del examen
    SELECT tiempo_limite
    INTO v_duracion_maxima
    FROM examen
    WHERE codigoexamen = p_idExamen;

    -- Verificar si el tiempo transcurrido supera la duración máxima del examen
    IF v_tiempo_transcurrido > v_duracion_maxima THEN
        -- Marcar el examen como finalizado
        UPDATE examen
        SET estado = 'FINALIZADO'
        WHERE codigoexamen = p_idExamen;

        DBMS_OUTPUT.PUT_LINE('El examen ha sido finalizado automáticamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El examen aún está en curso.');
    END IF;
END;


CREATE OR REPLACE PROCEDURE iniciar_sesion_docente_proc (
    p_email IN VARCHAR2,
    p_password IN VARCHAR2,
    v_docente OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN v_docente FOR
        SELECT d.IDDOCENTE id, c.email correo, d.PASSWORDCUENTA contra
        FROM VW_DOCENTES d
                 JOIN CUENTA c ON d.IDDOCENTE = c.codigocuenta
        WHERE c.email = p_email
          AND c.password = p_password
          AND c.estado = 'ACTIVO';
END;
/


CREATE OR REPLACE PROCEDURE iniciar_sesion_alumno_proc (
    p_email IN VARCHAR2,
    p_password IN VARCHAR2,
    v_alumno OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN v_alumno FOR
        SELECT a.idAlumno id, c.email correo, a.PASSWORDCUENTA contra
        FROM VW_ALUMNOS a
                 JOIN CUENTA c ON a.idAlumno = c.codigocuenta
        WHERE c.email = p_email
          AND c.password = p_password
          AND c.estado = 'ACTIVO';
END;
/


CREATE OR REPLACE FUNCTION calcular_puntaje_obtenido (codigopp IN INTEGER)
    RETURN FLOAT IS
    puntaje_total FLOAT := 0;
BEGIN
    SELECT COALESCE(SUM(puntaje_subpregunta), 0)
    INTO puntaje_total
    FROM (
             -- Subconsulta para calcular el puntaje de las preguntas principales
             SELECT SUM(op.puntaje * pe.porcentaje_pregunta / 100) AS puntaje_subpregunta
             FROM respuesta_alumno ra
                      JOIN opciones_pregunta op ON ra.pa_pe_codigopregunta = op.pregunta_codigopregunta
                      JOIN pregunta_examen pe ON ra.pa_pe_codigoexamen = pe.examen_codigoexamen
                 AND ra.pa_pe_codigopregunta = pe.pregunta_codigopregunta
                      JOIN pregunta p ON pe.pregunta_codigopregunta = p.codigopregunta
             WHERE ra.pa_codigopp = codigopp
               AND p.pregunta_codigopregunta IS NULL -- Solo preguntas principales
             GROUP BY ra.pa_codigopp

             UNION ALL

             -- Subconsulta recursiva para calcular el puntaje de las subpreguntas
             SELECT COALESCE(SUM(sub.puntaje_subpregunta), 0)
             FROM (
                      SELECT SUM(op.puntaje * pe.porcentaje_pregunta / 100) AS puntaje_subpregunta
                      FROM respuesta_alumno ra
                               JOIN opciones_pregunta op ON ra.pa_pe_codigopregunta = op.pregunta_codigopregunta
                               JOIN pregunta_examen pe ON ra.pa_pe_codigoexamen = pe.examen_codigoexamen
                          AND ra.pa_pe_codigopregunta = pe.pregunta_codigopregunta
                      WHERE ra.pa_codigopp = codigopp
                        AND p.pregunta_codigopregunta = p.codigopregunta -- Subpreguntas relacionadas a preguntas principales
                      GROUP BY ra.pa_codigopp
                  ) sub
         );

    RETURN puntaje_total;
END;
/
--Para añadirle el codigo del examen de manera automatica
CREATE OR REPLACE TRIGGER trg_codigoexamen
    BEFORE INSERT ON examen
    FOR EACH ROW
BEGIN
    IF :NEW.codigoexamen IS NULL THEN
        :NEW.codigoexamen := seq_codigoexamen.NEXTVAL;
    END IF;
END;
/



