package co.org.uniquindio.quiz.controladores;

import co.org.uniquindio.quiz.dto.Docente.DocenteUpdateDTO;
import co.org.uniquindio.quiz.dto.MensajeDTO;
import co.org.uniquindio.quiz.servicios.interfaces.DocenteServicio;
<<<<<<< HEAD
=======
import jakarta.validation.Valid;
>>>>>>> 84258cb19c6f1f3f98a8a2e51aef6262180a0cc8
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
<<<<<<< HEAD
    public ResponseEntity<MensajeDTO<String>> actualizarDocente( @RequestBody DocenteUpdateDTO docenteUpdateDTO)throws Exception {
=======
    public ResponseEntity<MensajeDTO<String>> actualizarDocente(@Valid @RequestBody DocenteUpdateDTO docenteUpdateDTO)throws Exception {
>>>>>>> 84258cb19c6f1f3f98a8a2e51aef6262180a0cc8
        docenteServicio.actualizarDocente(docenteUpdateDTO);
        return ResponseEntity.ok().body(new MensajeDTO<>(false, "Docente actualizado con exito"));
    }


    }

