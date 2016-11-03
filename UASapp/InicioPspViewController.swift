//
//  InicioPspViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InicioPspViewController: UIViewController {
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
