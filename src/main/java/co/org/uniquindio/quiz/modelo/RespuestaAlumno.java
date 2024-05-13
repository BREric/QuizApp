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
@Table(name = "RESPUESTA_ALUMNO")
public class RespuestaAlumno {
    @Id
    @Column(name = "ID_RESPUESTA", nullable = false)
    private Long id;

    @Size(max = 500)
    @NotNull
    @Column(name = "RESPUESTA", nullable = false, length = 500)
    private String respuesta;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumns({
            @JoinColumn(name = "PA_PE_EXAMEN_CODIGOEXAMEN", referencedColumnName = "PE_EXAMEN_CODIGOEXAMEN", nullable = false),
            @JoinColumn(name = "PA_PE_PREGUNTA_CODIGOPREGUNTA", referencedColumnName = "PE_PREGUNTA_CODIGOPREGUNTA", nullable = false)
    })
    @OnDelete(action = OnDeleteAction.RESTRICT)
    private PreguntaAlumno preguntaAlumno;

}