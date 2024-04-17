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
@Table(name = "UNIDAD")
public class Unidad {
    @Id
    @Column(name = "CODIGO_UNIDAD", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "CODIGO_CURSO", nullable = false)
    private Integer codigoCurso;

}