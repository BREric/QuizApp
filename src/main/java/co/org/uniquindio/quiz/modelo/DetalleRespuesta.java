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
@Table(name = "DETALLE_RESPUESTA")
public class DetalleRespuesta {
    @Id
    @Column(name = "CODIGO_PREGUNTA", nullable = false)
    private Integer id;

    @Column(name = "PREGUNTA_CODIGO_PREGUNTA")
    private Integer preguntaCodigoPregunta;

    @Size(max = 500)
    @Column(name = "DESCRIPCION", length = 500)
    private String descripcion;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CODIGO_RESPUESTA", nullable = false)
    private Respuesta codigoRespuesta;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CODIGO_DETALLE_RESPUESTA")
    private DetalleRespuesta codigoDetalleRespuesta;

}