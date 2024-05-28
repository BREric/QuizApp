package co.org.uniquindio.quiz.servicios.impl;

import co.org.uniquindio.quiz.dto.TokenDTO;
import co.org.uniquindio.quiz.dto.cuenta.SesionDTO;
import co.org.uniquindio.quiz.modelo.Alumno;
import co.org.uniquindio.quiz.modelo.Cuenta;
import co.org.uniquindio.quiz.repositorios.CuentaRepo;
import co.org.uniquindio.quiz.servicios.interfaces.AutentificacionServicio;
import co.org.uniquindio.quiz.utils.JWTUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class AutentificacionServicioImpl implements AutentificacionServicio {

    private final CuentaRepo cuentaRepository;
    private final JWTUtils jwtUtils;

    @Override
    public TokenDTO iniciarSesion(SesionDTO sesionDTO) throws Exception {
        TokenDTO tokenDTO = iniciarSesionAlumno(sesionDTO);
        if (tokenDTO != null) {
            return tokenDTO;
        }
        return iniciarSesionDocente(sesionDTO);
    }

    private TokenDTO iniciarSesionAlumno(SesionDTO sesionDTO) throws Exception {
        Cuenta cuenta = (Cuenta) cuentaRepository.iniciar_sesion_alumno_proc(sesionDTO.email(), sesionDTO.password());
        if (cuenta != null) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("rol", "ALUMNO");
            claims.put("nombre", cuenta.getEmail());
            claims.put("codigo", cuenta.getId());
            return new TokenDTO(jwtUtils.generarToken(sesionDTO.email(), claims));
        }
        return null;
    }

    private TokenDTO iniciarSesionDocente(SesionDTO sesionDTO) throws Exception {
        Alumno a = new Alumno();
        Cuenta cuenta = (Cuenta) cuentaRepository.iniciar_sesion_docente_proc(sesionDTO.email(), sesionDTO.password());
        if (cuenta != null) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("rol", "DOCENTE");
            claims.put("nombre", cuenta.getEmail());
            claims.put("codigo", cuenta.getId());
            return new TokenDTO(jwtUtils.generarToken(sesionDTO.email(), claims));
        }
        return null;
    }
}
