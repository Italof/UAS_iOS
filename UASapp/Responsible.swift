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
    var name: String?
    var lastNameP: String?
    var lastNameM: String?
    
    //funcion inicializadora
    init(name:String?, lastNameP: String?, lastNameM: String?, email:String?, cellphone:String?, area:String?, speciality:String?, idUser: Int){
        self.name = name
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
    }
    
    init(jsonInv : [String:Any]){
        //actualizar
        let name = jsonInv["nombre"] as! String
        let lastNameP = jsonInv["ape_paterno"] as! String
        let lastNameM = jsonInv["ape_materno"] as! String
        
        self.name = name
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
    }
    init(jsonStu : [String:Any]){
        //actualizar
        let name = jsonStu["nombre"] as! String
        let lastNameP = jsonStu["ape_paterno"] as! String
        let lastNameM = jsonStu["ape_materno"] as! String
        
        self.name = name
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
    }
    init(jsonTea : [String:Any]){
        //actualizar
        let name = jsonTea["Nombre"] as! String
        let lastNameP = jsonTea["ApellidoPaterno"] as! String
        let lastNameM = jsonTea["ApellidoMaterno"] as! String
        
        self.name = name
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
    }

}
