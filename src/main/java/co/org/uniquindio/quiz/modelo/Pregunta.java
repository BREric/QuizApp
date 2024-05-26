package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter
@Setter
@Entity
@Table(name = "PREGUNTA")
public class Pregunta {
    @Id
    @Column(name = "CODIGOPREGUNTA", nullable = false)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PREGUNTA_CODIGOPREGUNTA")
    private Pregunta preguntaCodigopregunta;

    @Size(max = 20)
    @Column(name = "ESTADO", length = 20)
    private String estado;

    @Size(max = 20)
    @Column(name = "VISIBILIDAD", length = 20)
    private String visibilidad;

    @Size(max = 30)
    @Column(name = "TIPO_PREGUNTA", length = 30)
    private String tipoPregunta;

    @Size(max = 500)
    @Column(name = "DESCRIPCION", length = 500)
    private String descripcion;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "DOCENTE_USUARIO_CODIGOUSUARIO", nullable = false)
    private Docente docenteUsuarioCodigousuario;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "TEMA_CODIGOCONTENIDO", nullable = false)
    private Tema temaCodigocontenido;

}