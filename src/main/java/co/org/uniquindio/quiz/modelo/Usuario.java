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
@Table(name = "USUARIO")
public class Usuario {
    @Id
    @Column(name = "CODIGO_CUENTA", nullable = false)
    private Integer id;

    @Column(name = "CEDULA")
    private Integer cedula;

    @Size(max = 50)
    @Column(name = "NOMBRE", length = 50)
    private String nombre;

}