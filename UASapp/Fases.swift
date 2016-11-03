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
    
    init(descripcion: String? = nil,fecha_inicio:String? = nil,fecha_fin:String? = nil,idPhase:Int,numero:String? = nil) {
        self.descripcion = descripcion
        self.fecha_inicio = fecha_inicio
        self.fecha_fin = fecha_fin
        self.idPhase = idPhase
        self.numero = numero
    }

}


