//
//  ListStudentViewController.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ListStudentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    var criterios = ["Comprende el impacto de la tecnología en la solución de problemas","Comprende el impacto de la tecnología en la solución de problemas","Comprende el impacto de la tecnología en la solución de problemas"]
    var grades = ["15","20","12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCriterioCell
        cell.lblCriterio.text=criterios[indexPath.row]
        cell.lblGrade.text=grades[indexPath.row]
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
