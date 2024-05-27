package co.org.uniquindio.quiz.controladores;

import co.org.uniquindio.quiz.dto.TokenDTO;
import co.org.uniquindio.quiz.dto.cuenta.SesionDTO;
import co.org.uniquindio.quiz.servicios.interfaces.AutentificacionServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AutentificacionController {
    @Autowired
    private final AutentificacionServicio autentificacionServicio;

    @PostMapping("/iniciar-sesion")
    public TokenDTO iniciarSesion(@RequestBody SesionDTO sesionDTO) throws Exception {
        return autentificacionServicio.iniciarSesion(sesionDTO);
    }
}
