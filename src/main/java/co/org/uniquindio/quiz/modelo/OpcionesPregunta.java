package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
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
    @Column(name = "ISCORRECT", nullable = false)
    private Boolean iscorrect = false;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Pregunta preguntaCodigopregunta;

}