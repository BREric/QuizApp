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
public class Examen {
    @Id
    @Column(name = "CODIGO_EXAMEN", nullable = false)
    private Integer id;

    @Size(max = 30)
    @Column(name = "NOMBRE", length = 30)
    private String nombre;

    @Size(max = 100)
    @Column(name = "DESCRIPCION", length = 100)
    private String descripcion;

    @Column(name = "TIEMPO_INICIO")
    private LocalDate tiempoInicio;

    @Column(name = "TIEMPO_FIN")
    private LocalDate tiempoFin;

    @Column(name = "TIEMPO")
    private OffsetDateTime tiempo;

    @Column(name = "CANTIDAD_PREGUNTAS")
    private Integer cantidadPreguntas;

    @Column(name = "PESO_EXAMEN")
    private Double pesoExamen;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CODIGO_TEMA_CONTENIDO", nullable = false)
    private Tema codigoTemaContenido;

    @Size(max = 1)
    @Column(name = "ESTADO", length = 1)
    private String estado;

}