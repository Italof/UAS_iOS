//
//  CourseViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var lblCycle: UILabel!
    @IBOutlet weak var lblSpecialty: UILabel!
    @IBOutlet weak var lblProfessor: UILabel!
    @IBOutlet weak var lblCourse: UILabel!
    @IBOutlet var tableView: UITableView!
    var schedules: [Schedule] = []
    
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let course = (parent as! UASNavViewController).course
        let faculty = (parent as! UASNavViewController).faculty
        lblCycle.text = (course?.nivAcademico)!
        lblSpecialty.text = (faculty?.name)!
        lblCourse.text = (course?.code)! + " - " + (course?.name)!
        // Do any additional setup after loading the view.
        
        userDefault.set(course?.id, forKey: "COURSE")
        
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        HTTPHelper.get(route: "faculties/course/47/cycle/1" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arraySchedules = dataUnwrapped as? [Any]
                self.schedules = []
                
                for schedule in arraySchedules!{
                    let sc = schedule as! [String:AnyObject]
                    let id = sc["IdHorario"] as! Int
                    let code = sc ["Codigo"] as! String
                    //let totalAlumnos = sc["TotalAlumnos"] as! String
                    //Se va a concatenar en un solo String el profesor
                    let professorsArray = sc["professors"] as? [Any]
                    
                    var profesString: String?
                    var primero = true
                    for professor in professorsArray!{
                        let profString: String?
                        let pr = professor as! [String:AnyObject]
                        let nombreProf = pr["Nombre"] as! String
                        let apePatProf = pr["ApellidoPaterno"] as! String
                        let apeMatProf = pr["ApellidoMaterno"] as! String
                        profString = nombreProf + " " + apePatProf + " " + apeMatProf
                        
                        //Condicion para concatenar los profes con "&"
                        if (!primero){
                            profesString = profesString! + " & " + profString!
                            primero = false
                        }
                        else{
                            profesString = profString
                        }
                    }
                    let schedule : Schedule = Schedule.init(id:id, code:code, nameProf: profesString!)
                    self.schedules.append(schedule)
                    self.do_table_refresh()
                }
            }
            else {
                //Mostrar error y regresar al men˘ principal
                
            }
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
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomScheduleByCourseCell
        let schedule = schedules[indexPath.row] as Schedule
        
        cell.lblSchedule.text = schedule.code
        cell.lblTeachers.text = schedule.nameProf
        return cell
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
