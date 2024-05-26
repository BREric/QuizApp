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
public class PreguntaExamanId implements Serializable {
    private static final long serialVersionUID = 8947072398053330340L;
    @NotNull
    @Column(name = "PREGUNTA_CODIGOPREGUNTA", nullable = false)
    private Long preguntaCodigopregunta;

    @NotNull
    @Column(name = "EXAMEN_CODIGOEXAMEN", nullable = false)
    private Long examenCodigoexamen;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        PreguntaExamanId entity = (PreguntaExamanId) o;
        return Objects.equals(this.preguntaCodigopregunta, entity.preguntaCodigopregunta) &&
                Objects.equals(this.examenCodigoexamen, entity.examenCodigoexamen);
    }

    @Override
    public int hashCode() {
        return Objects.hash(preguntaCodigopregunta, examenCodigoexamen);
    }

}