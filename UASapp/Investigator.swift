//
//  InvestigationDerivable.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//


struct Investigator{
    //EStructura de evento de proyecto de investigaciòn
    //modelo
    var id: Int
    var name: String?
    var lastNameP: String?
    var lastNameM: String?
    var email:  String?
    var cellphone:  String?

    var area:  String?
    var speciality: String?

    //funcion inicializadora
    init(id:Int, name:String?, lastNameP: Int, lastNameM: String?, email:String?, cellphone:String?, area:String?, speciality:String?){
        self.email = email
        self.name = name
        self.cellphone = cellphone
        self.id = id
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
        self.area = area
        self.speciality = speciality
    }
    
    init(json : [String:Any]){
        //actualizar      
        let id = pr["id"] as! Int
        let name = pr["nombre"] as! String
        let place = pr["lugar"] as! String
        let date = pr["fecha"] as! String
        let time = pr["hora"] as! String

        self.email = email
        self.name = name
        self.cellphone = cellphone
        self.id = id
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
        self.area = area
        self.speciality = speciality
    }
}
