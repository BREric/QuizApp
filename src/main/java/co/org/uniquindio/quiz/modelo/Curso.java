package co.org.uniquindio.quiz.modelo;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter
@Setter
@Entity
@Table(name = "CURSO")
public class Curso {
    @Id
    @Column(name = "CODIGOCURSO", nullable = false)
    private Long id;

    @Size(max = 60)
    @NotNull
    @Column(name = "NOMBRECURSO", nullable = false, length = 60)
    private String nombrecurso;

}