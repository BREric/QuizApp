package co.org.uniquindio.quiz.dto.Docente;

<<<<<<< HEAD
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public record DocenteUpdateDTO (

    @NotNull long idDocente,
=======

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

public record DocenteUpdateDTO (

    @NotNull  long idDocente,
>>>>>>> 84258cb19c6f1f3f98a8a2e51aef6262180a0cc8
    @NotNull  @Email String correo,
    @NotNull  String passwordCuenta,
    @NotNull  String cedulaDocente,
    @NotNull  String nombreDocente
)

{}
