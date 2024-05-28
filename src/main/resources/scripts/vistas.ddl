CREATE OR REPLACE VIEW VW_CURSO AS(
SELECT codigocurso idCurso, nombrecurso NombreCurso FROM curso);

CREATE OR REPLACE VIEW VW_EXAMEN AS(
SELECT codigoexamen idExamen, tema_codigocontenido idTema, cantpreguntas NumeroPreguntas,
       pesoexamen ValorExamen, fecha_hora_creacion HoraCreado, fecha_hora_inicio HoraInicio,
       fecha_hora_fin HoraFin, tiempo_limite Duracion, estado Estado
FROM examen);

CREATE OR REPLACE VIEW VW_GRUPO AS(
SELECT codigogrupo idGrupo, curso_codigocurso idCurso, docente_usuario_codigousuario idDocente
FROM grupo);

CREATE OR REPLACE VIEW VW_OPCIONES_PREGUNTA AS(
SELECT codigoopcion idOpcion, pregunta_codigopregunta idPregunta, respuesta Respuesta
FROM opciones_pregunta);

CREATE OR REPLACE VIEW VW_PARCIAL_PRESENTADO AS(
SELECT codigopp idParcial, examen_codigoexamen idExamen, alumno_usuario_codigousuario idAlumno,
       puntaje_obtenido Nota, fecha_hora_inicio HoraInicio, fecha_hora_fin HoraFin,
       tiempo_duracion Duracion
FROM parcial_presentado);

CREATE OR REPLACE VIEW VW_PREGUNTA AS(
SELECT codigopregunta idPregunta, pregunta_codigopregunta idPreguntaRelacionada, estado Estado,
       visibilidad Visibilidad, tipo_pregunta TipoPregunta, descripcion Descripcion,
       docente_usuario_codigousuario idDocente, tema_codigocontenido idTema
FROM pregunta);

CREATE OR REPLACE VIEW VW_TEMA AS(
SELECT codigocontenido idTema, unidad_codigounidad idUnidad, nombre NombreTema FROM tema);

CREATE OR REPLACE VIEW VW_UNIDAD AS(
SELECT codigounidad idUnidad, curso_codigocurso idCurso FROM unidad);

----------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW VW_INFORMACION_EXAMEN AS(
SELECT e.codigoexamen idExamen, e.nombre Nombre, e.descripcion Descripcion, t.nombre Tema,
       e.cantpreguntas NumeroPreguntas, e.pesoexamen ValorExamen, e.fecha_hora_creacion HoraCreado,
       e.fecha_hora_inicio HoraInicio, e.fecha_hora_fin HoraFin, e.tiempo_limite Duracion, e.estado Estado
FROM examen e
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido);


CREATE OR REPLACE VIEW VW_INFO_PREGUNTAS_RESPUESTA AS(
SELECT p.codigopregunta idPregunta, p.descripcion Descripcion, p.tipo_pregunta TipoPregunta, p.estado Estado,
       op.codigoopcion Opcion, op.respuesta Respuesta
FROM pregunta p
         LEFT JOIN opciones_pregunta op ON p.codigopregunta = op.pregunta_codigopregunta);


CREATE OR REPLACE VIEW VW_INFO_RESPUESTA_ALUMNO AS (
       SELECT
           pa.pe_examen_codigoexamen AS idExamen,
           pa.pe_pregunta_codigopregunta AS idPregunta,
           pp.alumno_usuario_codigousuario AS idUsuario,
           e.nombre AS nombreExamen,
           p.descripcion AS pregunta,
           po.respuesta AS respuesta,
           p.tipo_pregunta AS TipoPregunta,
           pp.puntaje_obtenido AS Nota,
           CASE
               WHEN pp.puntaje_obtenido = 5 THEN 'Perfecto'
               WHEN pp.puntaje_obtenido >= 4 THEN 'Excelente'
               WHEN pp.puntaje_obtenido >= 3 THEN 'Aceptable'
               ELSE 'Perdió'
               END AS clasificacion_nota
       FROM
           examen e
               JOIN
           parcial_presentado pp ON e.codigoexamen = pp.examen_codigoexamen
               JOIN
           pregunta_alumno pa ON pa.pe_examen_codigoexamen = pp.examen_codigoexamen
               AND pa.parcial_presentado_codigopp = pp.codigopp
               JOIN
           pregunta p ON pa.pe_pregunta_codigopregunta = p.codigopregunta
               LEFT JOIN
           opciones_pregunta po ON pa.pe_pregunta_codigopregunta = po.pregunta_codigopregunta
               JOIN
           VW_ALUMNOS a ON pp.alumno_usuario_codigousuario = a.idAlumno
           );

