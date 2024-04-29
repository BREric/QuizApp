package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.OffsetDateTime;

@Getter
@Setter
@Entity
@Table(name = "EXAMEN")
public class Examen {
    @Id
    @Column(name = "CODIGOEXAMEN", nullable = false)
    private Long id;

    @Size(max = 30)
    @Column(name = "NOMBRE", length = 30)
    private String nombre;

    @Size(max = 100)
    @Column(name = "DESCRIPCION", length = 100)
    private String descripcion;

    @Column(name = "FECHA_HORA_INICIO")
    private LocalDate fechaHoraInicio;

    @Column(name = "FECHA_HORA_FIN")
    private LocalDate fechaHoraFin;

    @Column(name = "TIEMPO_LIMITE")
    private OffsetDateTime tiempoLimite;

    @Column(name = "CANTPREGUNTAS")
    private Long cantpreguntas;

    @Column(name = "PESOEXAMEN")
    private Double pesoexamen;

    @Size(max = 10)
    @Column(name = "ESTADO", length = 10)
    private String estado;

    @Size(max = 10)
    @Column(name = "TIPO_SELECCION_PREGUNTAS", length = 10)
    private String tipoSeleccionPreguntas;

    @Size(max = 10)
    @Column(name = "MOSTRAR_RESPUESTAS_CORRECTAS", length = 10)
    private String mostrarRespuestasCorrectas;

    @Size(max = 10)
    @Column(name = "MOSTRAR_RETROALIMENTACION", length = 10)
    private String mostrarRetroalimentacion;

    @Column(name = "FECHA_HORA_CREACION")
    private LocalDate fechaHoraCreacion;

}