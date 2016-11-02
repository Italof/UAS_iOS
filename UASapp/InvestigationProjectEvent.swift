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
    //funcion inicializadora
    init(id:Int, name:String?, date:String?, time:String?, place: String?){
        self.date=date
        self.name=name
        self.time=time
        self.id = id
        self.place = place
    }
    
    init(json : [String:Any]){
                
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
