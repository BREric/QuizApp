-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2024-05-01 13:16:32 COT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE alumno (
                        usuario_codigousuario INTEGER NOT NULL,
                        usuario_cuenta_codigo INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY ( usuario_codigousuario );

CREATE TABLE banco_preguntas (
                                 codigobanco                   INTEGER NOT NULL,
                                 docente_usuario_codigousuario INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE banco_preguntas ADD CONSTRAINT banco_preguntas_pk PRIMARY KEY ( codigobanco );

CREATE TABLE cuenta (
                        codigocuenta INTEGER NOT NULL,
                        email        VARCHAR2(100) NOT NULL,
                        password     VARCHAR2(50) NOT NULL,
                        estado       VARCHAR2(50) NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE cuenta ADD CONSTRAINT cuenta_pk PRIMARY KEY ( codigocuenta );

CREATE TABLE curso (
                       codigocurso INTEGER NOT NULL,
                       nombrecurso VARCHAR2(10)
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( codigocurso );

CREATE TABLE detallerespuesta (
                                  codigopregunta            INTEGER NOT NULL,
                                  respuesta_codigorespuesta INTEGER NOT NULL,
                                  dr_codigopregunta         INTEGER,
                                  pregunta_codigopregunta   INTEGER,
                                  descripcion               VARCHAR2(500)

)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE detallerespuesta ADD CONSTRAINT preguntav1_pk PRIMARY KEY ( codigopregunta );

CREATE TABLE docente (
                         usuario_codigousuario INTEGER NOT NULL,
                         usuario_cuenta_codigo INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

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
                        descripcion                  VARCHAR2(100)

)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE examen ADD CONSTRAINT examen_pk PRIMARY KEY ( codigoexamen );

CREATE TABLE grupo (
                       codigogrupo                   INTEGER NOT NULL,
                       curso_codigocurso             INTEGER NOT NULL,
                       docente_usuario_codigousuario INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE grupo ADD CONSTRAINT grupo_pk PRIMARY KEY ( codigogrupo );

CREATE TABLE grupo_alumno (
                              alumno_usuario_codigousuario INTEGER NOT NULL,
                              grupo_codigogrupo            INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE grupo_alumno ADD CONSTRAINT grupo_alumno_pk PRIMARY KEY ( alumno_usuario_codigousuario,
                                                                      grupo_codigogrupo );

CREATE TABLE opciones_pregunta (
                                   codigoopcion            INTEGER NOT NULL,
                                   pregunta_codigopregunta INTEGER NOT NULL,
                                   iscorrect               CHAR(1) NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE opciones_pregunta ADD CONSTRAINT opcion_pk PRIMARY KEY ( codigoopcion );

CREATE TABLE pregunta (
                          codigopregunta              INTEGER NOT NULL,
                          banco_preguntas_codigobanco INTEGER NOT NULL,
                          pregunta_codigopregunta     INTEGER,
                          estado                      VARCHAR2(20),
                          visibilidad                 VARCHAR2(20),
                          tipo_pregunta               VARCHAR2(30),
                          descripcion                 VARCHAR2(500)
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE pregunta ADD CONSTRAINT pregunta_pk PRIMARY KEY ( codigopregunta );

CREATE TABLE pregunta_examen (
                                 pregunta_codigopregunta INTEGER NOT NULL,
                                 examen_codigoexamen     INTEGER NOT NULL,
                                 porcentaje_pregunta     FLOAT,
                                 tiempo_maximo_pregunta  TIMESTAMP
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE pregunta_examen ADD CONSTRAINT pregunta_examen_pk PRIMARY KEY ( examen_codigoexamen,
                                                                            pregunta_codigopregunta );

CREATE TABLE preguntarespondida (
                                    codigoopcion      INTEGER NOT NULL,
                                    dr_codigopregunta INTEGER NOT NULL,
                                    iscorrect         CHAR(1) NOT NULL,
                                    respuestaabierta  VARCHAR2(200),
                                    tipo_pregunta     VARCHAR2(20)
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE preguntarespondida ADD CONSTRAINT opciones_preguntav1_pk PRIMARY KEY ( codigoopcion );

CREATE TABLE respuesta (
                           codigorespuesta              INTEGER NOT NULL,
                           examen_codigoexamen          INTEGER NOT NULL,
                           alumno_usuario_codigousuario INTEGER NOT NULL,
                           puntaje_obtenido             FLOAT
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE respuesta ADD CONSTRAINT respuesta_pk PRIMARY KEY ( codigorespuesta );

CREATE TABLE tema (
                      codigocontenido             INTEGER NOT NULL,
                      unidad_codigounidad         INTEGER NOT NULL,
                      banco_preguntas_codigobanco INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE tema ADD CONSTRAINT tema_pk PRIMARY KEY ( codigocontenido );

CREATE TABLE unidad (
                        codigounidad      INTEGER NOT NULL,
                        curso_codigocurso INTEGER NOT NULL
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE unidad ADD CONSTRAINT unidad_pk PRIMARY KEY ( codigounidad );

CREATE TABLE usuario (
                         cuenta_codigocuenta INTEGER NOT NULL,
                         cedula              INTEGER,
                         nombre              VARCHAR2(50)
)
    PCTFREE 15 PCTUSED 70 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( cuenta_codigocuenta );

ALTER TABLE alumno
    ADD CONSTRAINT alumno_usuario_fk FOREIGN KEY ( usuario_cuenta_codigo )
        REFERENCES usuario ( cuenta_codigocuenta )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE banco_preguntas
    ADD CONSTRAINT banco_preguntas_docente_fk FOREIGN KEY ( docente_usuario_codigousuario )
        REFERENCES docente ( usuario_codigousuario )
            NOT DEFERRABLE;

ALTER TABLE detallerespuesta
    ADD CONSTRAINT detallerespuesta_respuesta_fk FOREIGN KEY ( respuesta_codigorespuesta )
        REFERENCES respuesta ( codigorespuesta )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE docente
    ADD CONSTRAINT docente_usuario_fk FOREIGN KEY ( usuario_cuenta_codigo )
        REFERENCES usuario ( cuenta_codigocuenta )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE detallerespuesta
    ADD CONSTRAINT dr_detallerespuesta_fk FOREIGN KEY ( dr_codigopregunta )
        REFERENCES detallerespuesta ( codigopregunta )
            NOT DEFERRABLE;

ALTER TABLE examen
    ADD CONSTRAINT examen_tema_fk FOREIGN KEY ( tema_codigocontenido )
        REFERENCES tema ( codigocontenido )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE grupo_alumno
    ADD CONSTRAINT grupo_alumno_alumno_fk FOREIGN KEY ( alumno_usuario_codigousuario )
        REFERENCES alumno ( usuario_codigousuario )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE grupo_alumno
    ADD CONSTRAINT grupo_alumno_grupo_fk FOREIGN KEY ( grupo_codigogrupo )
        REFERENCES grupo ( codigogrupo )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE grupo
    ADD CONSTRAINT grupo_curso_fk FOREIGN KEY ( curso_codigocurso )
        REFERENCES curso ( codigocurso )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE grupo
    ADD CONSTRAINT grupo_docente_fk FOREIGN KEY ( docente_usuario_codigousuario )
        REFERENCES docente ( usuario_codigousuario )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE opciones_pregunta
    ADD CONSTRAINT opcion_pregunta_fk FOREIGN KEY ( pregunta_codigopregunta )
        REFERENCES pregunta ( codigopregunta )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE preguntarespondida
    ADD CONSTRAINT pr_detallerespuesta_fk FOREIGN KEY ( dr_codigopregunta )
        REFERENCES detallerespuesta ( codigopregunta )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_banco_preguntas_fk FOREIGN KEY ( banco_preguntas_codigobanco )
        REFERENCES banco_preguntas ( codigobanco )
            ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE pregunta_examen
    ADD CONSTRAINT pregunta_examen_examen_fk FOREIGN KEY ( examen_codigoexamen )
        REFERENCES examen ( codigoexamen )
            NOT DEFERRABLE;

ALTER TABLE pregunta_examen
    ADD CONSTRAINT pregunta_examen_pregunta_fk FOREIGN KEY ( pregunta_codigopregunta )
        REFERENCES pregunta ( codigopregunta )
            NOT DEFERRABLE;

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_pregunta_fk FOREIGN KEY ( pregunta_codigopregunta )
        REFERENCES pregunta ( codigopregunta )
            NOT DEFERRABLE;

ALTER TABLE respuesta
    ADD CONSTRAINT respuesta_alumno_fk FOREIGN KEY ( alumno_usuario_codigousuario )
        REFERENCES alumno ( usuario_codigousuario )
            NOT DEFERRABLE;

ALTER TABLE respuesta
    ADD CONSTRAINT respuesta_examen_fk FOREIGN KEY ( examen_codigoexamen )
        REFERENCES examen ( codigoexamen )
            NOT DEFERRABLE;

ALTER TABLE tema
    ADD CONSTRAINT tema_banco_preguntas_fk FOREIGN KEY ( banco_preguntas_codigobanco )
        REFERENCES banco_preguntas ( codigobanco )
            NOT DEFERRABLE;

ALTER TABLE tema
    ADD CONSTRAINT tema_unidad_fk FOREIGN KEY ( unidad_codigounidad )
        REFERENCES unidad ( codigounidad )
            NOT DEFERRABLE;

ALTER TABLE unidad
    ADD CONSTRAINT unidad_curso_fk FOREIGN KEY ( curso_codigocurso )
        REFERENCES curso ( codigocurso )
            NOT DEFERRABLE;

ALTER TABLE usuario
    ADD CONSTRAINT usuario_cuenta_fk FOREIGN KEY ( cuenta_codigocuenta )
        REFERENCES cuenta ( codigocuenta )
            NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler Summary Report:
--
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             39
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
