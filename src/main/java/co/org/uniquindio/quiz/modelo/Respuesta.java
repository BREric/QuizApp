package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "RESPUESTA")
public class Respuesta {
    @Id
    @Column(name = "CODIGORESPUESTA", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "EXAMEN_CODIGOEXAMEN", nullable = false)
    private Examan examenCodigoexamen;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "ALUMNO_USUARIO_CODIGOUSUARIO", nullable = false)
    private Alumno alumnoUsuarioCodigousuario;

    @Column(name = "PUNTAJE_OBTENIDO")
    private Double puntajeObtenido;

}