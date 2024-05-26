package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Docente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DocenteRepo extends JpaRepository<Docente, Long> {

    @Procedure(procedureName = "actualizarDocente")
    void actualizarDocente(@Param("p_idDocente") Long id,
                           @Param("p_correo") String correo,
                           @Param("p_passwordcuenta") String contrasena,
                           @Param("p_nombredocente") String nombreDocente);
}