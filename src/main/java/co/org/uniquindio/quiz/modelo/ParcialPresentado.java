package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "PARCIAL_PRESENTADO")
public class ParcialPresentado {
    @Id
    @Column(name = "CODIGOPP", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "EXAMEN_CODIGOEXAMEN", nullable = false)
    private Examan examenCodigoexamen;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "ALUMNO_USUARIO_CODIGOUSUARIO", nullable = false)
    private Alumno alumnoUsuarioCodigousuario;

    @Column(name = "PUNTAJE_OBTENIDO")
    private Double puntajeObtenido;

    @Column(name = "FECHA_HORA_INICIO")
    private LocalDate fechaHoraInicio;

    @Column(name = "FECHA_HORA_FIN")
    private LocalDate fechaHoraFin;

    @Column(name = "TIEMPO_DURACION")
    private LocalDate tiempoDuracion;

}