package co.org.uniquindio.quiz.repositorios;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlumnoRepo extends JpaRepository<Alumno, Integer> {
}
