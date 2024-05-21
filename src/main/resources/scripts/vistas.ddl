CREATE OR REPLACE VIEW VW_INFORMACION_EXAMEN AS(
SELECT e.codigoexamen idExamen, e.nombre Nombre, e.descripcion Descripcion, t.nombre Tema,
       e.cantpreguntas NumeroPreguntas, e.pesoexamen ValorExamen, e.fecha_hora_creacion HoraCreado,
       e.fecha_hora_inicio HoraInicio, e.fecha_hora_fin HoraFin, e.tiempo_limite Duracion, e.estado Estado
FROM examen e
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido);


CREATE VIEW VW_INFO_PREGUNTAS_RESPUESTA AS(
SELECT p.codigopregunta idPregunta, p.descripcion Descripcion, p.tipo_pregunta TipoPregunta, p.estado Estado,
       op.codigoopcion Opcion, op.respuesta Respuesta
FROM pregunta p
         LEFT JOIN opciones_pregunta op ON p.codigopregunta = op.pregunta_codigopregunta);


CREATE OR REPLACE VIEW VW_INFO_RESPUESTA_ALUMNO AS(
SELECT pe.pe_examen_codigoexamen idExamen, pe.pe_pregunta_codigopregunta idPregunta,
       a.usuario_codigousuario idUsuario, e.nombre nombreExamen,
       p.descripcion pregunta, po.respuesta respuesta,
       pe.tipo_pregunta TipoPregunta,
       pp.puntaje_obtenido Nota,
       CASE
           WHEN pp.puntaje_obtenido >= 80 THEN 'Excelente'
           WHEN pp.puntaje_obtenido >= 60 THEN 'Aceptable'
           ELSE 'Perdió'
           END AS clasificacion_nota
FROM pregunta_alumno pe
         JOIN VW_ALUMNOS a ON pe.alumno_usuario_codigousuario = a.CODIGOCUENTA
         JOIN pregunta p ON pe.pe_pregunta_codigopregunta = p.codigopregunta
         LEFT JOIN opciones_pregunta po ON pe.pe_pregunta_codigopregunta = po.pregunta_codigopregunta
         LEFT JOIN parcial_presentado pp ON pe.pe_examen_codigoexamen = pp.examen_codigoexamen
    AND pe.alumno_usuario_codigousuario = pp.alumno_usuario_codigousuario
         JOIN examen e ON pe.pe_examen_codigoexamen = e.codigoexamen);



CREATE VIEW VW_estudiantes_grupo AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, g.docente_usuario_codigousuario idDocente,
       a.usuario_codigousuario idAlumno, u.nombre nombreAlumno
FROM grupo_alumno ga
         JOIN grupo g ON ga.grupo_codigogrupo = g.codigogrupo
         JOIN VW_ALUMNOS a ON ga.alumno_usuario_codigousuario = a.CODIGOCUENTA
         JOIN usuario u ON a.usuario_codigousuario = u.cuenta_codigocuenta);


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
SELECT t.nombre AS tema,
       AVG(pp.puntaje_obtenido) AS promedio_nota
FROM examen e
         JOIN parcial_presentado pp ON e.codigoexamen = pp.examen_codigoexamen
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido
GROUP BY t.nombre
ORDER BY promedio_nota);

CREATE OR REPLACE VIEW VW_promedio_nota_alumno AS(
SELECT a.usuario_codigousuario AS idEstudiante,
       AVG(pp.puntaje_obtenido) AS promedio_nota,
       u.nombre AS Nombre,
       u.email AS Email,
       u.cedula AS Cedula
FROM parcial_presentado pp
         JOIN VW_ALUMNOS a ON pp.alumno_usuario_codigousuario = a.CODIGOCUENTA
         JOIN usuario u ON a.CODIGOCUENTA = u.cuenta_codigocuenta
GROUP BY a.usuario_codigousuario, u.nombre, u.email, u.cedula);

CREATE OR REPLACE VIEW VW_DOCENTES AS(
    SELECT C.CODIGOCUENTA idDocente,
           C.email correo,
           C.password passwordcuenta,
           U.cedula ceduladocente,
           U.nombre nombredocente
    FROM CUENTA c JOIN USUARIO u
           ON c.codigoCuenta=u.cuenta_codigocuenta
           JOIN DOCENTE D on d.usuario_codigousuario=u.cuenta_codigocuenta);



