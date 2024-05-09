package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "BANCO_PREGUNTAS")
public class BancoPregunta {
    @Id
    @Column(name = "CODIGOBANCO", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "DOCENTE_USUARIO_CODIGOUSUARIO", nullable = false)
    private Docente docenteUsuarioCodigousuario;

}