package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Docente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DocenteRepo extends JpaRepository<Docente, Long> {

}