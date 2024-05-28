package co.org.uniquindio.quiz.repositorios;
import co.org.uniquindio.quiz.modelo.Cuenta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CuentaRepo extends JpaRepository<Cuenta, Integer> {

    @Procedure(procedureName = "iniciar_sesion_alumno_proc")
    List<Object[]> iniciar_sesion_alumno_proc(@Param("p_email") String email, @Param("p_password") String password);

    @Procedure(procedureName = "iniciar_sesion_docente_proc")
    List<Object[]> iniciar_sesion_docente_proc(@Param("p_email") String email, @Param("p_password") String password);
}