CREATE OR REPLACE VIEW VW_ALUMNOS AS(
    SELECT C.CODIGOCUENTA idAlumno,
        C.email correo,
        C.password passwordcuenta,
        U.cedula cedulaalumno,
        U.nombre nombrealumno
    FROM CUENTA c JOIN USUARIO u
       ON c.codigoCuenta=u.cuenta_codigocuenta
       JOIN ALUMNO a on a.usuario_codigousuario=u.cuenta_codigocuenta);


CREATE OR REPLACE VIEW VW_PREGUNTAS_PUBLICAS AS(
SELECT p.codigopregunta idPregunta, p.descripcion Descripcion, p.estado Estado
FROM PREGUNTA p
WHERE p.visibilidad = 'PUBLICA');

CREATE VIEW VW_INFORMACION_CURSO AS(
SELECT c.codigocurso idCurso, c.nombre NombreCurso, c.descripcion DescripcionCurso, d.nombre NombreDocente
FROM curso c
         JOIN VW_DOCENTES d ON c.docente_usuario_codigousuario = d.CODIGOCUENTA);

CREATE VIEW VW_INFORMACION_GRUPO AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, g.docente_usuario_codigousuario idDocente,
       c.nombre NombreCurso, d.nombre NombreDocente
FROM grupo g
         JOIN curso c ON g.curso_codigocurso = c.codigocurso
         JOIN VW_DOCENTES d ON g.docente_usuario_codigousuario = d.CODIGOCUENTA);

CREATE VIEW VW_INFORMACION_ESTUDIANTE AS(
SELECT a.usuario_codigousuario idEstudiante, u.nombre NombreEstudiante, u.email EmailEstudiante, u.cedula CedulaEstudiante
FROM VW_ALUMNOS a
         JOIN usuario u ON a.CODIGOCUENTA = u.cuenta_codigocuenta);


CREATE VIEW VW_EXAMENES_PENDIENTES AS(
SELECT e.codigoexamen idExamen, e.nombre NombreExamen, e.fecha_hora_inicio HoraInicio, e.fecha_hora_fin HoraFin,
       t.nombre Tema, e.estado EstadoExamen
FROM examen e
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido
WHERE e.ESTADO = 'PENDIENTE');


CREATE VIEW VW_PROFESORES_POR_CURSO AS(
SELECT c.codigocurso idCurso, c.nombre NombreCurso, c.descripcion DescripcionCurso,
       d.nombre NombreDocente, d.email EmailDocente
FROM curso c
         JOIN VW_DOCENTES d ON c.docente_usuario_codigousuario = d.CODIGOCUENTA);

CREATE VIEW VW_EXAMENES_REALIZADOS AS(
SELECT e.codigoexamen idExamen, e.nombre NombreExamen, e.fecha_hora_inicio HoraInicio, e.fecha_hora_fin HoraFin,
       t.nombre Tema, e.estado EstadoExamen
FROM examen e
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido
WHERE e.ESTADO = 'REALIZADO');


CREATE VIEW VW_GRUPOS_POR_CURSO AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, g.docente_usuario_codigousuario idDocente,
       c.nombre NombreCurso, d.nombre NombreDocente
FROM grupo g
         JOIN curso c ON g.curso_codigocurso = c.codigocurso
         JOIN VW_DOCENTES d ON g.docente_usuario_codigousuario = d.CODIGOCUENTA);


CREATE VIEW VW_RESUMEN_EXAMENES_POR_GRUPO AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, e.codigoexamen idExamen,
       e.nombre NombreExamen, t.nombre Tema, e.estado EstadoExamen
FROM grupo g
         JOIN curso c ON g.curso_codigocurso = c.codigocurso
         JOIN examen e ON g.curso_codigocurso = e.curso_codigocurso
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido);


CREATE VIEW VW_ESTUDIANTES_POR_GRUPO AS(
SELECT g.codigogrupo idGrupo, g.curso_codigocurso idCurso, a.usuario_codigousuario idEstudiante,
       u.nombre NombreEstudiante, u.email EmailEstudiante, u.cedula CedulaEstudiante
FROM grupo_alumno ga
         JOIN grupo g ON ga.grupo_codigogrupo = g.codigogrupo
         JOIN VW_ALUMNOS a ON ga.alumno_usuario_codigousuario = a.CODIGOCUENTA
         JOIN usuario u ON a.CODIGOCUENTA = u.cuenta_codigocuenta);


-----------------------------------VISTAS PARA LAS TABLAS DE LA BASE DE DATOS------------------------------------------------

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




