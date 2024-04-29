package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "USUARIO")
public class Usuario {
    @Id
    @Column(name = "CUENTA_CODIGOCUENTA", nullable = false)
    private Long id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "CUENTA_CODIGOCUENTA", nullable = false)
    private Cuenta cuenta;

    @Column(name = "CEDULA")
    private Long cedula;

    @Size(max = 50)
    @Column(name = "NOMBRE", length = 50)
    private String nombre;

}