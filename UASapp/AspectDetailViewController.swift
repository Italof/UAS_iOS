//
//  AspectDetailViewController.swift
//  UASapp
//
//  Created by Medical_I on 11/8/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class AspectDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOutcome: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var aspect : Aspect!
    var outcome : StudentOutcome!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = aspect.name
        lblOutcome.text = outcome.identifier + " - " + outcome.name
        
        var status : String
        if aspect?.status == 1 {
            status = "Activo"
        }
        else {
            status = "Inactivo"
        }
        
        lblStatus.text = status
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
