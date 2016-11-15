//
//  ConsolidadoCoursesViewController.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ConsolidadoCoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet var CyclePicker: UIPickerView!
    @IBOutlet var LevelPicker: UIPickerView!
    
    @IBOutlet weak var tableView: UITableView!
    var courses: [Course] = []
    var cycles = ["2015-1","2015-2","2016-1","2016-2"]
    
    var levels = ["Nivel 10", "Nivel 9", "Nivel 8","Nivel 7","Nivel 6","Nivel 5","Nivel 4","Nivel 3","Nivel 2","Nivel 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        HTTPHelper.get(route: "faculties/1/semester/1/courses" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayCourses = dataUnwrapped as? [Any]
                self.courses = []
                for course in arrayCourses!{
                    let cr = course as! [String:AnyObject]
                    let id = cr["IdCurso"] as! Int
                    let idEsp = cr["IdEspecialidad"] as! String
                    let academicLevel = cr["NivelAcademico"] as! String
                    let code = cr["Codigo"] as! String
                    let name = cr["Nombre"] as! String
                    let course : Course = Course.init(id: id,idEspecialidad:idEsp, name: name,code:code,nivAcademico:academicLevel )
                    self.courses.append(course)
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
        
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomSpecialtyCell
        let course = courses[indexPath.row] as Course
        cell.lblCycle.text=course.code!+" - "+course.name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row] as Course
        ((parent as! UASNavViewController).course) = course
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
