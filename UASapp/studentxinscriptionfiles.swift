//
//  studentxinscriptionfiles.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 4/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class studentxinscriptionfiles {
    var id: Int
    var idStudent: Int
    var nota_final: Int
    var acepta_terminos: Int
    var created_at:String?
    var updated_at:String?
    var deleted_at:String?
    
    init(id: Int,idStudent:Int,nota_final: Int,acepta_terminos: Int,created_at:String?,updated_at:String?,deleted_at:String?) {
        self.id = id
        self.idStudent = idStudent
        self.nota_final = nota_final
        self.acepta_terminos = acepta_terminos
        self.created_at=created_at
        self.updated_at=updated_at
        self.deleted_at=deleted_at
        
    }
    
}
