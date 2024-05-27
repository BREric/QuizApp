package co.org.uniquindio.quiz.servicios.impl;

import co.org.uniquindio.quiz.dto.TokenDTO;
import co.org.uniquindio.quiz.dto.cuenta.SesionDTO;
import co.org.uniquindio.quiz.repositorios.CuentaRepo;
import co.org.uniquindio.quiz.servicios.interfaces.AutentificacionServicio;
import co.org.uniquindio.quiz.utils.JWTUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class AutentificacionServicioImpl implements AutentificacionServicio {

    @Autowired
    private final CuentaRepo cuentaRepository;

    @Autowired
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
        Map<String, Object> result = cuentaRepository.iniciarSesionAlumno(sesionDTO.email(), sesionDTO.password());
        if (result != null && !result.isEmpty()) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("rol", "ALUMNO");
            claims.put("nombre", result.get("nombre"));
            claims.put("codigo", result.get("codigo"));
            return new TokenDTO(jwtUtils.generarToken(sesionDTO.email(), claims));
        }
        return null;
    }

    private TokenDTO iniciarSesionDocente(SesionDTO sesionDTO) throws Exception {
        Map<String, Object> result = cuentaRepository.iniciarSesionDocente(sesionDTO.email(), sesionDTO.password());
        if (result != null && !result.isEmpty()) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("rol", "DOCENTE");
            claims.put("nombre", result.get("nombre"));
            claims.put("codigo", result.get("codigo"));
            return new TokenDTO(jwtUtils.generarToken(sesionDTO.email(), claims));
        }
        return null;
    }
}
