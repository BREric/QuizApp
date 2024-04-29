CREATE TABLE cuenta (
    codigo_cuenta NUMBER(10) NOT NULL,
    correo VARCHAR2(100) NOT NULL,
    clave VARCHAR2(50) NOT NULL
);

ALTER TABLE cuenta ADD CONSTRAINT cuenta_pk PRIMARY KEY (codigo_cuenta);

CREATE TABLE alumno (
    codigo_usuario NUMBER(10) NOT NULL,
    codigo_cuenta_usuario NUMBER(10) NOT NULL
);

ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY (codigo_usuario);

CREATE TABLE banco_preguntas (
    codigo_banco NUMBER(10) NOT NULL
);

ALTER TABLE banco_preguntas ADD CONSTRAINT banco_preguntas_pk PRIMARY KEY (codigo_banco);

CREATE TABLE curso (
    codigo_curso NUMBER(10) NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY (codigo_curso);

CREATE TABLE detalle_respuesta (
    codigo_pregunta NUMBER(10) NOT NULL,
    pregunta_codigo_pregunta NUMBER(10),
    descripcion VARCHAR2(500),
    codigo_respuesta NUMBER(10) NOT NULL,
    codigo_detalle_respuesta NUMBER(10)
);

ALTER TABLE detalle_respuesta ADD CONSTRAINT detalle_respuesta_pk PRIMARY KEY (codigo_pregunta);

CREATE TABLE docente (
    codigo_usuario NUMBER(10) NOT NULL,
    codigo_cuenta_usuario NUMBER(10) NOT NULL
);

ALTER TABLE docente ADD CONSTRAINT docente_pk PRIMARY KEY (codigo_usuario);

CREATE TABLE examen (
    codigo_examen NUMBER(10) NOT NULL,
    nombre VARCHAR2(30),
    descripcion VARCHAR2(100),
    tiempo_inicio DATE,
    tiempo_fin DATE,
    tiempo TIMESTAMP WITH LOCAL TIME ZONE,
    cantidad_preguntas NUMBER(10),
    peso_examen FLOAT,
    codigo_tema_contenido NUMBER(10) NOT NULL,
    estado VARCHAR2(1)
);

ALTER TABLE examen ADD CONSTRAINT examen_pk PRIMARY KEY (codigo_examen);

CREATE TABLE grupo (
    codigo_grupo NUMBER(10) NOT NULL,
    codigo_curso NUMBER(10) NOT NULL,
    codigo_usuario_docente NUMBER(10) NOT NULL
);

ALTER TABLE grupo ADD CONSTRAINT grupo_pk PRIMARY KEY (codigo_grupo);

CREATE TABLE grupo_alumno (
    codigo_usuario_alumno NUMBER(10) NOT NULL,
    codigo_grupo NUMBER(10) NOT NULL
);

CREATE TABLE opciones_pregunta (
    codigo_opcion NUMBER(10) NOT NULL,
    es_correcta CHAR(1) NOT NULL,
    codigo_pregunta NUMBER(10) NOT NULL
);

ALTER TABLE opciones_pregunta ADD CONSTRAINT opcion_pk PRIMARY KEY (codigo_opcion);

CREATE TABLE pregunta (
    codigo_pregunta NUMBER(10) NOT NULL,
    descripcion VARCHAR2(500),
    codigo_banco_preguntas NUMBER(10) NOT NULL,
    codigo_examen NUMBER(10) NOT NULL,
    estado VARCHAR2(20),
    codigo_pregunta_padre NUMBER(10),
    peso_pregunta FLOAT,
    codigo_tipo_pregunta NUMBER(10) NOT NULL
);

ALTER TABLE pregunta ADD CONSTRAINT pregunta_pk PRIMARY KEY (codigo_pregunta);

CREATE TABLE pregunta_respondida (
    codigo_opcion NUMBER(10) NOT NULL,
    es_correcta CHAR(1) NOT NULL,
    respuesta_abierta VARCHAR2(200),
    codigo_detalle_respuesta NUMBER(10) NOT NULL,
    codigo_tipo_pregunta NUMBER(10) NOT NULL
);

ALTER TABLE pregunta_respondida ADD CONSTRAINT pregunta_respondida_pk PRIMARY KEY (codigo_opcion);

CREATE TABLE respuesta (
    codigo_respuesta NUMBER(10) NOT NULL,
    codigo_examen NUMBER(10) NOT NULL,
    codigo_usuario_alumno NUMBER(10) NOT NULL,
    puntaje FLOAT
);

ALTER TABLE respuesta ADD CONSTRAINT respuesta_pk PRIMARY KEY (codigo_respuesta);

CREATE TABLE tema (
    codigo_contenido NUMBER(10) NOT NULL,
    codigo_unidad NUMBER(10) NOT NULL,
    codigo_banco_preguntas NUMBER(10) NOT NULL
);

ALTER TABLE tema ADD CONSTRAINT tema_pk PRIMARY KEY (codigo_contenido);

CREATE TABLE tipo_pregunta (
    codigo_tipo_pregunta NUMBER(10) NOT NULL,
    nombre VARCHAR2(500)
);

ALTER TABLE tipo_pregunta ADD CONSTRAINT tipo_pregunta_pk PRIMARY KEY (codigo_tipo_pregunta);

CREATE TABLE unidad (
    codigo_unidad NUMBER(10) NOT NULL,
    codigo_curso NUMBER(10) NOT NULL
);

ALTER TABLE unidad ADD CONSTRAINT unidad_pk PRIMARY KEY (codigo_unidad);

CREATE TABLE usuario (
    codigo_cuenta NUMBER(10) NOT NULL,
    cedula NUMBER(10),
    nombre VARCHAR2(50)
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY (codigo_cuenta);

ALTER TABLE alumno
    ADD CONSTRAINT alumno_usuario_fk FOREIGN KEY (codigo_usuario)
        REFERENCES usuario (codigo_cuenta)
    ON DELETE CASCADE;

ALTER TABLE detalle_respuesta
    ADD CONSTRAINT DR_detallerespuesta_fk FOREIGN KEY (codigo_detalle_respuesta)
        REFERENCES detalle_respuesta (codigo_pregunta)
    ON DELETE CASCADE;

ALTER TABLE detalle_respuesta
    ADD CONSTRAINT detalle_respuesta_respuesta_fk FOREIGN KEY (codigo_respuesta)
        REFERENCES respuesta (codigo_respuesta)
    ON DELETE CASCADE;

ALTER TABLE docente
    ADD CONSTRAINT docente_usuario_fk FOREIGN KEY (codigo_usuario)
        REFERENCES usuario (codigo_cuenta)
    ON DELETE CASCADE;

ALTER TABLE examen
    ADD CONSTRAINT examen_tema_fk FOREIGN KEY (codigo_tema_contenido)
        REFERENCES tema (codigo_contenido)
    ON DELETE CASCADE;

ALTER TABLE grupo_alumno
    ADD CONSTRAINT grupo_alumno_alumno_fk FOREIGN KEY (codigo_usuario_alumno)
        REFERENCES alumno (codigo_usuario)
    ON DELETE CASCADE;

ALTER TABLE grupo_alumno
    ADD CONSTRAINT grupo_alumno_grupo_fk FOREIGN KEY (codigo_grupo)
        REFERENCES grupo (codigo_grupo)
    ON DELETE CASCADE;

ALTER TABLE grupo
    ADD CONSTRAINT grupo_curso_fk FOREIGN KEY (codigo_curso)
        REFERENCES curso (codigo_curso)
    ON DELETE CASCADE;

ALTER TABLE grupo
    ADD CONSTRAINT grupo_docente_fk FOREIGN KEY (codigo_usuario_docente)
        REFERENCES docente (codigo_usuario)
    ON DELETE CASCADE;

ALTER TABLE opciones_pregunta
    ADD CONSTRAINT opcion_pregunta_fk FOREIGN KEY (codigo_pregunta)
        REFERENCES pregunta (codigo_pregunta)
    ON DELETE CASCADE;

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_banco_preguntas_fk FOREIGN KEY (codigo_banco_preguntas)
        REFERENCES banco_preguntas (codigo_banco)
    ON DELETE CASCADE;

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_examen_fk FOREIGN KEY (codigo_examen)
        REFERENCES examen (codigo_examen)
    NOT DEFERRABLE;

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_pregunta_fk FOREIGN KEY (codigo_pregunta_padre)
        REFERENCES pregunta (codigo_pregunta)
    ON DELETE CASCADE;

ALTER TABLE pregunta_respondida
    ADD CONSTRAINT PR_detallerespuesta_fk FOREIGN KEY (codigo_detalle_respuesta)
        REFERENCES detalle_respuesta (codigo_pregunta)
    ON DELETE CASCADE;

ALTER TABLE pregunta_respondida
    ADD CONSTRAINT PR_TP_fk FOREIGN KEY (codigo_tipo_pregunta)
        REFERENCES tipo_pregunta (codigo_tipo_pregunta)
    NOT DEFERRABLE;

ALTER TABLE pregunta
    ADD CONSTRAINT pregunta_TP_fk FOREIGN KEY (codigo_tipo_pregunta)
        REFERENCES tipo_pregunta (codigo_tipo_pregunta)
    NOT DEFERRABLE;