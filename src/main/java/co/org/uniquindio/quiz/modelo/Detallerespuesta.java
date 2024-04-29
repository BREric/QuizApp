package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "DETALLERESPUESTA")
public class Detallerespuesta {
    @Id
    @Column(name = "CODIGOPREGUNTA", nullable = false)
    private Long id;

    @Column(name = "PREGUNTA_CODIGOPREGUNTA")
    private Long preguntaCodigopregunta;

    @Size(max = 500)
    @Column(name = "DESCRIPCION", length = 500)
    private String descripcion;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "DR_CODIGOPREGUNTA")
    private Detallerespuesta drCodigopregunta;

}