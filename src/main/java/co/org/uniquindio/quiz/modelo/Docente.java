package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@Entity
@Table(name = "DOCENTE")
public class Docente {
    @Id
    @Column(name = "USUARIO_CODIGOUSUARIO", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "USUARIO_CUENTA_CODIGO", nullable = false)
    private Usuario usuarioCuentaCodigo;

}