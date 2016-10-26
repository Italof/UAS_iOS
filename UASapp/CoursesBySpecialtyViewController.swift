//
//  CoursesBySpecialtyViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CoursesBySpecialtyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var cycles = ["2015-1","2015-2","2016-1","2016-2"]
    
    var levels = ["Nivel 10", "Nivel 9", "Nivel 8","Nivel 7","Nivel 6","Nivel 5","Nivel 4","Nivel 3","Nivel 2","Nivel 1"]
    var courses10 = ["Desarrollo de programas 2","Proyecto de tesis 2"]
    var courses9 = ["Desarrollo de programas 1", "PEI","AFI"]
    var courses8 = ["SW","Redes"]
    
    @IBOutlet var CyclePicker: UIPickerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var LevelPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView==CyclePicker){
            return cycles[row]
        }
        else{
            return levels[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView==CyclePicker){
            return cycles.count
        }
        else{
            return levels.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomSpecialtyCell
        cell.lblCycle.text=courses10[indexPath.row]
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

    var index=1
}
