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
    
}
