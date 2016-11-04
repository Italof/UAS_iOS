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
    var created_at: String?
    var deleted_at: String?
    var updated_at: String?
    var id: Int
    var numero: String?
    
    init(descripcion: String? = nil,created_at:String? = nil,deleted_at:String? = nil,updated_at:String? = nil,id:Int,numero:String? = nil) {
        self.descripcion = descripcion
        self.created_at = created_at
        self.deleted_at = deleted_at
        self.updated_at = updated_at
        self.id = id
        self.numero = numero
    }
    
}
