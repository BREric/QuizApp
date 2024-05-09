package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "PREGUNTA")
public class Pregunta {
    @Id
    @Column(name = "CODIGOPREGUNTA", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "BANCO_PREGUNTAS_CODIGOBANCO", nullable = false)
    private BancoPregunta bancoPreguntasCodigobanco;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.RESTRICT)
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

}