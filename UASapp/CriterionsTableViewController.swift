//
//  CriterionsTableViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/24/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CriterionsTableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var aspect : Aspect!
    var criterionArray = [Criterion]()
    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let token = userDefaults.string(forKey: "TOKEN")!
        let aspectId = aspect.id
        let url = "aspects/\(aspectId)/criterions/?token=\(token)"
        
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
                
                for i in jsonArray {
                    let jsonObject = i as! [String:AnyObject]
                    let criterion = Criterion(json: jsonObject)
                    self.criterionArray.append(criterion)
                }
            }
            
            LoadingOverlay.shared.hideOverlayView()
            self.overlay?.removeFromSuperview()
            
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
        return criterionArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "criterionCell", for: indexPath) as! CustomCriterionCell

            cell.lblTitle.text = criterionArray[indexPath.row].name
    
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "levelsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! LevelsTableViewController
                controller.criterion = criterionArray [indexPath.row]
            }
        }
    }
}
