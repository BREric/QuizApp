package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

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
    @JoinColumn(name = "UNIDAD_CODIGOUNIDAD", nullable = false)
    private Unidad unidadCodigounidad;

    @Size(max = 50)
    @Column(name = "NOMBRE", length = 50)
    private String nombre;

}