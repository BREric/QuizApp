package co.org.uniquindio.quiz.modelo;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class GrupoAlumnoId implements Serializable {
    private static final long serialVersionUID = -2481012651593235913L;
    @NotNull
    @Column(name = "ALUMNO_USUARIO_CODIGOUSUARIO", nullable = false)
    private Long alumnoUsuarioCodigousuario;

    @NotNull
    @Column(name = "GRUPO_CODIGOGRUPO", nullable = false)
    private Long grupoCodigogrupo;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        GrupoAlumnoId entity = (GrupoAlumnoId) o;
        return Objects.equals(this.alumnoUsuarioCodigousuario, entity.alumnoUsuarioCodigousuario) &&
                Objects.equals(this.grupoCodigogrupo, entity.grupoCodigogrupo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(alumnoUsuarioCodigousuario, grupoCodigogrupo);
    }

}