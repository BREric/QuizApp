package co.org.uniquindio.quiz.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class PreguntaAlumnoId implements Serializable {
    private static final long serialVersionUID = -915162960474055675L;
    @NotNull
    @Column(name = "PE_EXAMEN_CODIGOEXAMEN", nullable = false)
    private Long peExamenCodigoexamen;

    @NotNull
    @Column(name = "PE_PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Long pePreguntaCodigopregunta;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        PreguntaAlumnoId entity = (PreguntaAlumnoId) o;
        return Objects.equals(this.peExamenCodigoexamen, entity.peExamenCodigoexamen) &&
                Objects.equals(this.pePreguntaCodigopregunta, entity.pePreguntaCodigopregunta);
    }

    @Override
    public int hashCode() {
        return Objects.hash(peExamenCodigoexamen, pePreguntaCodigopregunta);
    }

}