package co.org.uniquindio.quiz.dto.Docente;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

public record DocenteUpdateDTO (

        @NotNull long idDocente,
        @NotNull  @Email String correo,
        @NotNull  String passwordCuenta,
        @NotNull  String cedulaDocente,
        @NotNull  String nombreDocente
)

{}
