//
//  Alumnos.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation
class Alumnos{
    var ApellidoMaterno:String?
    var ApellidoPaterno:String?
    var Codigo:String?
    var IdUsuario:Int?
    var Nombre:String?
    var idAlumno:Int
    var idHorario:Int?
    var lleva_psp:String?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
 
    
    init(ApellidoMaterno:String?,ApellidoPaterno:String?,Codigo:String?,IdUsuario:Int?,Nombre:String?,idAlumno:Int,idHorario:Int?,lleva_psp:String?,created_at:String?,updated_at:String?,deleted_at:String?) {
        self.ApellidoMaterno = ApellidoMaterno
        self.ApellidoPaterno = ApellidoPaterno
        self.Codigo = Codigo
        self.IdUsuario = IdUsuario
        self.Nombre = Nombre
        self.idAlumno = idAlumno
        self.idHorario = idHorario
        self.lleva_psp = lleva_psp
        self.created_at = created_at
        self.updated_at = updated_at
        self.deleted_at = deleted_at
  
    }
    
}
