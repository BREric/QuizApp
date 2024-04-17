package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "CURSO")
public class Curso {
    @Id
    @Column(name = "CODIGO_CURSO", nullable = false)
    private Integer id;

    //TODO [JPA Buddy] generate columns from DB
}