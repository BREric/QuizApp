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
@Table(name = "TEMA")
public class Tema {
    @Id
    @Column(name = "CODIGO_CONTENIDO", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "CODIGO_UNIDAD", nullable = false)
    private Integer codigoUnidad;

    @NotNull
    @Column(name = "CODIGO_BANCO_PREGUNTAS", nullable = false)
    private Integer codigoBancoPreguntas;

}