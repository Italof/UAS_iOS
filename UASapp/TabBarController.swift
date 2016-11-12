//
//  TabBarController.swift
//  UASapp
//
//  Created by inf227al on 5/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TABBAR")
        
        let role = userDefaults.integer(forKey: "ROLE")
        print(role)
        switch role {
        case 0:
            // Alumno
            // Borra acreditación
            self.viewControllers?.remove(at: 0)
            if true {
                // Borra psp
                self.viewControllers?.remove(at: 2)
            }
        case 1:
            // Coordinador
            let roleTuto = userDefaults.integer(forKey: "TUTORIA")
            if roleTuto != 1 {
                // Borra tutoria y psp
                self.viewControllers?.remove(at: 2)
                self.viewControllers?.remove(at: 2)
            }
            else {
                // Borra psp
                self.viewControllers?.remove(at: 3)
            }
        case 2:
            // Profesor
            let roleTuto = userDefaults.integer(forKey: "TUTORIA")
            if roleTuto != 1 {
                // Borra tutoria y psp
                self.viewControllers?.remove(at: 2)
                self.viewControllers?.remove(at: 2)
            }
            else {
                // Borra psp
                self.viewControllers?.remove(at: 3)
            }
            
        case 4:
            // Acreditador
            self.viewControllers?.remove(at: 1)
            self.viewControllers?.remove(at: 1)
            self.viewControllers?.remove(at: 1)
        case 5:
            // Investigador
            self.viewControllers?.remove(at: 0)
            self.viewControllers?.remove(at: 1)
            self.viewControllers?.remove(at: 1)
        default: break
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
