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
@Table(name = "OPCIONES_PREGUNTA")
public class OpcionesPregunta {
    @Id
    @Column(name = "CODIGOOPCION", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Pregunta preguntaCodigopregunta;

    @Size(max = 30)
    @NotNull
    @Column(name = "RESPUESTA", nullable = false, length = 30)
    private String respuesta;

    @Size(max = 500)
    @NotNull
    @Column(name = "OPCION", nullable = false, length = 500)
    private String opcion;

}