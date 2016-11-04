//
//  StudentOutcomesViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit


class StudentOutcomesViewController: UITableViewController {
    var goal : EducationalGoal?
    
    var outcomesArray = [StudentOutcome]()
    
    let outcomes = ["A - Aplicar los conocimientos relacionados con las matemáticas, ciencias e ingenieria",
                    "B - Diseñar y conducir experimentos, y analizar e interpretar datos",
                    "C - Diseñar sistemas, componentes o procesos que satisfagan las necesidades presentadas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = "faculties/"
//        HTTPHelper.get(route: url, authenticated: true, completion: { (error, responseData) in
//            if error != nil {
//                print("REQUESTED ERROR: \(error)")
//                let responseError = error?.userInfo[NSLocalizedDescriptionKey] as! NSString
//                let response = responseError.data(using: String.Encoding.utf8.rawValue)
//                print(response!)
//                do {
//                    let jsonError = try JSONSerialization.jsonObject(with: response!, options: []) as! [String:NSString]
//                    let msgError = jsonError["message"]! as NSString
//                    
//                    print(msgError)
//                }
//                catch {
//                    print("NOT VALID JSON")
//                }
//            }
//            else {
//                print("REQUESTED RESPONSE: \(responseData!)")
//                let data = responseData as! [String:AnyObject]
//            }
//            
//        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cellsArray.count
        return outcomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = Bundle.main.loadNibNamed("labelCell", owner: self, options: nil)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "outcomeCell", for: indexPath) as! CustomOutcomeCell
        cell.lblOutcome.text = outcomes[indexPath.row]
        return cell
    }

}
