//
//  PspReunionesAlumnos.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 10/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class PspReunionesAlumnos {
    
    var asistencia:String?
    var fecha: String?
    var hora_fin: String?
    var hora_inicio: String?
    var idFreeHour: String?
    var idMeeting : Int
    var idStudent: String?
    var idSupervisor: String?
    var idTipoEstado: String?
    var lugar: String?
    var observaciones: String?
    var retroalimentacion: String?
    var tipoReunion: String?
    var supervisor:Supervisor?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
    
    init(asistencia: String?,fecha:String?,hora_fin:String?,hora_inicio:String?,idFreeHour:String?,idMeeting:Int,idStudent:String?,idSupervisor:String?,idTipoEstado:String?,lugar:String?,observaciones:String?,retroalimentacion:String?,tipoReunion:String?,supervisor:Supervisor?,created_at:String?,updated_at:String?,deleted_at:String?) {
        
        self.asistencia = asistencia
        self.fecha = fecha
        self.hora_fin = hora_fin
        self.hora_inicio = hora_inicio
        self.idFreeHour = idFreeHour
        self.idMeeting = idMeeting
        self.idStudent = idStudent
        self.idSupervisor = idSupervisor
        self.idTipoEstado = idTipoEstado
        self.lugar = lugar
        self.observaciones = observaciones
        self.retroalimentacion = retroalimentacion
        self.tipoReunion = tipoReunion
        self.supervisor = supervisor
        self.created_at = created_at
        self.updated_at = updated_at
        self.deleted_at = deleted_at
    }
    
}
