//
//  StudentViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var schedule : Schedule?
    
    @IBOutlet var lblMssgStudents: UILabel!
    let userDefault = UserDefaults.standard
    @IBOutlet var lblSchedule: UILabel!
    @IBOutlet var tableView: UITableView!
    
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
                }
                if(self.students.isEmpty){
                    self.lblMssgStudents.text = "Horario sin alumnos"
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
            self.do_table_refresh()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomStudentCell
        cell.lblCode.text=students[indexPath.row].code
        cell.lblStudentName.text=students[indexPath.row].name! + " " + students[indexPath.row].apePaterno! + " " + students[indexPath.row].apeMaterno!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row] as Student
        ((parent as! UASNavViewController).student) = student
        userDefault.set(student.id, forKey: "STUDENT")    }
    
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
