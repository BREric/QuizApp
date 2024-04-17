package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "TIPO_PREGUNTA")
public class TipoPregunta {
    @Id
    @Column(name = "CODIGO_TIPO_PREGUNTA", nullable = false)
    private Integer id;

    @Size(max = 500)
    @Column(name = "NOMBRE", length = 500)
    private String nombre;

}