//
//  EducationalGoalsViewController.swift
//  UASapp
//
//  Created by Medical_I on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class EducationalGoalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var goalTblView: UITableView!

    let goals = ["Conducir el análisis de procesos de negocio y necesidades de información de la organización",
                 "Dirigir las actividades del ciclo de vida del proyectos informáticos, utilizando tecnología, estadares y herramientas adecuadas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(goals.count)
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.goalTblView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! CustomGoalCell
        cell.lblGoal.text = goals[indexPath.row]
        
        print(cell.lblGoal)
        return cell
    }
}