CREATE OR REPLACE VIEW VW_notas_estudiantes AS(
SELECT pp.alumno_usuario_codigousuario idAlumno,
       pp.examen_codigoexamen idExamen, e.nombre NombreExamen,
       pp.puntaje_obtenido Nota,
       CASE
           WHEN pp.puntaje_obtenido >= 80 THEN 'Excelente'
           WHEN pp.puntaje_obtenido >= 60 THEN 'Aceptable'
           ELSE 'Perdió'
           END AS clasificacion_nota
FROM parcial_presentado pp
         JOIN examen e ON pp.examen_codigoexamen = e.codigoexamen);

CREATE OR REPLACE VIEW VW_promedio_nota_grupo_curso AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso,
       AVG(pp.puntaje_obtenido) AS promedio_nota
FROM grupo g
         JOIN grupo_alumno ga ON g.codigogrupo = ga.grupo_codigogrupo
         JOIN parcial_presentado pp ON ga.alumno_usuario_codigousuario = pp.alumno_usuario_codigousuario
         JOIN examen e ON pp.examen_codigoexamen = e.codigoexamen
GROUP BY g.codigogrupo, g.curso_codigocurso);

CREATE OR REPLACE VIEW VW_promedio_nota_por_tema AS(
SELECT t.nombre tema,
       AVG(pp.puntaje_obtenido) promedio_nota
FROM examen e
         JOIN parcial_presentado pp ON e.codigoexamen = pp.examen_codigoexamen
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido
GROUP BY t.nombre);

CREATE OR REPLACE VIEW VW_promedio_nota_alumno AS(
SELECT a.idAlumno idEstudiante,
       AVG(pp.puntaje_obtenido) promedio_nota,
       u.nombre Nombre,
       a.correo Email,
       u.cedula Cedula
FROM parcial_presentado pp
         JOIN VW_ALUMNOS a ON pp.alumno_usuario_codigousuario = a.idAlumno
         JOIN usuario u ON a.idAlumno = u.cuenta_codigocuenta
GROUP BY a.idAlumno, u.nombre, a.correo, u.cedula);

CREATE OR REPLACE VIEW VW_DOCENTES AS(
    SELECT C.CODIGOCUENTA idDocente,
           C.email correo,
           C.password passwordcuenta,
           U.cedula ceduladocente,
           U.nombre nombredocente,
           C.estado estado
    FROM CUENTA c JOIN USUARIO u
           ON c.codigoCuenta=u.cuenta_codigocuenta
           JOIN DOCENTE D on d.usuario_cuenta_codigo=u.cuenta_codigocuenta);



CREATE OR REPLACE VIEW VW_ALUMNOS AS(
    SELECT C.CODIGOCUENTA idAlumno,
        C.email correo,
        C.password passwordcuenta,
        U.cedula cedulaalumno,
        U.nombre nombrealumno,
        C.estado estado
    FROM CUENTA c JOIN USUARIO u
       ON c.codigoCuenta=u.cuenta_codigocuenta
       JOIN ALUMNO a on a.usuario_cuenta_codigo=u.cuenta_codigocuenta);


CREATE OR REPLACE VIEW VW_PREGUNTAS_PUBLICAS AS(
SELECT p.codigopregunta idPregunta, p.descripcion Descripcion, p.estado Estado
FROM PREGUNTA p
WHERE p.visibilidad = 'PUBLICA');

