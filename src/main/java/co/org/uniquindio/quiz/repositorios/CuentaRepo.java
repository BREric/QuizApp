package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Cuenta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

import java.util.Map;

public interface CuentaRepo extends JpaRepository<Cuenta, Integer> {

    @Procedure(procedureName = "iniciar_sesion_alumno")
    Map<String, Object> iniciarSesionAlumno(String p_correo, String p_password);

    @Procedure(procedureName = "iniciar_sesion_docente")
    Map<String, Object> iniciarSesionDocente(String p_correo, String p_password);
}
