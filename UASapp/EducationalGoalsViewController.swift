//
//  EducationalGoalsViewController.swift
//  UASapp
//
//  Created by Medical_I on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit


class EducationalGoalsViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var goalsArray = [EducationalGoal]()

    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let token = userDefaults.string(forKey: "TOKEN")!
        let url = "faculties/\(userDefaults.string(forKey: "SPECIALTY")!)/educational-objectives/?token=\(token)"
        
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
                    let jsonError = try JSONSerialization.jsonObject(with: response!, options: []) as! [String:AnyObject]
                    let msgError = jsonError["message"]! as! NSString
                    
                    print(msgError)
                }
                catch {
                    print("NOT VALID JSON")
                }
            }
            else {
                let data = responseData as! [AnyObject]
                for goal in data {
                    let goalDetail = goal as! [String:AnyObject]
                    
                    let id = goalDetail["IdObjetivoEducacional"] as! Int
                    let text = goalDetail["Descripcion"] as! String
                    let number = Int(goalDetail["Numero"] as! String)
                    let status = Int(goalDetail["Estado"] as! String)
                    print("EDUCATiONAL GOAL")
                    print(id)
                    let goalStruct = EducationalGoal(id: id, name: text, number: number!, status: status!)
                    self.goalsArray.append(goalStruct!)
                }
            }
            
            LoadingOverlay.shared.hideOverlayView()
            self.overlay?.removeFromSuperview()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                return
            }
            
            
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print(goalsArray.count)
        return goalsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! CustomGoalCell
        
        cell.lblGoal.text = goalsArray[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "outcomesSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! StudentOutcomesViewController
                controller.goal = goalsArray[indexPath.row]
            }
        }
    }
}