CREATE OR REPLACE VIEW VW_INFORMACION_CURSO AS(
SELECT c.codigocurso idCurso,g.codigogrupo, c.nombrecurso NombreCurso, d.nombredocente NombreProfesor
FROM curso c
         JOIN
         GRUPO G ON c.codigocurso = G.curso_codigocurso
         JOIN
         VW_DOCENTES d ON g.docente_usuario_codigousuario = d.idDocente);

CREATE OR REPLACE VIEW VW_INFORMACION_GRUPO AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, g.docente_usuario_codigousuario idDocente,
       c.nombrecurso NombreCurso, d.nombredocente Nombreprofesor
FROM grupo g
         JOIN curso c ON g.curso_codigocurso = c.codigocurso
         JOIN VW_DOCENTES d ON g.docente_usuario_codigousuario = d.idDocente);

CREATE OR REPLACE VIEW VW_EXAMENES_PENDIENTES AS (
     SELECT
         e.codigoexamen AS idExamen,
         e.nombre AS NombreExamen,
         e.fecha_hora_inicio AS HoraInicio,
         e.fecha_hora_fin AS HoraFin,
         t.nombre AS Tema,
         e.estado AS EstadoExamen
     FROM
         examen e
             JOIN tema t ON e.tema_codigocontenido = t.codigocontenido
     WHERE
             e.estado = 'PENDIENTE' OR e.ESTADO = 'EN_CURSO' OR e.ESTADO = 'ACTIVO'
         );



CREATE OR REPLACE VIEW VW_PROFESORES_POR_CURSO AS(
SELECT c.codigocurso idCurso, c.nombrecurso NombreCurso,
       d.nombredocente Nombreprofesor, d.correo EmailDocente
FROM curso c
         JOIN grupo g ON g.curso_codigocurso = c.codigocurso
         JOIN VW_DOCENTES d ON g.docente_usuario_codigousuario = d.idDocente);

CREATE OR REPLACE VIEW VW_EXAMENES_REALIZADOS AS(
SELECT e.codigoexamen idExamen, e.nombre NombreExamen, e.fecha_hora_inicio HoraInicio, e.fecha_hora_fin HoraFin,
       t.nombre Tema, e.estado EstadoExamen
FROM examen e
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido
WHERE e.ESTADO = 'REALIZADO');


CREATE OR REPLACE VIEW VW_GRUPOS_POR_CURSO AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, g.docente_usuario_codigousuario idDocente,
       c.nombrecurso NombreCurso, d.nombredocente NombreProfesor
FROM grupo g
         JOIN curso c ON g.curso_codigocurso = c.codigocurso
         JOIN VW_DOCENTES d ON g.docente_usuario_codigousuario = d.iddocente);


CREATE OR REPLACE VIEW VW_RESUMEN_EXAMENES_POR_GRUPO AS
SELECT
    g.codigogrupo AS idGrupo,
    g.curso_codigocurso AS idCurso,
    e.codigoexamen AS idExamen,
    e.nombre AS NombreExamen,
    t.nombre AS Tema,
    e.estado AS EstadoExamen,
    e.fecha_hora_inicio AS HoraInicio,
    e.fecha_hora_fin AS HoraFin
FROM
    grupo g
        JOIN
    curso c ON g.curso_codigocurso=c.codigocurso
        JOIN
    unidad u ON u.curso_codigocurso=c.codigocurso
        JOIN
    tema t ON t.unidad_codigounidad = u.codigounidad
        JOIN
    examen e ON t.codigocontenido = e.tema_codigocontenido
;

CREATE OR REPLACE VIEW VW_ESTUDIANTES_POR_GRUPO AS (
    SELECT
       g.codigogrupo AS idGrupo,
       g.curso_codigocurso AS idCurso,
       g.docente_usuario_codigousuario AS idDocente,
       a.idAlumno AS idEstudiante,
       u.nombre AS NombreEstudiante,
       a.correo AS EmailEstudiante,
       u.cedula AS CedulaEstudiante
    FROM
       grupo_alumno ga
           JOIN grupo g ON ga.grupo_codigogrupo = g.codigogrupo
           JOIN VW_ALUMNOS a ON ga.alumno_usuario_codigousuario = a.idAlumno
           JOIN usuario u ON a.idAlumno = u.cuenta_codigocuenta
       );


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
