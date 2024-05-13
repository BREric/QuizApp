package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "GRUPO")
public class Grupo {
    @Id
    @Column(name = "CODIGOGRUPO", nullable = false)
    private Long id;

    @Size(max = 30)
    @NotNull
    @Column(name = "NOMBRE", nullable = false, length = 30)
    private String nombre;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CURSO_CODIGOCURSO", nullable = false)
    private Curso cursoCodigocurso;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "DOCENTE_USUARIO_CODIGOUSUARIO", nullable = false)
    private Docente docenteUsuarioCodigousuario;

}