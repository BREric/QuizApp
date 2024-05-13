package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;
import java.time.OffsetDateTime;

@Getter
@Setter
@Entity
@Table(name = "EXAMEN")
public class Examan {
    @Id
    @Column(name = "CODIGOEXAMEN", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "TEMA_CODIGOCONTENIDO", nullable = false)
    private Tema temaCodigocontenido;

    @Column(name = "CANTPREGUNTAS")
    private Long cantpreguntas;

    @Column(name = "PESOEXAMEN")
    private Double pesoexamen;

    @Column(name = "FECHA_HORA_CREACION")
    private LocalDate fechaHoraCreacion;

    @Column(name = "FECHA_HORA_INICIO")
    private LocalDate fechaHoraInicio;

    @Column(name = "FECHA_HORA_FIN")
    private LocalDate fechaHoraFin;

    @Column(name = "TIEMPO_LIMITE")
    private OffsetDateTime tiempoLimite;

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

    @Size(max = 30)
    @Column(name = "NOMBRE", length = 30)
    private String nombre;

    @Size(max = 100)
    @Column(name = "DESCRIPCION", length = 100)
    private String descripcion;

    @Column(name = "CANTPREGUNTASALUMNO")
    private Long cantpreguntasalumno;

}