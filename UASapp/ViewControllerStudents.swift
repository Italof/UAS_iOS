//
//  ViewControllerStudents.swift
//  UASapp
//
//  Created by inf227al on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerStudents: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableViewStudents: UITableView!
    
    var names = ["Juan Perez","Pedro Velez"]
    var codes = ["20101234","20102345"]
    var tutors = ["Beto Guano","Miguel Rodro"]
    var statusS = ["activo","pasivo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = self.tableViewStudents.dequeueReusableCell(withIdentifier: "cellStudent", for: indexPath) as! TableViewCellStudent
        
        cell.name.text = names[indexPath.row]
        cell.tutor.text = tutors[indexPath.row]
        cell.status.text = statusS[indexPath.row]
        cell.code.text = codes[indexPath.row]
        
        
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
