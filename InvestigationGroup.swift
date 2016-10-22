//
//  InvestigationGroup.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//



struct InvestigationGroup {
    //EStructura de grupo de investigaciòn
    //modelo
    var id: Int
    var name: String?
    var speciality: String?
    var description: String?
    var imageInvGr: String?
    var createdInvGr: String?
    var leaderName: String?
    //funcion inicializadora
    init(id:Int, name:String?, speciality:String?, description:String?, imageInvGr: String?, createdInvGr: String?, leaderName:String?){
        self.description=description
        self.name=name
        self.speciality=speciality
        self.id = id
        self.createdInvGr = createdInvGr
        self.imageInvGr = imageInvGr
    }
    
}
