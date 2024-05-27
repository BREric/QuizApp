package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepo extends JpaRepository<Usuario, Long> {
}
