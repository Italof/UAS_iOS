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
     var role: Int = Int(UserDefaults.standard.object(forKey: "ROLE")  as! String)!
    
    @IBOutlet weak var profesor: UIButton!
    @IBOutlet weak var alumno: UIButton!
    @IBOutlet weak var supervisor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(role==0)
        {
            profesor.isHidden=true
            supervisor.isHidden=true
        }
        else if(role==2)
        {
         alumno.isHidden=true
        supervisor.isHidden=true
        }
        else if(role==6)
        {
            profesor.isHidden=true
            alumno.isHidden=true
        }
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
