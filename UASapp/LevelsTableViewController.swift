//
//  LevelsTableViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/24/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class LevelsTableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var criterion : Criterion!
    var levelArray = [Level]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = userDefaults.string(forKey: "TOKEN")!
        let criterionId = criterion.id
        let url = "criterions/\(criterionId)/levels?token=\(token)"
        
        HTTPHelper.get(route: url, authenticated: true, completion: { (error, response) in
            if error != nil {
                print("REQUESTED ERROR: \(error!)")
            }
            else {
                let jsonArray = response as! [AnyObject]
                
                for i in jsonArray {
                    let jsonObject = i as! [String:AnyObject]
                    let level = Level(json: jsonObject)
                    self.levelArray.append(level)
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
        return levelArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath) as! CustomLevelCell
        
        cell.lblTitle.text = levelArray[indexPath.row].description
        cell.lblValue.text = String(levelArray[indexPath.row].value)
        
        return cell
    }
}
