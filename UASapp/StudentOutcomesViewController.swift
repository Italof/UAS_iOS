//
//  StudentOutcomesViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit


class StudentOutcomesViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var goal : EducationalGoal?
    
    var outcomesArray = [StudentOutcome]()
    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = userDefaults.string(forKey: "TOKEN")!
        let url = "faculties/\(userDefaults.string(forKey: "SPECIALTY")!)/eob/\((goal?.id)!)/students_results/?token=\(token)"
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
        
        HTTPHelper.get(route: url, authenticated: true, completion: { (error, responseData) in
            if error != nil {
                print("REQUESTED ERROR: \(error)")
                let responseError = error?.userInfo[NSLocalizedDescriptionKey] as! NSString
                let response = responseError.data(using: String.Encoding.utf8.rawValue)
                print(response!)
                do {
                    let jsonError = try JSONSerialization.jsonObject(with: response!, options: []) as! [String:NSString]
                    let msgError = jsonError["message"]! as NSString
                    
                    print(msgError)
                }
                catch {
                    print("NOT VALID JSON")
                }
            }
            else {
                let data = responseData as! [AnyObject]
                for outcome in data {
                    let outcomeDetail = outcome as! [String:AnyObject]
                    
                    let id = outcomeDetail["IdResultadoEstudiantil"] as! Int
                    let text = outcomeDetail["Descripcion"] as! String
                    let identifier = outcomeDetail["Identificador"] as! String
                    let status = Int(outcomeDetail["Estado"] as! String)
                    
                    let outcomeStruct = StudentOutcome(id: id, identifier: identifier, name: text, status: status!)
                    self.outcomesArray.append(outcomeStruct!)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return outcomesArray.count
        
        //        return outcomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "outcomeCell", for: indexPath) as! CustomOutcomeCell
        
        
        let outcome = outcomesArray[indexPath.row]
        cell.lblOutcome.text = "\(outcome.identifier) - \(outcome.name)"
        //            cell.lblOutcome.text = outcomes[indexPath.row]
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aspectsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! AspectsTableViewController
                controller.outcome = outcomesArray[indexPath.row]
            }
        }
    }
    
}
