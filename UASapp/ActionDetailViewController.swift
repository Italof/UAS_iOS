//
//  ActionDetailViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/21/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ActionDetailViewController: UIViewController {
    var action : Action!
    
    @IBOutlet weak var lblCicle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblProf: UILabel!
    @IBOutlet weak var lblComent: UILabel!
    @IBOutlet weak var lblAvance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCicle.text = action.cicle
        lblDesc.text = action.description
        lblProf.text = action.professor
        lblComent.text = action.coment
        lblAvance.text = action.percent! + " %"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downloadFile() {
    }
}
