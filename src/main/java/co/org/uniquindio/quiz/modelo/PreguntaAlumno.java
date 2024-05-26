package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Getter
@Setter
@Entity
@Table(name = "PREGUNTA_ALUMNO")
public class PreguntaAlumno {
    @EmbeddedId
    private PreguntaAlumnoId id;

    @MapsId("id")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "PE_EXAMEN_CODIGOEXAMEN", referencedColumnName = "EXAMEN_CODIGOEXAMEN", nullable = false),
            @JoinColumn(name = "PE_PREGUNTA_CODIGOPREGUNTA", referencedColumnName = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    })
    private PreguntaExaman preguntaExamen;

    @MapsId("parcialPresentadoCodigopp")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "PARCIAL_PRESENTADO_CODIGOPP", nullable = false)
    private ParcialPresentado parcialPresentadoCodigopp;

    @Size(max = 30)
    @Column(name = "TIPO_PREGUNTA", length = 30)
    private String tipoPregunta;

}