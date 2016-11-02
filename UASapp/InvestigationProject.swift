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
    //funcion inicializadora
    init(id:Int, name:String?, numberDerivables:Int, startDate:String?, endDate: String?, invGroupName: String?, leaderName:String?){
        self.startDate=startDate
        self.name=name
        self.numberDerivables=numberDerivables
        self.id = id
        self.endDate = endDate
        self.invGroupName = invGroupName
    }
    

    init(json : [String:Any]){
                
        let id = pr["id"] as! Int
        let name = pr["nombre"] as! String
        let numberDerivables: Int? = Int( pr["num_entregables"] as! String)
        let startDate = pr["fecha_ini"] as! String
        let endDate = pr["fecha_fin"] as! String
        let group = pr["group"] as! [String:Any]
        let invNameGroup = group["nombre"] as! String
        let leaderName=""

        self.startDate=startDate
        self.name=name
        self.numberDerivables=numberDerivables
        self.id = id
        self.endDate = endDate
        self.invGroupName = invGroupName
    }
}
