//
//  citaClass.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class cita{
    
    
    var citaId: String?
    var fechaI: String?
    var horaI: String?
    var idTema: Int?
    var tema: String?
    var lugar: String?
    var infoExtra: String?
    var asistio: String?
    var observaciones: String?
    var idEstado: Int?
    var estado: String?
    var flagCreador: String?
    var idTutor: Int?
    var tutor: String?
    var idAlumno: Int?
    var alumno: String?
    
    
    
    
    
    
    init(citaId: String?,fechaI: String?, horaI: String?, tema: String?, alumno: String?,estado: String?){
        self.citaId = citaId
        self.fechaI = fechaI
        self.horaI = horaI
        self.tema = tema
        self.alumno = alumno
        self.estado = estado
        
    }
    init(citaId: String?, fechaI: String?, horaI: String?, idTema: Int?, tema: String?, lugar: String?, infoExtra: String?, asistio: String?, observaciones: String?, idEstado: Int?, estado: String?, flagCreador: String?, idTutor: Int?, tutor: String?, idAlumno: Int?, alumno: String?) {
        self.citaId = citaId
        self.fechaI = fechaI
        self.horaI = horaI
        self.idTema = idTema
        self.tema = tema
        self.lugar = lugar
        self.infoExtra = infoExtra
        self.asistio = asistio
        self.observaciones = observaciones
        self.idEstado = idEstado
        self.estado = estado
        self.flagCreador = flagCreador
        self.idTutor = idTutor
        self.tutor = tutor
        self.idAlumno = idAlumno
        self.alumno = alumno
    }
    
}
