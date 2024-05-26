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
public class PreguntaAlumnoId implements Serializable {
    private static final long serialVersionUID = -3026389660852348724L;
    @NotNull
    @Column(name = "PE_EXAMEN_CODIGOEXAMEN", nullable = false)
    private Long peExamenCodigoexamen;

    @NotNull
    @Column(name = "PE_PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Long pePreguntaCodigopregunta;

    @NotNull
    @Column(name = "PARCIAL_PRESENTADO_CODIGOPP", nullable = false)
    private Long parcialPresentadoCodigopp;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        PreguntaAlumnoId entity = (PreguntaAlumnoId) o;
        return Objects.equals(this.peExamenCodigoexamen, entity.peExamenCodigoexamen) &&
                Objects.equals(this.parcialPresentadoCodigopp, entity.parcialPresentadoCodigopp) &&
                Objects.equals(this.pePreguntaCodigopregunta, entity.pePreguntaCodigopregunta);
    }

    @Override
    public int hashCode() {
        return Objects.hash(peExamenCodigoexamen, parcialPresentadoCodigopp, pePreguntaCodigopregunta);
    }

}