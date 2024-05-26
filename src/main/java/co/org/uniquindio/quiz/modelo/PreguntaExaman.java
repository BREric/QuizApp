package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "PREGUNTA_EXAMEN")
public class PreguntaExaman {
    @EmbeddedId
    private PreguntaExamanId id;

    @MapsId("preguntaCodigopregunta")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Pregunta preguntaCodigopregunta;

    @MapsId("examenCodigoexamen")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "EXAMEN_CODIGOEXAMEN", nullable = false)
    private Examan examenCodigoexamen;

    @Column(name = "PORCENTAJE_PREGUNTA")
    private Double porcentajePregunta;

    @Column(name = "TIEMPO_MAXIMO_PREGUNTA")
    private LocalDate tiempoMaximoPregunta;

    @Column(name = "HORA_PRESENTACION_PREGUNTA")
    private LocalDate horaPresentacionPregunta;

}