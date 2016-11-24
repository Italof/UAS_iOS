//
//  Fases.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class Fases {
    var descripcion:String?
    var fecha_inicio: String?
    var fecha_fin: String?
    var idPhase: Int
    var numero: String?
    var idpspprocess: String?
    var created_at:String?
    var updated_at:String?
    var deleted_at:String?
    
    init(descripcion: String? = nil,fecha_inicio:String? = nil,fecha_fin:String? = nil,idPhase:Int,numero:String? = nil,idpspprocess:String?=nil,created_at:String?=nil,updated_at:String?=nil,deleted_at:String?=nil) {
       
        self.descripcion = descripcion
        self.fecha_inicio = fecha_inicio
        self.fecha_fin = fecha_fin
        self.idPhase = idPhase
        self.numero = numero
        self.idpspprocess = idpspprocess
        self.created_at=created_at
        self.updated_at=updated_at
        self.deleted_at=deleted_at
    }

}


