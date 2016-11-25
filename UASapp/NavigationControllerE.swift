//
//  NavigationControllerE.swift
//  UASapp
//
//  Created by inf227al on 22/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class NavigationControllerE: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var evalOb: [evaluation] = []
    var evalObF: [evaluation] = []
    var filtro: String = "N"
    var evalEsc: evaluation!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
