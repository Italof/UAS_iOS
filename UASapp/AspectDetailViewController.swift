//
//  AspectDetailViewController.swift
//  UASapp
//
//  Created by Medical_I on 11/8/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class AspectDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOutcome: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    var aspect : Aspect!
    var outcome : StudentOutcome!
    var criterionArray = [Criterion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = aspect.name
        lblOutcome.text = outcome.identifier + " - " + outcome.name
        
        var status : String
        if aspect?.status == 1 {
            status = "Activo"
        }
        else {
            status = "Inactivo"
        }
        
        lblStatus.text = status
        
        // Set criterions
        let token = userDefaults.string(forKey: "TOKEN")!
        let aspectId = (aspect?.id)!
        let url = "aspects/\(aspectId)/criterions/?token=\(token)"
        
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
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
                return
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "criterionCell", for: indexPath) as! CustomCriterionCell
        
        cell.lblTitle.text = criterionArray[indexPath.row].name
        print("CELL NAME:")
        print(criterionArray[indexPath.row].name!)
        return cell
    }

}
