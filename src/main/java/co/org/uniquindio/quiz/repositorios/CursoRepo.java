package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Curso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CursoRepo extends JpaRepository<Curso, Integer> {
    Curso findByNombrecurso(String nombre);
}
