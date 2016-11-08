//
//  ImprovementPlan.swift
//  UASapp
//
//  Created by Medical_I on 11/7/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ImprovementPlan {
    var id: Int
    var specialtyId: Int
    var description: String?
    var find: String?
    var cause: String?
    var startDate: Date?
    var status: String?
    var professor: String?
    var createdAt: Date?
    
    // Attributes for the type of improvemet plan
    var typeId: Int
    var typeCode: String?
    var typeTopic: String?
    var typeDesc: String?
    
    init(json: [String:AnyObject]) {
        self.id = json["IdPlanMejora"] as! Int
        self.specialtyId = Int(json["IdEspecialidad"] as! String)!
        self.description = (json["Descripcion"] as? String)!
        self.find = json["Hallazgo"] as? String
        self.cause = json["AnalisisCausal"] as? String
        self.status = json["Estado"] as? String

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.startDate = dateFormatter.date(from: json["FechaImplementacion"] as! String)!
        self.createdAt = dateFormatter.date(from: json["created_at"] as! String)!
        
        let professor = json["teacher"] as! [String:AnyObject]
        self.professor = (professor["Nombre"] as? String)! + " " +
                        (professor["ApellidoPaterno"] as? String)! + " " +
                        (professor["ApellidoMaterno"] as? String)!
        
        let typeOfPlan = json["type_improvement_plan"] as! [String:AnyObject]
        self.typeId = typeOfPlan["IdTipoPlanMejora"] as! Int
        self.typeCode = (typeOfPlan["Codigo"] as? String)!
        self.typeTopic = (typeOfPlan["Tema"] as? String)!
        self.typeDesc = (typeOfPlan["Descripcion"] as? String)!
        
    }
    
}
