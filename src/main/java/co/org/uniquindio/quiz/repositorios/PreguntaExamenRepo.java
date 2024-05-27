package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.PreguntaExaman;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PreguntaExamenRepo extends JpaRepository<PreguntaExaman, Long> {
}
