//
//  PspStudent.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 10/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation


class PspStudent {
    

    var id:Int
    var idalumno:Int
    var idespecialidad:Int?
    var idpspgroup:Int?
    var idpspprocess:String?
    var idsupervisor:Int?
    var idtipoestado:Int?
    var created_at:String?
    var updated_at:String?
    var deleted_at:String?
    
    
    init(id:Int,idalumno:Int,idespecialidad:Int?,idpspgroup:Int?,idpspprocess:String?,idsupervisor:Int?,created_at:String?,updated_at:String?,deleted_at:String?,idtipoestado:Int?) {

        self.id = id
        self.idalumno = idalumno
        self.idespecialidad = idespecialidad
        self.idpspgroup = idpspgroup
        self.idpspprocess = idpspprocess
        self.idsupervisor = idsupervisor
        self.idtipoestado = idtipoestado
        self.created_at=created_at
        self.updated_at=updated_at
        self.deleted_at=deleted_at
        
    }
    
}
