//
//  InvestigationGroup.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//



struct InvestigationGroup {
    var name: String?
    var speciality: String?
    var description: String?
    var id: Int
    
    init(id:Int, name:String?, speciality:String?, description:String?){
        self.description=description
        self.name=name
        self.speciality=speciality
        self.id = id
    }
}
