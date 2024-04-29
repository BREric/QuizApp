package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "CUENTA")
public class Cuenta {
    @Id
    @Column(name = "CODIGOCUENTA", nullable = false)
    private Long id;

    @Size(max = 100)
    @NotNull
    @Column(name = "EMAIL", nullable = false, length = 100)
    private String email;

    @Size(max = 50)
    @NotNull
    @Column(name = "PASSWORD", nullable = false, length = 50)
    private String password;

    @Size(max = 50)
    @NotNull
    @Column(name = "ESTADO", nullable = false, length = 50)
    private String estado;

}