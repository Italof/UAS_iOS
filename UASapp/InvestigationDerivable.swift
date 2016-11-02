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
    init(id:Int, name:String?, idProject: Int, projectName: String?, dateLimit:String?, percentage:String?){
        self.dateLimit = dateLimit
        self.name = name
        self.percentage = percentage
        self.id = id
        self.idProject = idProject
        self.projectName = projectName
    }
    
    init(json : [String:Any]){
        //actualizar      
        let id = pr["id"] as! Int
        let name = pr["nombre"] as! String
        let place = pr["lugar"] as! String
        let date = pr["fecha"] as! String
        let time = pr["hora"] as! String

        self.date=date
        self.place=place
        self.time=time
        self.name = name
        self.id = id
    }
}
