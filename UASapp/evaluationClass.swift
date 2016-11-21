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
    
    init(nombre: String?, id: Int?, avance: String?, estado: String?, vigenciaI: Date?, vigenciaF: Date?){
        
        self.nombre = nombre
        self.avance = avance
        self.estado = estado
        self.id = id
        self.vigenciaI = vigenciaI
        self.vigenciaF = vigenciaF
        
    }
}
