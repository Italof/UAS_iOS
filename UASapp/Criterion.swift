//
//  Criterion.swift
//  UASapp
//
//  Created by Medical_I on 11/9/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class Criterion {
    var id : Int
    var aspectId : Int
    var name : String?
    var status : String?
    
    init(json : [String:AnyObject]) {
        id = json["IdCriterio"] as! Int
        aspectId = Int(json["IdAspecto"] as! String)!
        
        if let name = json["Nombre"] {
            self.name = name as? String
        } else {
            self.name = ""
        }
        
        let status = Int(json["Estado"] as! String)!
        
        switch status {
        case 0:
            self.status = "Inactivo"
        case 1:
            self.status = "Activo"
        default:
            self.status = "Inactivo"
        }
    }
}
