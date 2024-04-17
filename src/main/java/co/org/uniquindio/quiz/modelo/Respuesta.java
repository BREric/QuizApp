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
@Table(name = "RESPUESTA")
public class Respuesta {
    @Id
    @Column(name = "CODIGO_RESPUESTA", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "CODIGO_EXAMEN", nullable = false)
    private Integer codigoExamen;

    @NotNull
    @Column(name = "CODIGO_USUARIO_ALUMNO", nullable = false)
    private Integer codigoUsuarioAlumno;

    @Column(name = "PUNTAJE")
    private Double puntaje;

}