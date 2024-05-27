package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Docente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DocenteRepo extends JpaRepository<Docente, Integer> {

    @Procedure(procedureName = "actualizarDocente")
    void actualizarDocente(@Param("p_idDocente") Long id,
                           @Param("p_correo") String correo,
                           @Param("p_passwordcuenta") String contrasena,
                           @Param("p_nombredocente") String nombreDocente);

    @Procedure(procedureName = "eliminar_docente")
    void eliminar_docente(@Param("p_idDocente") Integer id);

    @Procedure(procedureName = "obtener_docente")
    Docente obtener_docente(@Param("p_idDocente") Integer id);

    @Procedure(name = "listarDocentes")
    List<Docente> listarDocentes();
}