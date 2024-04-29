package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "PREGUNTA_EXAMEN")
public class PreguntaExaman {
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Pregunta preguntaCodigopregunta;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "EXAMEN_CODIGOEXAMEN", nullable = false)
    private Examen examenCodigoexamen;

    @Column(name = "PORCENTAJE_PREGUNTA")
    private Double porcentajePregunta;

    @Column(name = "TIEMPO_MAXIMO_PREGUNTA")
    private Instant tiempoMaximoPregunta;

}