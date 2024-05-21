package co.org.uniquindio.quiz.repositorios;

import co.org.uniquindio.quiz.modelo.Alumno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlumnoRepo extends JpaRepository<Alumno, Long> {


}
