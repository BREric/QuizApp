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
@Table(name = "BANCO_PREGUNTAS")
public class BancoPregunta {
    @Id
    @Column(name = "CODIGOBANCO", nullable = false)
    private Long id;

    //TODO [JPA Buddy] generate columns from DB
}