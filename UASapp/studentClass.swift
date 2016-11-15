//
//  studentClass.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation


class alumno{
    
    
    var alumno: String?
    var tutor: String?
    var estado: String?
    var codigo: Int?
    
    
    
    
    
    init(alumno: String?, codigo: Int?, tutor: String?, estado: String?){
        
        self.alumno = alumno
        self.tutor = tutor
        self.estado = estado
        self.codigo = codigo
        
    }
    
    init(alumno: String?, codigo: Int?){
        self.alumno = alumno
        self.codigo = codigo
    }
    
}
