package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Examan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExamenRepo extends JpaRepository<Examan, Long> {

}
