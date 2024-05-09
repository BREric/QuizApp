package co.org.uniquindio.quiz.repositorios;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CuentaRepo extends JpaRepository<Cuenta, Integer>
{

    Optional<Cuenta> encontrarCliente(Integer integer);

}
