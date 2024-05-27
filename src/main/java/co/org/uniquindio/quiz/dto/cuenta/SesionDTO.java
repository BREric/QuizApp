package co.org.uniquindio.quiz.dto.cuenta;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

public record SesionDTO(
        @NotBlank @Email String email,
        @NotBlank String password
) {
}
