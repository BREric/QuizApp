package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "EXAMEN_CONFIGURACION")
public class ExamenConfiguracion {
    @Id
    @Column(name = "CODIGO_EXAMEN", nullable = false)
    private Long id;

    @Column(name = "CANTIDAD_PREGUNTAS")
    private Long cantidadPreguntas;

    @Column(name = "FECHA_HORA_INICIO")
    private Instant fechaHoraInicio;

}