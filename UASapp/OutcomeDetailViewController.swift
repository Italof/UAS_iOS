//
//  OutcomeDetailViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class OutcomeDetailViewController: UIViewController {
    
    @IBOutlet weak var lblOutcome: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnAspects: UIButton!
    
    
    var outcome : StudentOutcome!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblOutcome.text = outcome.name
        lblStatus.text = outcome.status
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aspectsSegue" {
            let controller = segue.destination as! AspectsTableViewController
            controller.outcome = outcome
        }
    }
    
}
