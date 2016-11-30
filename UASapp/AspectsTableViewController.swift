//
//  AspectsTableViewController.swift
//  UASapp
//
//  Created by Medical_I on 11/8/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class AspectsTableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var outcome : StudentOutcome!
    var aspectsArray = [Aspect]()
    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = userDefaults.string(forKey: "TOKEN")!
        let outcomeId = outcome.id
        let url = "faculties/student_result/\(outcomeId)/aspects/?token=\(token)"
        
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
                    let aspect = Aspect(json: jsonObject)
                    self.aspectsArray.append(aspect)
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
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aspectsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aspectCell", for: indexPath) as! CustomAspectCell
        
        cell.lblTitle.text = aspectsArray[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "criterionsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! CriterionsTableViewController
                controller.aspect = aspectsArray[indexPath.row]
            }
        }
    }

}
