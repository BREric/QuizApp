package co.org.uniquindio.quiz.servicios.impl;

import co.org.uniquindio.quiz.dto.Docente.DocenteUpdateDTO;
import co.org.uniquindio.quiz.repositorios.DocenteRepo;
import co.org.uniquindio.quiz.servicios.interfaces.DocenteServicio;
<<<<<<< HEAD

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

=======
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

>>>>>>> 84258cb19c6f1f3f98a8a2e51aef6262180a0cc8

@Service
@Transactional
@RequiredArgsConstructor
public class DocenteServicioImpl implements DocenteServicio {
    DocenteRepo docenteRepo;
    @Override
    public void actualizarDocente(DocenteUpdateDTO docenteUpdateDTO) throws Exception {
        docenteRepo.actualizarDocente( docenteUpdateDTO.idDocente(), docenteUpdateDTO.correo(), docenteUpdateDTO.passwordCuenta(),  docenteUpdateDTO.nombreDocente());
    }
}
