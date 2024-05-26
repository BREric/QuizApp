package co.org.uniquindio.quiz.modelo;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@Entity
@Table(name = "UNIDAD")
public class Unidad {
    @Id
    @Column(name = "CODIGOUNIDAD", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "CURSO_CODIGOCURSO", nullable = false)
    private Curso cursoCodigocurso;

}