//
//  CoursesBySpecialtyViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CoursesBySpecialtyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var courses: [Course] = []
    var coursesTotal: [Course] = []
    var pickerSelected: String?
    var levels : [String] = []
    var overlay: UIView?
    let userDefault = UserDefaults.standard
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var LevelPicker: UIPickerView!
    
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
        let facultyId: Int =  UserDefaults.standard.object( forKey: "SPECIALTY") as! Int
        var firstLevel = ""
        let semesterId: Int = UserDefaults.standard.object(forKey: "SEMESTER") as! Int
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
        HTTPHelper.get(route: "faculties/"+String(facultyId)+"/semester/"+String(semesterId)+"/courses" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayCourses = dataUnwrapped as? [Any]
                self.coursesTotal = []
                var primero = true
                for course in arrayCourses!{
                    let cr = course as! [String:AnyObject]
                    let id = cr["IdCurso"] as! Int
                    let idEsp = cr["IdEspecialidad"] as! String
                    let academicLevel = cr["NivelAcademico"] as! String
                    let code = cr["Codigo"] as! String
                    let name = cr["Nombre"] as! String
                    let course : Course = Course.init(id: id,idEspecialidad:idEsp, name: name,code:code,nivAcademico:academicLevel )
                    self.coursesTotal.append(course)
                    
                    //Condicion para concatenar los profes con "&"
                    if (primero){
                        firstLevel = academicLevel
                        primero = false
                    }
                    
                    //Para el picker del  nivel academico
                    if(!self.levels.contains(academicLevel)){
                        self.levels.append(academicLevel)
                        self.do_picker_refresh()
                    }
                    
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
            
            LoadingOverlay.shared.hideOverlayView()
            self.overlay?.removeFromSuperview()
            self.do_table_refresh(nivel: firstLevel)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levels[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if( !(levels.isEmpty) ){
            let nivel = levels[row] as String
            do_table_refresh(nivel: nivel)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func do_picker_refresh()
    {
        self.LevelPicker.reloadAllComponents()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courses.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomSpecialtyCell
        let course = courses[indexPath.row] as Course
        cell.lblCycle.text=course.code!+" "+course.name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row] as Course
        ((parent as! UASNavViewController).course) = course
        userDefault.set(course.id, forKey: "COURSE")
        
    }
    
    func do_table_refresh(nivel : String)
    {
        if(coursesTotal.isEmpty){
            let errorAlert = UIAlertController(title: "Sin resultados",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "No se han encontrado cursos registrados para el semestre"
            self.present(errorAlert, animated: true, completion: nil)
        }
        else{
            self.courses = []
            if (nivel != ""){
                for curso in coursesTotal{
                    if(curso.nivAcademico == nivel){
                        courses.append(curso)
                    }
                    
                }
            }
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

    var index=1
}
