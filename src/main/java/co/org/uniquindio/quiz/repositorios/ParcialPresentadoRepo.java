package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.ParcialPresentado;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ParcialPresentadoRepo extends JpaRepository<ParcialPresentado, Long> {
}
