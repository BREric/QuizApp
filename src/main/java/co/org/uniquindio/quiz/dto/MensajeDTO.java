package co.org.uniquindio.quiz.dto;

public record MensajeDTO<T>(
        boolean error,
        T respuesta
) {
}
