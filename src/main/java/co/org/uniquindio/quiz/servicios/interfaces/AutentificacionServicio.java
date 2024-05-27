package co.org.uniquindio.quiz.servicios.interfaces;

import co.org.uniquindio.quiz.dto.TokenDTO;
import co.org.uniquindio.quiz.dto.cuenta.SesionDTO;

public interface AutentificacionServicio {
    TokenDTO iniciarSesion(SesionDTO sesionDTO) throws Exception;
}
