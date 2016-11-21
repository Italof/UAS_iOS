//
//  InvestigationDocument.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

struct InvestigationDocument {
    //EStructura de grupo de investigaciòn
    //modelo
    var id: Int
    //var idDer: String?
    var version: String?
    //var description: String?
    var dateDeliver: String?
    var observation: String?
    var route: String?
    
    //funcion inicializadora
    init(id:Int,  version:String?, description:String?, dateDeliver: String?, observation: String?, route:String?){
        //self.description=description
        //self.name=name
        self.version=version
        self.id = id
        self.route = route
        self.dateDeliver = dateDeliver
        self.observation = observation
    }
    
    
    init(json : [String:Any]){
        
        let id = json["id"] as! Int
        //let name = json["nombre"] as! String
        //let description = json["fecha_ini"] as! String
        let route = json["ruta"] as! String
        let dateDeliver = json["created_at"] as! String
        let observation = json["observacion"] as! String
        let version = json["version"] as! String
        
        
        //self.description=description
        //self.name=name
        self.version=version
        self.id = id
        self.route = route
        self.dateDeliver = dateDeliver
        self.observation = observation
    }
}
