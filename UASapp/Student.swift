//
//  Student.swift
//  UASapp
//
//  Created by inf227al on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Student {
    //Estructura para un estudiante del UAS
    //modelo
    var id: Int
    var name: String?
    var apePaterno: String?
    var apeMaterno: String?
    var schedule: Int
    var code: String?
    //funcion inicializadora
    init(id:Int, name:String?, apePaterno: String?, apeMaterno: String?, schedule: Int, code: String?){
        self.id = id
        self.name = name
        self.apePaterno = apePaterno
        self.apeMaterno = apeMaterno
        self.schedule = schedule
        self.code = code
    }
}
