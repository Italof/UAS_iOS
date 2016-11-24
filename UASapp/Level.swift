//
//  Level.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/24/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class Level {
    var id : Int
    var value : Int
    var description : String?
    
    init(json : [String:AnyObject]) {
        id = json["IdNivelCriterio"] as! Int
        value = Int(json["Valor"] as! String)!
        
        if let desc = json["Descripcion"] {
            self.description = desc as? String
        } else {
            self.description = ""
        }
    }
}
