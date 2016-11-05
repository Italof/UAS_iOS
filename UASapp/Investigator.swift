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
    var idUser: Int
    var area:  String?
    var speciality: String?
    
    //funcion inicializadora
    init(id:Int, name:String?, lastNameP: String?, lastNameM: String?, email:String?, cellphone:String?, area:String?, speciality:String?, idUser: Int){
        self.email = email
        self.name = name
        self.cellphone = cellphone
        self.id = id
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
        self.area = area
        self.speciality = speciality
        self.idUser = idUser
    }
    
    init(json : [String:Any]){
        //actualizar
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let lastNameP = json["ape_paterno"] as! String
        let lastNameM = json["ape_materno"] as! String
        let email = json["correo"] as! String
        let cellphone = json["celular"] as! String
        let faculty = json["faculty"] as! [String:Any]
        let speciality = faculty["Nombre"] as! String
        let areaJson = json["area"] as! [String:Any]
        let area = areaJson["nombre"] as! String
        let idUser = json["id_usuario"] as! String
        self.email = email
        self.name = name
        self.cellphone = cellphone
        self.idUser = Int(idUser)!
        self.id = id
        self.lastNameP = lastNameP
        self.lastNameM = lastNameM
        self.area = area
        self.speciality = speciality
    }

}
