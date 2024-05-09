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
@Table(name = "PREGUNTARESPONDIDA")
public class Preguntarespondida {
    @Id
    @Column(name = "CODIGOOPCION", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "DR_CODIGOPREGUNTA", nullable = false)
    private Detallerespuesta drCodigopregunta;

    @NotNull
    @Column(name = "ISCORRECT", nullable = false)
    private Boolean iscorrect = false;

    @Size(max = 200)
    @Column(name = "RESPUESTAABIERTA", length = 200)
    private String respuestaabierta;

    @Size(max = 20)
    @Column(name = "TIPO_PREGUNTA", length = 20)
    private String tipoPregunta;

}