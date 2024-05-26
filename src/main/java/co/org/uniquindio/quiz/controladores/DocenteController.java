package co.org.uniquindio.quiz.controladores;

import co.org.uniquindio.quiz.dto.Docente.DocenteUpdateDTO;
import co.org.uniquindio.quiz.dto.MensajeDTO;
import co.org.uniquindio.quiz.servicios.interfaces.DocenteServicio;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/alumnos")
@RequiredArgsConstructor
public class DocenteController {

    private final DocenteServicio docenteServicio;

    @PutMapping("/actualizar-docente")
    public ResponseEntity<MensajeDTO<String>> actualizarDocente( @RequestBody DocenteUpdateDTO docenteUpdateDTO)throws Exception {
        docenteServicio.actualizarDocente(docenteUpdateDTO);
        return ResponseEntity.ok().body(new MensajeDTO<>(false, "Docente actualizado con exito"));
    }


    }

