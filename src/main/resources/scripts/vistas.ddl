CREATE OR REPLACE VIEW VW_INFORMACION_EXAMEN AS
SELECT e.codigoexamen idExamen, e.nombre Nombre, e.descripcion Descripcion, t.nombre Tema,
       e.cantpreguntas NumeroPreguntas, e.pesoexamen ValorExamen, e.fecha_hora_creacion HoraCreado,
       e.fecha_hora_inicio HoraInicio, e.fecha_hora_fin HoraFin, e.tiempo_limite Duracion, e.estado Estado
FROM examen e
         JOIN tema t ON e.tema_codigocontenido = t.codigocontenido;


CREATE VIEW VW_INFO_PREGUNTAS_RESPUESTA AS
SELECT p.codigopregunta idPregunta, p.descripcion Descripcion, p.tipo_pregunta TipoPregunta, p.estado Estado,
       op.codigoopcion Opcion, op.respuesta Respuesta
FROM pregunta p
         LEFT JOIN opciones_pregunta op ON p.codigopregunta = op.pregunta_codigopregunta;


CREATE VIEW VW_INFO_RESPUESTA_ALUMNO AS
SELECT pe.pe_examen_codigoexamen idExamen, pe.pe_pregunta_codigopregunta idPregunta,
       a.usuario_codigousuario idUsuario, e.nombre nombreExamen,
       p.descripcion pregunta, po.respuesta respuesta,
       pe.tipo_pregunta TipoPregunta,
       pp.puntaje_obtenido Nota
FROM pregunta_alumno pe
         JOIN alumno a ON pe.alumno_usuario_codigousuario = a.usuario_codigousuario
         JOIN pregunta p ON pe.pe_pregunta_codigopregunta = p.codigopregunta
         LEFT JOIN opciones_pregunta po ON pe.pe_pregunta_codigopregunta = po.pregunta_codigopregunta
         LEFT JOIN parcial_presentado pp ON pe.pe_examen_codigoexamen = pp.examen_codigoexamen
    AND pe.alumno_usuario_codigousuario = pp.alumno_usuario_codigousuario
         JOIN examen e ON pe.pe_examen_codigoexamen = e.codigoexamen;




