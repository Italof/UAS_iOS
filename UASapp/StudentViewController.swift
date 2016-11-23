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
    
    let userDefault = UserDefaults.standard
    @IBOutlet var lblSchedule: UILabel!
    @IBOutlet var StudentResultPicker: UIPickerView!
    @IBOutlet var AspectPicker: UIPickerView!
    @IBOutlet var progressiveBar: UIProgressView!
    @IBOutlet var tableView: UITableView!
    
    var results = ["resultado1","resultado2"]
    var aspects = ["aspecto1","aspecto2"]
    
    var codes = ["20102513","20106666","20119824"]
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var horario: String?
        var idHorario: Int
        schedule = (parent as! UASNavViewController).schedule
        horario = (schedule?.codeCourse)! + " - " + (schedule?.course)!
        horario =  horario! + " - Horario: " + (schedule?.code)!
        lblSchedule.text = horario
        progressiveBar.progress = 0.15
        idHorario = (schedule?.id)!
        
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("token = " + token)
        HTTPHelper.get(route: "faculties/schedule/"+String(idHorario) + "/students" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayStudents = dataUnwrapped as? [Any]
                self.students = []
                for student in arrayStudents!{
                    let st = student as! [String:AnyObject]
                    let id = st["IdAlumno"] as! Int
                    let schedule = st["IdHorario"] as! String
                    let name = st["Nombre"] as! String
                    let apePat = st["ApellidoPaterno"] as! String
                    let apeMat = st["ApellidoMaterno"] as! String
                    let code = st["Codigo"] as! String
                    
                    let student : Student = Student.init(id:id, name:name, apePaterno: apePat, apeMaterno: apeMat, schedule: schedule, code: code)
                    self.students.append(student)
                    self.do_table_refresh()
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })

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
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomStudentCell
        cell.lblCode.text=codes[indexPath.row]
        cell.lblStudentName.text=students[indexPath.row].name! + " " + students[indexPath.row].apePaterno! + " " + students[indexPath.row].apeMaterno!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row] as Student
        ((parent as! UASNavViewController).student) = student
        userDefault.set(student.id, forKey: "STUDENT")
    }
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
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
