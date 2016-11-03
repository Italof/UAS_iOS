//
//  InvestigationEvent.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//


struct InvestigationProjectEvent{
    //EStructura de evento de proyecto de investigaciòn
    //modelo
    var id: Int
    var name: String?
    var date: String?
    var time: String?
    var place: String?
    var description: String?
    //funcion inicializadora
    init(id:Int, name:String?, date:String?, time:String?, place: String?, description: String?){
        self.date=date
        self.name=name
        self.time=time
        self.id = id
        self.place = place
        self.description = description
    }
    
    init(json : [String:Any]){
                
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let place = json["ubicacion"] as! String
        let date = json["fecha"] as! String
        let time = json["hora"] as! String
        let desc = json["descripcion"] as! String
        
        self.date=date
        self.place=place
        self.time=time
        self.name = name
        self.id = id
        self.description = desc
    }
}
