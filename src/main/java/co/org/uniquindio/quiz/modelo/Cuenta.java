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
    @Column(name = "CODIGO_CUENTA", nullable = false)
    private Integer id;

    @Size(max = 100)
    @NotNull
    @Column(name = "CORREO", nullable = false, length = 100)
    private String correo;

    @Size(max = 50)
    @NotNull
    @Column(name = "CLAVE", nullable = false, length = 50)
    private String clave;

}