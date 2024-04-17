package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "OPCIONES_PREGUNTA")
public class OpcionesPregunta {
    @Id
    @Column(name = "CODIGO_OPCION", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "ES_CORRECTA", nullable = false)
    private Boolean esCorrecta = false;

}