//
//  citaClass.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class cita{
    
    
    var citaId: String?
    var fechaI: String?
    var horaI: String?
    var tema: String?
    // var tutor: String?
    var alumno: String?
    var estado: String?
    
    
    
    
    
    init(citaId: String?,fechaI: String?, horaI: String?, tema: String?, alumno: String?,estado: String?){
        self.citaId = citaId
        self.fechaI = fechaI
        self.horaI = horaI
        self.tema = tema
        self.alumno = alumno
        self.estado = estado
        
    }
    
}
