package co.org.uniquindio.quiz.dto.Docente;


import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

public record DocenteUpdateDTO (

    @NotNull  long idDocente,
    @NotNull  @Email String correo,
    @NotNull  String passwordCuenta,
    @NotNull  String cedulaDocente,
    @NotNull  String nombreDocente
)

{}
