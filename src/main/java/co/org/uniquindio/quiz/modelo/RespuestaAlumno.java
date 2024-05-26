package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

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
            @JoinColumn(name = "PA_PE_CODIGOEXAMEN", referencedColumnName = "PE_EXAMEN_CODIGOEXAMEN", nullable = false),
            @JoinColumn(name = "PA_PE_CODIGOPREGUNTA", referencedColumnName = "PE_PREGUNTA_CODIGOPREGUNTA", nullable = false),
            @JoinColumn(name = "PA_CODIGOPP", referencedColumnName = "PARCIAL_PRESENTADO_CODIGOPP", nullable = false)
    })
    private PreguntaAlumno preguntaAlumno;

}