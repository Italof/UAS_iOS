//
//  Supervisor.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class Supervisor {
    var apellido_materno:String
    var apellido_paterno: String
    var codigo_trabajador: String
    var correo: String
    var direccion: String
    var idEspecialidad: Int
    var idSupervisor: Int
    var idUsuario: Int
    var nombres: String
    var telefono: String
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
    var idpspprocess: Int?

    
    init(apellido_materno:String,apellido_paterno: String,codigo_trabajador: String,correo: String,direccion: String,idEspecialidad: Int,idSupervisor: Int,idUsuario: Int,nombres: String,telefono:String,idpspprocess: Int?,created_at:String?,updated_at:String?,deleted_at:String?) {
        
        self.apellido_materno = apellido_materno
        self.apellido_paterno = apellido_paterno
        self.codigo_trabajador = codigo_trabajador
        self.correo = correo
        self.direccion = direccion
        self.idEspecialidad = idEspecialidad
        self.idSupervisor = idSupervisor
        self.idUsuario = idUsuario
        self.nombres = nombres
        self.telefono = telefono
        self.idpspprocess = idpspprocess
        self.created_at = created_at
        self.updated_at = updated_at
        self.deleted_at = deleted_at
        
    }
    
}
