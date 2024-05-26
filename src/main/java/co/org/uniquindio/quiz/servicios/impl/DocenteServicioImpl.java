package co.org.uniquindio.quiz.servicios.impl;

import co.org.uniquindio.quiz.dto.Docente.DocenteUpdateDTO;
import co.org.uniquindio.quiz.repositorios.DocenteRepo;
import co.org.uniquindio.quiz.servicios.interfaces.DocenteServicio;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


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
