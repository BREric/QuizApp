package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "GRUPO_ALUMNO")
public class GrupoAlumno {
    @EmbeddedId
    private GrupoAlumnoId id;

    @MapsId("alumnoUsuarioCodigousuario")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ALUMNO_USUARIO_CODIGOUSUARIO", nullable = false)
    private Alumno alumnoUsuarioCodigousuario;

    @MapsId("grupoCodigogrupo")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "GRUPO_CODIGOGRUPO", nullable = false)
    private Grupo grupoCodigogrupo;

}