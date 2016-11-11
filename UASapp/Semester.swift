//
//  Semester.swift
//  UASapp
//
//  Created by inf227al on 9/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Semester {
    //Estructura para un semestre del UAS
    //modelo
    var id: Int
    var descripcion: String?
    //funcion inicializadora
    init(id:Int,descripcion:String?){
        self.id = id
        self.descripcion = descripcion
    }
}
