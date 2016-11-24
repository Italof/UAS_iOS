//
//  Evidence.swift
//  UASapp
//
//  Created by inf227al on 23/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Evidence {
    //Estructura para una evidencia de medición del UAS
    //modelo
    var id: Int
    var name: String?
    var url: String?
    var idSchedule: String?
    var idArchivo: String?
    
    //funcion inicializadora
    init(id:Int, name:String?, url:String?, idSchedule: String?, idArchivo: String?){
        self.id = id
        self.url = url
        self.name = name
        self.idSchedule = idSchedule
        self.idArchivo = idArchivo
    }
    
}
