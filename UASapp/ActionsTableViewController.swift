//
//  ActionsTableViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/21/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ActionsTableViewController: UITableViewController {
    var userDefaults = UserDefaults.standard
    var actionArray = [Action]()
    var impPlan : ImprovementPlan!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let token = userDefaults.string(forKey: "TOKEN")!
        let impPlanId = impPlan.id
        let url = "improvementplans/\(impPlanId)/actions/?token=\(token)"
        
        HTTPHelper.get(route: url, authenticated: true, completion: { (error, response) in
            if error != nil {
                print("REQUESTED ERROR: \(error!)")
            }
            else {
                let jsonArray = response as! [AnyObject]
                
                for i in jsonArray {
                    let jsonAction = i as! [String:AnyObject]
                    let action = Action(json: jsonAction)
                    self.actionArray.append(action)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                return
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return actionArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionCell", for: indexPath) as! CustomActionCell
        
        cell.lblTitle.text = self.actionArray[indexPath.row].description
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actionDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! ActionDetailViewController
                controller.action = actionArray[indexPath.row]
            }
        }
    }

}
