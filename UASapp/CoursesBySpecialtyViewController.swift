//
//  CoursesBySpecialtyViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CoursesBySpecialtyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //cambiar esTO POR UN COMBOBOX QUE SELECCIONE
    var cycles = ["Nivel 1", "Nivel 9", "Nivel 8"]
    var courses = ["Desarrollo de programas 2","Proyecto de tesis 2","Desarrollo de programas 1", "PEI","AFI","SW","Redes"]
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomSpecialtyCell
        cell.lblCycle.text=courses[indexPath.row]
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

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
    var index=1
}
