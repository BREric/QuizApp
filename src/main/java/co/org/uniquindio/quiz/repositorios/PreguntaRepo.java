package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Pregunta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PreguntaRepo extends JpaRepository<Pregunta, Long> {
}
