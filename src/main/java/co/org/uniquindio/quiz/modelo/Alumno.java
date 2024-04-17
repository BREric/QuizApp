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
@Table(name = "ALUMNO")
public class Alumno {
    @Id
    @Column(name = "CODIGO_USUARIO", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "CODIGO_CUENTA_USUARIO", nullable = false)
    private Integer codigoCuentaUsuario;

}