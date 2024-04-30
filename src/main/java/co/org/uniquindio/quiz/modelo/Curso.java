package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "CURSO")
public class Curso {
    @Id
    @Column(name = "CODIGOCURSO", nullable = false)
    private Long id;

    @Size(max = 10)
    @Column(name = "NOMBRECURSO", length = 10)
    private String nombrecurso;

}