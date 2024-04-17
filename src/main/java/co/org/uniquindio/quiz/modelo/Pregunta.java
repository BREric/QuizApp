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
@Table(name = "PREGUNTA")
public class Pregunta {
    @Id
    @Column(name = "CODIGO_PREGUNTA", nullable = false)
    private Integer id;

    @Size(max = 500)
    @Column(name = "DESCRIPCION", length = 500)
    private String descripcion;

    @Size(max = 20)
    @Column(name = "ESTADO", length = 20)
    private String estado;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CODIGO_PREGUNTA_PADRE")
    private Pregunta codigoPreguntaPadre;

    @Column(name = "PESO_PREGUNTA")
    private Double pesoPregunta;

    @NotNull
    @Column(name = "CODIGO_TIPO_PREGUNTA", nullable = false)
    private Integer codigoTipoPregunta;

}