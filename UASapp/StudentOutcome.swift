//
//  StudentOutcomes.swift
//  UASapp
//
//  Created by Medical_I on 11/4/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class StudentOutcome {
    var id : Int
    var identifier : String
    var name : String
    var status : String
    
    init?(id: Int, identifier: String, name: String, status: Int) {
        self.id = id
        self.identifier = identifier
        self.name = name
        
        
        if id < 0 || identifier.isEmpty || status < 0 || name.isEmpty {
            return nil
        }
        
        switch status {
        case 0:
            self.status = "Inactivo"
        case 1:
            self.status = "Activo"
        default:
            self.status = "Activo"
        }
    }
    
}
