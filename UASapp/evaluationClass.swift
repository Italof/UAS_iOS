//
//  evaluationClass.swift
//  UASapp
//
//  Created by inf227al on 16/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class evaluation{    
    
    var nombre: String?
    var avance: String?
    var estado: String?
    var id: Int?
    var vigenciaI: Date?
    var vigenciaF: Date?
    var descripcion: String?
    var tiempo: Int?
    
    var numCerr: Int?
    var numAbie: Int?
    var numArc: Int?
    var puntajeTotal: Int?
    init(nombre: String?, id: Int?, avance: String?, estado: String?, vigenciaI: Date?, vigenciaF: Date?, descripcion: String?, tiempo: Int?, numCerr: Int?, numAbie: Int?, numArc: Int?, puntajeTotal: Int?){
        
        self.nombre = nombre
        self.avance = avance
        self.estado = estado
        self.id = id
        self.vigenciaI = vigenciaI
        self.vigenciaF = vigenciaF
        self.descripcion = descripcion
        self.tiempo = tiempo
        self.numArc = numArc
        self.numAbie = numAbie
        self.numCerr = numCerr
        self.puntajeTotal = puntajeTotal
        
    }
}
