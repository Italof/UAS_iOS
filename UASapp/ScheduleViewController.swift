//
//  ScheduleViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userDefault = UserDefaults.standard
    @IBOutlet var tableView: UITableView!
    var schedules: [Schedule] = []
    var evidences: [Evidence] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //UserDefaults.standard.object(forKey: "TOKEN") as! String
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        //let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        //let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        //print("ID user = " + idUser)
        print("token = " + token)
        HTTPHelper.get(route: "faculties/teacher/4/courses" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayCourses = dataUnwrapped as? [Any]
                self.schedules = []
                for course in arrayCourses!{
                    let cr = course as! [String:AnyObject]
                    let idEsp = cr["IdEspecialidad"] as! String
                    let course = cr["Nombre"] as! String
                    let idCurso = cr["IdCurso"] as! Int
                    let nivAcademico = cr["NivelAcademico"] as! String
                    let codeCourse = cr["Codigo"] as! String
                    let arraySchedules = cr["schedules"] as? [AnyObject]
                    for schedule in arraySchedules!{
                        let sc = schedule as! [String:AnyObject]
                        let id = sc["IdHorario"] as! Int
                        let code = sc["Codigo"] as! String
                        
                        self.evidences = []
                        let evidencesArray = sc["course_evidences"] as? [Any]
                        for evidence in evidencesArray!{
                            let ev = evidence as! [String:AnyObject]
                            let idEvidence = ev["IdEvidenciaCurso"] as! Int
                            let idArchivo = ev["IdArchivoEntrada"] as! String?
                            let idSchedule = ev["IdHorario"] as! String?
                            let fileName = ev["file_name"] as! String?
                            let fileurl = ev["file_url"] as! String?
                            
                            let evidence : Evidence = Evidence.init(id: idEvidence, name: fileName, url: fileurl, idSchedule: idSchedule, idArchivo: idArchivo)
                            self.evidences.append(evidence)
                        }

                        
                        let schedule: Schedule = Schedule.init(id:id, code:code,idEspecialidad:idEsp, course:course,codeCourse:codeCourse,idProfesor:course, nivAcademico: nivAcademico, idCurso: idCurso, evidences: self.evidences)
                        self.schedules.append(schedule)
                    }
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
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCourseCell
        
        let schedule = schedules[indexPath.row] as Schedule
        cell.lblCode.text = schedule.codeCourse
        cell.lblCourse.text = schedule.course
        cell.lblSchedule.text = schedule.code
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule = schedules[indexPath.row] as Schedule
        ((parent as! UASNavViewController).schedule) = schedule
        userDefault.set(schedule.id, forKey: "SCHEDULE")
        userDefault.set(schedule.idCurso, forKey: "COURSE")
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let period = cycles[indexPath.row] as Period
        ((parent as! UASNavViewController).period) = period
    }*/
    
    
    func do_table_refresh()
    {
        if(schedules.isEmpty){
            let errorAlert = UIAlertController(title: "Sin resultados",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "No se han encontrado horarios"
            self.present(errorAlert, animated: true, completion: nil)
        }
        else{
            self.tableView.reloadData()
        }
        
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
