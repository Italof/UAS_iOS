//
//  ImprovementPlanTableViewController.swift
//  UASapp
//
//  Created by Medical_I on 11/7/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ImprovementPlanTableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var planArray = [ImprovementPlan]()
    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = userDefaults.string(forKey: "TOKEN")!
        let faculty = userDefaults.integer(forKey: "SPECIALTY")
        let url = "faculties/\(faculty)/improvement_plans/?token=\(token)"
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
        
        HTTPHelper.get(route: url, authenticated: true, completion: { (error, response) in
            if error != nil {
                print("REQUESTED ERROR: \(error!)")
            }
            else {
                let jsonArray = response as! [AnyObject]
                
                for iplan in jsonArray {
                    let jsonIPlan = iplan as! [String:AnyObject]
                    let iplanDetail = ImprovementPlan(json: jsonIPlan)
                    self.planArray.append(iplanDetail)
                }
                
                if self.planArray.count < 1 {
                    let alert = UIAlertController(title: "Lo sentimos",
                                                       message: "No se encontro ningún plan de mejora",
                                                       preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            LoadingOverlay.shared.hideOverlayView()
            self.overlay?.removeFromSuperview()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                return
            }
            
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return planArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "impPlanCell", for: indexPath) as! CustomImpPlanCell
        
        cell.lblTitle.text = self.planArray[indexPath.row].description

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "planDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! PlanDetailViewController
                controller.impPlan = planArray[indexPath.row]
            }
        }
    }


}
