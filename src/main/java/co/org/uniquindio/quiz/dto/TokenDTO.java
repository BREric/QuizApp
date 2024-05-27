package co.org.uniquindio.quiz.dto;

import javax.validation.constraints.NotBlank;

public record TokenDTO(
        @NotBlank String token
) {
}
