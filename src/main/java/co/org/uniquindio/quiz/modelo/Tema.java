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
@Table(name = "TEMA")
public class Tema {
    @Id
    @Column(name = "CODIGOCONTENIDO", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "UNIDAD_CODIGOUNIDAD", nullable = false)
    private Unidad unidadCodigounidad;

    @Size(max = 50)
    @Column(name = "NOMBRE", length = 50)
    private String nombre;

}