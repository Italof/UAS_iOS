//
//  Aspect.swift
//  UASapp
//
//  Created by Medical_I on 11/8/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class Aspect {
    var id : Int
    var outcomeId : Int
    var name : String?
    var status : Int
    
    init(json : [String:AnyObject]) {
        print(json)
        id = json["IdAspecto"] as! Int
        outcomeId = Int(json["IdResultadoEstudiantil"] as! String)!
        name = json["Nombre"] as? String
        status = Int(json["Estado"] as! String)!
    }
}
