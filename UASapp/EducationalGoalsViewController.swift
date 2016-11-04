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
    var goalsArray = [String]()
    let goals = ["Conducir el análisis de procesos de negocio y necesidades de información de la organización",
                 "Dirigir las actividades del ciclo de vida del proyectos informáticos, utilizando tecnología, estadares y herramientas adecuadas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let token = userDefaults.string(forKey: "TOKEN")!
        print(token)
        let url = "faculties/\(userDefaults.string(forKey: "SPECIALTY")!)/educational-objectives/?token=\(token)"
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
                    
                    self.goalsArray.append(goalDetail["Descripcion"]! as! String)
                }
            }
            
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
        print(goalsArray.count)
        return goalsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! CustomGoalCell
        print(goalsArray[indexPath.row])
        cell.lblGoal.text = goalsArray[indexPath.row]
        
        return cell
    }
}
