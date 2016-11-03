//
//  InvestigationDerivable.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//


struct InvestigationDerivable{
    //EStructura de evento de proyecto de investigaciòn
    //modelo
    var id: Int
    var name: String?
    var idProject: Int
    var projectName: String?
    var dateLimit: String?
    var percentage: Int
    //funcion inicializadora
    init(id:Int, name:String?, idProject: Int, projectName: String?, dateLimit:String?, percentage:Int){
        self.dateLimit = dateLimit
        self.name = name
        self.percentage = percentage
        self.id = id
        self.idProject = idProject
        self.projectName = projectName
    }
    
    init(json : [String:Any]){
        //actualizar      
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let place = json["lugar"] as! String
        let dateLimit = json["fecha"] as! String
        let time = json["hora"] as! String

        self.dateLimit=dateLimit
        self.projectName=place
        self.name=time
        self.name = name
        self.id = id
        self.idProject = id
        self.percentage = id
    }
}
