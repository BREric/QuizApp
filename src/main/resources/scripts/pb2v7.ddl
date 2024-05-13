-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-05-12 11:50:59 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE alumno (
                        usuario_codigousuario INTEGER NOT NULL,
                        usuario_cuenta_codigo INTEGER NOT NULL
);

ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY ( usuario_codigousuario );

CREATE TABLE cuenta (
                        codigocuenta INTEGER NOT NULL,
                        email        VARCHAR2(100) NOT NULL,
                        password     VARCHAR2(50) NOT NULL,
                        estado       VARCHAR2(50) NOT NULL
);

ALTER TABLE cuenta ADD CONSTRAINT cuenta_pk PRIMARY KEY ( codigocuenta );

CREATE TABLE curso (
                       codigocurso INTEGER NOT NULL,
                       nombrecurso VARCHAR2(60) NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( codigocurso );

CREATE TABLE docente (
                         usuario_codigousuario INTEGER NOT NULL,
                         usuario_cuenta_codigo INTEGER NOT NULL
);

ALTER TABLE docente ADD CONSTRAINT docente_pk PRIMARY KEY ( usuario_codigousuario );

CREATE TABLE examen (
                        codigoexamen                 INTEGER NOT NULL,
                        tema_codigocontenido         INTEGER NOT NULL,
                        cantpreguntas                INTEGER,
                        pesoexamen                   FLOAT,
                        fecha_hora_creacion          DATE,
                        fecha_hora_inicio            DATE,
                        fecha_hora_fin               DATE,
                        tiempo_limite                TIMESTAMP WITH LOCAL TIME ZONE,
                        estado                       VARCHAR2(10),
                        tipo_seleccion_preguntas     VARCHAR2(10),
                        mostrar_respuestas_correctas VARCHAR2(10),
                        mostrar_retroalimentacion    VARCHAR2(10),
                        nombre                       VARCHAR2(30),
                        descripcion                  VARCHAR2(100),
                        cantpreguntasalumno          INTEGER
);

ALTER TABLE examen ADD CONSTRAINT examen_pk PRIMARY KEY ( codigoexamen );

CREATE TABLE grupo (
                       codigogrupo                   INTEGER NOT NULL,
                       nombre                        VARCHAR2(30) NOT NULL,
                       curso_codigocurso             INTEGER NOT NULL,
                       docente_usuario_codigousuario INTEGER NOT NULL
);

ALTER TABLE grupo ADD CONSTRAINT grupo_pk PRIMARY KEY ( codigogrupo );

CREATE TABLE grupo_alumno (
                              alumno_usuario_codigousuario INTEGER NOT NULL,
                              grupo_codigogrupo            INTEGER NOT NULL
);

ALTER TABLE grupo_alumno ADD CONSTRAINT grupo_alumno_pk PRIMARY KEY ( alumno_usuario_codigousuario,
                                                                      grupo_codigogrupo );

CREATE TABLE opciones_pregunta (
                                   codigoopcion            INTEGER NOT NULL,
                                   pregunta_codigopregunta INTEGER NOT NULL,
                                   respuesta               VARCHAR2(300) NOT NULL,
                                   opcion                  VARCHAR2(500) NOT NULL
);

ALTER TABLE opciones_pregunta ADD CONSTRAINT opcion_pk PRIMARY KEY ( codigoopcion );

CREATE TABLE parcial_presentado (
                                    codigopp                     INTEGER NOT NULL,
                                    examen_codigoexamen          INTEGER NOT NULL,
                                    alumno_usuario_codigousuario INTEGER NOT NULL,
                                    puntaje_obtenido             FLOAT,
                                    fecha_hora_inicio            DATE,
                                    fecha_hora_fin               DATE,
                                    tiempo_duracion              DATE
);

ALTER TABLE parcial_presentado ADD CONSTRAINT respuesta_pk PRIMARY KEY ( codigopp );

CREATE TABLE pregunta (
                          codigopregunta                INTEGER NOT NULL,
                          pregunta_codigopregunta       INTEGER,
                          estado                        VARCHAR2(20),
                          visibilidad                   VARCHAR2(20),
                          tipo_pregunta                 VARCHAR2(30),
                          descripcion                   VARCHAR2(500),
                          docente_usuario_codigousuario INTEGER NOT NULL,
                          tema_codigocontenido          INTEGER NOT NULL
);

ALTER TABLE pregunta ADD CONSTRAINT pregunta_pk PRIMARY KEY ( codigopregunta );

CREATE TABLE pregunta_alumno (
                                 pe_examen_codigoexamen      INTEGER NOT NULL,
                                 pe_pregunta_codigopregunta  INTEGER NOT NULL,
                                 tipo_pregunta               VARCHAR2(30),
                                 parcial_presentado_codigopp INTEGER NOT NULL
);

ALTER TABLE pregunta_alumno ADD CONSTRAINT pregunta_parcial_pk PRIMARY KEY ( pe_examen_codigoexamen,
                                                                             pe_pregunta_codigopregunta );

CREATE TABLE pregunta_examen (
                                 pregunta_codigopregunta    INTEGER NOT NULL,
                                 examen_codigoexamen        INTEGER NOT NULL,
                                 porcentaje_pregunta        FLOAT,
                                 tiempo_maximo_pregunta     DATE,
                                 hora_presentacion_pregunta DATE
);

ALTER TABLE pregunta_examen ADD CONSTRAINT pregunta_examen_pk PRIMARY KEY ( examen_codigoexamen,
                                                                            pregunta_codigopregunta );

CREATE TABLE respuesta_alumno (
                                  id_respuesta                  INTEGER NOT NULL,
                                  respuesta                     VARCHAR2(500) NOT NULL,
                                  pa_pe_examen_codigoexamen     INTEGER NOT NULL,
                                  pa_pe_pregunta_codigopregunta INTEGER NOT NULL
);

ALTER TABLE respuesta_alumno ADD CONSTRAINT respuesta_alumno_pk PRIMARY KEY ( id_respuesta );

CREATE TABLE tema (
                      codigocontenido     INTEGER NOT NULL,
                      unidad_codigounidad INTEGER NOT NULL,
                      nombre              VARCHAR2(50)
);

ALTER TABLE tema ADD CONSTRAINT tema_pk PRIMARY KEY ( codigocontenido );

CREATE TABLE unidad (
                        codigounidad      INTEGER NOT NULL,
                        curso_codigocurso INTEGER NOT NULL
);

ALTER TABLE unidad ADD CONSTRAINT unidad_pk PRIMARY KEY ( codigounidad );

CREATE TABLE usuario (
                         cuenta_codigocuenta INTEGER NOT NULL,
                         cedula              INTEGER,
                         nombre              VARCHAR2(50)
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( cuenta_codigocuenta );

ALTER TABLE alumno
    ADD CONSTRAINT alumno_usuario_fk FOREIGN KEY ( usuario_cuenta_codigo )
        REFERENCES usuario ( cuenta_codigocuenta )
            ON DELETE CASCADE;

ALTER TABLE docente
    ADD CONSTRAINT docente_usuario_fk FOREIGN KEY ( usuario_cuenta_codigo )
        REFERENCES usuario ( cuenta_codigocuenta )
            ON DELETE CASCADE;

ALTER TABLE examen
    ADD CONSTRAINT examen_tema_fk FOREIGN KEY ( tema_codigocontenido )
        REFERENCES tema ( codigocontenido )
            ON DELETE CASCADE;

ALTER TABLE grupo_alumno
    ADD CONSTRAINT grupo_alumno_alumno_fk FOREIGN KEY ( alumno_usuario_codigousuario )
        REFERENCES alumno ( usuario_codigousuario )
            ON DELETE CASCADE;

ALTER TABLE grupo_alumno
    ADD CONSTRAINT grupo_alumno_grupo_fk FOREIGN KEY ( grupo_codigogrupo )
        REFERENCES grupo ( codigogrupo )
            ON DELETE CASCADE;

ALTER TABLE grupo
    ADD CONSTRAINT grupo_curso_fk FOREIGN KEY ( curso_codigocurso )
        REFERENCES curso ( codigocurso )
            ON DELETE CASCADE;

ALTER TABLE grupo
    ADD CONSTRAINT grupo_docente_fk FOREIGN KEY ( docente_usuario_codigousuario )
        REFERENCES docente ( usuario_codigousuario )
            ON DELETE CASCADE;

ALTER TABLE opciones_pregunta
    ADD CONSTRAINT opcion_pregunta_fk FOREIGN KEY ( pregunta_codigopregunta )
        REFERENCES pregunta ( codigopregunta )
            ON DELETE CASCADE;

ALTER TABLE pregunta_alumno
    ADD CONSTRAINT p_p_p_examen_fk FOREIGN KEY ( pe_examen_codigoexamen,
                                                 pe_pregunta_codigopregunta )
        REFERENCES pregunta_examen ( examen_codigoexamen,
                                     pregunta_codigopregunta );

ALTER TABLE pregunta_alumno
    ADD CONSTRAINT pa_parcial_presentado_fk FOREIGN KEY ( parcial_presentado_codigopp )
        REFERENCES parcial_presentado ( codigopp );

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_docente_fk FOREIGN KEY ( docente_usuario_codigousuario )
        REFERENCES docente ( usuario_codigousuario );

ALTER TABLE pregunta_examen
    ADD CONSTRAINT pregunta_examen_examen_fk FOREIGN KEY ( examen_codigoexamen )
        REFERENCES examen ( codigoexamen );

ALTER TABLE pregunta_examen
    ADD CONSTRAINT pregunta_examen_pregunta_fk FOREIGN KEY ( pregunta_codigopregunta )
        REFERENCES pregunta ( codigopregunta );

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_pregunta_fk FOREIGN KEY ( pregunta_codigopregunta )
        REFERENCES pregunta ( codigopregunta );

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_tema_fk FOREIGN KEY ( tema_codigocontenido )
        REFERENCES tema ( codigocontenido );

ALTER TABLE respuesta_alumno
    ADD CONSTRAINT ra_pa_fk FOREIGN KEY ( pa_pe_examen_codigoexamen,
                                          pa_pe_pregunta_codigopregunta )
        REFERENCES pregunta_alumno ( pe_examen_codigoexamen,
                                     pe_pregunta_codigopregunta );

ALTER TABLE parcial_presentado
    ADD CONSTRAINT respuesta_alumno_fk FOREIGN KEY ( alumno_usuario_codigousuario )
        REFERENCES alumno ( usuario_codigousuario );

ALTER TABLE parcial_presentado
    ADD CONSTRAINT respuesta_examen_fk FOREIGN KEY ( examen_codigoexamen )
        REFERENCES examen ( codigoexamen );

ALTER TABLE tema
    ADD CONSTRAINT tema_unidad_fk FOREIGN KEY ( unidad_codigounidad )
        REFERENCES unidad ( codigounidad );

ALTER TABLE unidad
    ADD CONSTRAINT unidad_curso_fk FOREIGN KEY ( curso_codigocurso )
        REFERENCES curso ( codigocurso );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_cuenta_fk FOREIGN KEY ( cuenta_codigocuenta )
        REFERENCES cuenta ( codigocuenta );



-- Informe de Resumen de Oracle SQL Developer Data Modeler:
--
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             37
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
--
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
--
-- REDACTION POLICY                         0
--
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
--
-- ERRORS                                   0
-- WARNINGS                                 0
