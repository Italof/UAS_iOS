//
//  Faculty.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Faculty {
    //Estructura para una facultas del UAS
    //modelo
    var id: Int
    var name: String?
    var code: String?
    var coordinator: String?
    var description: String?
    //funcion inicializadora
    init(id:Int, name:String?, code: String?, coordinator: String?,description:String?){
        self.id = id
        self.name = name
        self.code = code
        self.coordinator = coordinator
        self.description = description
    }
    
}
