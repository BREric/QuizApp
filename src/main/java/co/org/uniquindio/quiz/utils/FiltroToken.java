package co.org.uniquindio.quiz.utils;

import co.org.uniquindio.quiz.dto.MensajeDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.security.SignatureException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@RequiredArgsConstructor
public class FiltroToken extends OncePerRequestFilter {
    private final JWTUtils jwtUtils;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // Configuracion de cabeceras para CORS
        response.addHeader("Access-Control-Allow-Origin" , "*");
        response.addHeader("Access-Control-Allow-Methods" , "GET, POST, PUT, DELETE, OPTIONS");
        response.addHeader("Access-Control-Allow-Headers" , "Origin, Accept, Content-Type, Authorization");

        if (request.getMethod().equals("OPTIONS")) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            // Obtener la URI de la peticion que se esta realizando
            String requestURI = request.getRequestURI();

            // Se obtiene el token de la peticion del encabezado del mensaje HTTP
            String token = getToken(request);
            boolean error = true;

            try {
                // Validar el token y rol para diferentes rutas
                if (requestURI.startsWith("/api/alumnos")) {
                    error = !validarTokenYRol(token, "ALUMNO", response);
                } else if (requestURI.startsWith("/api/docentes")) {
                    error = !validarTokenYRol(token, "DOCENTE", response);
                } else {
                    error = false; // No hay restricciones en la ruta
                }

                // Agregar más validaciones para otros roles y recursos (rutas de la API) aquí
            } catch (MalformedJwtException | SignatureException e) {
                crearRespuestaError("El token es incorrecto", HttpServletResponse.SC_INTERNAL_SERVER_ERROR, response);
            } catch (ExpiredJwtException e) {
                crearRespuestaError("El token está vencido", HttpServletResponse.SC_INTERNAL_SERVER_ERROR, response);
            } catch (Exception e) {
                crearRespuestaError(e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR, response);
            }

            if (!error) {
                filterChain.doFilter(request, response);
            }
        }
    }

    private boolean validarTokenYRol(String token, String rolEsperado, HttpServletResponse response) throws IOException {
        if (token != null) {
            Jws<Claims> jws = jwtUtils.parseJwt(token);
            if (!jws.getPayload().get("rol").equals(rolEsperado)) {
                crearRespuestaError("No tiene permisos para acceder a este recurso", HttpServletResponse.SC_FORBIDDEN, response);
                return false;
            }
            return true;
        } else {
            crearRespuestaError("No tiene permisos para acceder a este recurso", HttpServletResponse.SC_FORBIDDEN, response);
            return false;
        }
    }

    private String getToken(HttpServletRequest req) {
        String header = req.getHeader("Authorization");
        if(header != null && header.startsWith("Bearer ")) {
            return header.replace("Bearer ", "");
        }
        return null;
    }

    private void crearRespuestaError(String mensaje, int codigoError, HttpServletResponse response) throws IOException {
        MensajeDTO<String> mensajeDTO = new MensajeDTO<>(true, mensaje);
        response.setContentType("application/json");
        response.setStatus(codigoError);
        response.getWriter().write(new ObjectMapper().writeValueAsString(mensajeDTO));
        response.getWriter().flush();
        response.getWriter().close();
    }
}
