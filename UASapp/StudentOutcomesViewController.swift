//
//  StudentOutcomesViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class StudentOutcomesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var outcomesTblView: UITableView!
    let outcomes = ["A - Aplicar los conocimientos relacionados con las matemáticas, ciencias e ingenieria",
                    "B - Diseñar y conducir experimentos, y analizar e interpretar datos",
                    "C - Diseñar sistemas, componentes o procesos que satisfagan las necesidades presentadas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outcomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.outcomesTblView.dequeueReusableCell(withIdentifier: "outcomeCell", for: indexPath) as! CustomOutcomeCell
        cell.lblOutcome.text = outcomes[indexPath.row]
        return cell
    }

}
