package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "PREGUNTA_RESPONDIDA")
public class PreguntaRespondida {
    @Id
    @Column(name = "CODIGO_OPCION", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "ES_CORRECTA", nullable = false)
    private Boolean esCorrecta = false;

    @Size(max = 200)
    @Column(name = "RESPUESTA_ABIERTA", length = 200)
    private String respuestaAbierta;

}