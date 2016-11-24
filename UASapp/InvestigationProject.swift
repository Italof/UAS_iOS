//
//  InvestigationProject.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct InvestigationProject {
    //EStructura de grupo de investigaciòn
    //modelo
    var id: Int
    var name: String?
    var numberDerivables: Int
    var startDate: String?
    var endDate: String?
    var invGroupName: String?
    var idLeader: Int
    var description: String?
    //funcion inicializadora
    init(id:Int, name:String?, numberDerivables:Int, startDate:String?, endDate: String?, invGroupName: String?, leaderName:String?, idLeader: Int, description: String?){
        self.startDate=startDate
        self.name=name
        self.numberDerivables=numberDerivables
        self.id = id
        self.description = description
        self.idLeader = idLeader
        self.endDate = endDate
        self.invGroupName = invGroupName
    }
    
    
    init(json : [String:Any]){
        
        let id = json["id"] as! Int
        let name = json["nombre"] as! String
        let numberDerivables: Int? = Int( json["num_entregables"] as! String)
        let startDate = json["fecha_ini"] as! String
        let endDate = json["fecha_fin"] as! String
        let group = json["group"] as! [String:Any]
        let invGroupName = group["nombre"] as! String
        let idLeader = group["id_lider"] as! String
        let description = json["descripcion"] as! String
        
        self.description = description
        self.startDate=startDate
        self.name=name
        self.idLeader = Int(idLeader)!
        self.numberDerivables=numberDerivables.unsafelyUnwrapped
        self.id = id
        self.endDate = endDate
        self.invGroupName = invGroupName
    }
}
