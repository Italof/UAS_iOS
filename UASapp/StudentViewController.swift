//
//  StudentViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
    var schedule : Schedule?

    @IBOutlet var lblSchedule: UILabel!
    @IBOutlet var StudentResultPicker: UIPickerView!
    @IBOutlet var AspectPicker: UIPickerView!
    @IBOutlet var progressiveBar: UIProgressView!
    @IBOutlet var tableView: UITableView!
    
    var results = ["resultado1","resultado2"]
    var aspects = ["aspecto1","aspecto2"]
    
    var codes = ["20102513","20106666","20119824"]
    var students = ["Jorge Signol Pinto", "Jhordy Cornelio Bobadilla", "Jose Luis Sanchez"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var horario: String?
        schedule = (parent as! UASNavViewController).schedule
        horario = (schedule?.codeCourse)! + " - " + (schedule?.course)!
        horario =  horario! + " - Horario: " + (schedule?.code)!
        lblSchedule.text = horario
        progressiveBar.progress = 0.15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView==StudentResultPicker){
            return results[row]
        }
        else{
            return aspects[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView==StudentResultPicker){
            return results.count
        }
        else{
            return aspects.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomStudentCell
        cell.lblCode.text=codes[indexPath.row]
        cell.lblStudentName.text=students[indexPath.row]
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
