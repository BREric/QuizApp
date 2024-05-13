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
@Table(name = "PREGUNTA_ALUMNO")
public class PreguntaAlumno {
    @EmbeddedId
    private PreguntaAlumnoId id;

    @MapsId("id")
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "PE_EXAMEN_CODIGOEXAMEN", referencedColumnName = "EXAMEN_CODIGOEXAMEN", nullable = false),
            @JoinColumn(name = "PE_PREGUNTA_CODIGOPREGUNTA", referencedColumnName = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    })
    @OnDelete(action = OnDeleteAction.RESTRICT)
    private PreguntaExaman preguntaExamen;

    @Size(max = 30)
    @Column(name = "TIPO_PREGUNTA", length = 30)
    private String tipoPregunta;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "PARCIAL_PRESENTADO_CODIGOPP", nullable = false)
    private ParcialPresentado parcialPresentadoCodigopp;

}