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
    var idLeader: Int
    //funcion inicializadora
    init(id:Int, name:String?, speciality:String?, description:String?, imageInvGr: String?, createdInvGr: String?, leaderName:String?, idLeader: Int){
        self.description=description
        self.name=name
        self.speciality=speciality
        self.id = id
        self.createdInvGr = createdInvGr
        self.imageInvGr = imageInvGr
        self.idLeader = idLeader
    }
    init(json : [String:Any]){
        let id = json["id"]
        let name = json["nombre"]
        let description = json["descripcion"]
        let image = json["imagen"]
        //let createdInvGr = json["created_at"]
        let faculty = json["faculty"] as! [String:Any]
        let speciality = faculty["Nombre"]
        let leader = json["leader"] as! [String:Any]
        let leaderName = (leader["Nombre"] as! String) + " " + (leader["ApellidoPaterno"] as! String) + " " + (leader["ApellidoMaterno"] as! String)
        let idLeader = json["id_lider"] as! String
        
        self.description = description as? String
        self.name = name as? String
        self.speciality = speciality as? String
        self.id = id as! Int
        self.idLeader = Int(idLeader)!
        self.createdInvGr = ""//createdInvGr as! String
        self.imageInvGr = image as? String
        self.leaderName = leaderName as String
        /*
         if (id != nil){
         self.id = (id as! Int?)!
         }
         if (name != nil){
         self.name = (name as! String?)!
         }
         if (description != nil){
         self.description = (description as! String?)!
         }
         if (image != nil){
         self.imageInvGr = (image as! String?)!
         }
         if (createdInvGr != nil){
         self.createdInvGr = (createdInvGr as! String?)!
         }
         if (speciality != nil){
         self.speciality = (speciality as! String?)!
         }
         if (leaderName != nil){
         self.leaderName = (leaderName as String?)!
         }
         */
    }

    
}
