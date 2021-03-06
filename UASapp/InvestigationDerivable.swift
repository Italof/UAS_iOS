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
    //var idProject: Int
    //var projectName: String?
    var dateStart: String?
    var dateLimit: String?
    var percentage: Int
    //funcion inicializadora
    init(id:Int, name:String?, idProject: Int, projectName: String?, dateLimit:String?, dateStart:String?, percentage:Int){
        self.dateLimit = dateLimit
        self.dateStart = dateStart
        self.name = name
        self.percentage = percentage
        self.id = id
      //  self.idProject = idProject
    //    self.projectName = projectName
    }
    
    init(json : [String:Any]){
        //actualizar      
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let percentage = json["porcen_avance"] as! String
        let dateLimit = json["fecha_limite"] as! String
        ///let time = json["hora"] as! String
        let dateStart = json["fecha_inicio"] as! String
        
        self.dateStart=dateStart
        self.dateLimit=dateLimit
        //self.projectName=projectName
        //self.name=time
        self.name = name
        self.id = id
        //self.idProject = id
        self.percentage = Int(percentage)!
    }
}
