//
//  Grupos.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class Grupos {
    var descripcion:String?
    var id: Int
    var numero: String?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
    var idpspprocess: Int?
    
    init(descripcion: String? = nil,id:Int,numero:String? = nil,idpspprocess: Int?,created_at:String?,updated_at:String?,deleted_at:String?) {
        self.descripcion = descripcion
        self.id = id
        self.numero = numero
        self.idpspprocess = idpspprocess
        self.created_at = created_at
        self.updated_at = updated_at
        self.deleted_at = deleted_at
        
        
    }
    
}
