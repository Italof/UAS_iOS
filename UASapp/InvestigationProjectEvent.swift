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
    var idLeader: Int
    var image: String?
    var type: Int
    //funcion inicializadora
    init(id:Int, name:String?, date:String?, time:String?, place: String?, description: String?, idLeader: Int, image:String?,type:Int){
        self.idLeader = idLeader
        self.date=date
        self.name=name
        self.time=time
        self.id = id
        self.place = place
        self.description = description
        self.image = image
        self.type = type
    }
    
    init(json : [String:Any]){
        
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let place = json["ubicacion"] as! String
        let date = json["fecha"] as! String
        let time = json["hora"] as! String
        let desc = json["descripcion"] as! String
        let leader = json["group"] as! [String:AnyObject]
        let idLeader = leader["id_lider"] as! String
        let image:String?
        if ((json["imagen"] as? String) != nil){
            image = json["imagen"] as! String?
        }
        else {image = ""}
        
        let type = json["tipo"] as! String
        
        self.type = Int(type)!
        self.image = image
        self.date=date
        self.idLeader = Int(idLeader)!
        self.place=place
        self.time=time
        self.name = name
        self.id = id
        self.description = desc
    }
}
