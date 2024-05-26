package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.Max;

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
    @JoinColumn(name = "CUENTA_CODIGOCUENTA", nullable = false)
    private Cuenta cuenta;

    @Column(name = "CEDULA")
    private Long cedula;

    @Max(value = 50)
    @Column(name = "NOMBRE", length = 50)
    private String nombre;

}