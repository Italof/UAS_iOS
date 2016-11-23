//
//  Action.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/21/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class Action {
    var id : Int
    var description: String?
    var coment : String?
    var percent : String?
    var fileName : String?
    var professor : String?
    var cicle : String?
    var status : String?
    
    init (json: [String:AnyObject]) {
        id = json["IdPlanAccion"] as! Int
        description = json["Descripcion"] as? String
        coment = json["Comentario"] as? String
        percent = json["Porcentaje"] as? String
        
        let file = json["file"] as? [String:AnyObject]
        if  (file != nil) {
            fileName = file!["filename"] as? String
        } else {
            fileName = nil
        }
        
        let prof = json["teacher"] as? [String:AnyObject]
        if (prof != nil){
            professor = (prof!["Nombre"] as? String)! + " " +
                (prof!["ApellidoPaterno"] as? String)! + " " +
                (prof!["ApellidoMaterno"] as? String)!
        } else {
            professor = "Todos"
        }
        
        cicle = (json["cicle"] as? [String:AnyObject])?["Descripcion"] as? String
        if cicle == nil { cicle = "" }
        
        let st = json["Estado"] as? String
        if st != nil {
            status = st
        } else {
            status = "Activo"
        }
    }
}
