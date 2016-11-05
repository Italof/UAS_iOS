//
//  Course.swift
//  UASapp
//
//  Created by inf227al on 2/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Course {
    //Estructura para un curso del UAS
    //modelo
    var id: Int
    var idEspecialidad: String?
    var name: String?
    var code: String?
    var nivAcademico: String?

    //funcion inicializadora
    init(id:Int, idEspecialidad:String?, name:String?, code:String?, nivAcademico: String?){
        self.id = id
        self.idEspecialidad = idEspecialidad
        self.name = name
        self.code = code
        self.nivAcademico = nivAcademico
    }
    
}
