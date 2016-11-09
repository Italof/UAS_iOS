//
//  EducationalGoal.swift
//  UASapp
//
//  Created by Medical_I on 11/4/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class EducationalGoal {
    var id: Int
    var name: String
    var number: Int
    var status: String
    
    init?(id: Int, name: String, number: Int, status: Int) {
        self.id = id
        self.name = name
        self.number = number
        
        if id < 0 || number < 0 || status < 0 || name.isEmpty {
            return nil
        }
        
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
