//
//  Responsible.swift
//  UASapp
//
//  Created by inf227al on 25/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//
import Foundation
struct Responsible{
    //EStructura de evento de proyecto de investigaciòn
    //modelo
    var id: Int
    var name: String?
    var lastNameP: String?
    var lastNameM: String?
    var idUser: Int
    
    //funcion inicializadora
    init(id:Int, name:String?, lastNameP: String?, lastNameM: String?, email:String?, cellphone:String?, area:String?, speciality:String?, idUser: Int){
        self.name = name
        self.id = id
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
        self.idUser = idUser
    }
    
    init(json : [String:Any]){
        //actualizar
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let lastNameP = json["ape_paterno"] as! String
        let lastNameM = json["ape_materno"] as! String
        let idUser = json["id_usuario"] as! String
        
        self.name = name
        self.idUser = Int(idUser)!
        self.id = id
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
    }
    
}
