//
//  PspReuniones.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

class PspReuniones {
    var asistencia:String?
    var fecha: String?
    var hora_fin: String?
    var hora_inicio: String?
    var idFreeHour: Int?
    var idMeeting : Int
    var idStudent: Int?
    var idSupervisor: String?
    var idTipoEstado: String?
    var lugar: String?
    var observaciones: String?
    var retroalimentacion: String?
    var tipoReunion: Int?
    var alumno:Alumnos?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?


    init(asistencia: String?,fecha:String?,hora_fin:String?,hora_inicio:String?,idFreeHour:Int?,idMeeting:Int,idStudent:Int?,idSupervisor:String?,idTipoEstado:String?,lugar:String?,observaciones:String?,retroalimentacion:String?,tipoReunion:Int?,alumno:Alumnos?,created_at:String?,updated_at:String?,deleted_at:String?) {
        
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
        self.alumno = alumno
        self.created_at = created_at
        self.updated_at = updated_at
        self.deleted_at = deleted_at
    }
    
}
