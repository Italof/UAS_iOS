//
//  GoalDetailViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class GoalDetailViewController: UIViewController {
    
    @IBOutlet weak var lblGoal: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnOutcomes: UIButton!
    
    var goal : EducationalGoal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblGoal.text = goal.name
        lblStatus.text = goal.status
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "outcomesSegue" {
            let controller = segue.destination as! StudentOutcomesViewController
            controller.goal = goal
        }
    }
    
}
