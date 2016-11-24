//
//  ListStudentViewController.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ListStudentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //VIEW QUE MUESTRA LAS NOTAS DE CADA CRITERIO DE CADA ALUMNOXHORARIO
    
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var lblStudent: UILabel!
    @IBOutlet var tableView: UITableView!
    var criterios: [GradeCriterio] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let student = (parent as! UASNavViewController).student
        lblCode.text = student?.code
        var fullName = (student?.name)! + " " + (student?.apePaterno)!
        fullName = fullName + " " + (student?.apeMaterno)!
        lblStudent.text = fullName
        
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        let idStudent: Int =  UserDefaults.standard.object( forKey: "STUDENT") as! Int
        let idCourse: Int =  UserDefaults.standard.object( forKey: "COURSE") as! Int
        let idSchedule: Int =  UserDefaults.standard.object( forKey: "SCHEDULE") as! Int
        let idSemester: Int =  UserDefaults.standard.object( forKey: "SEMESTER") as! Int
        
        print("token = " + token)
        HTTPHelper.get(route: "faculties/effort_table/cycle/"+String(idSemester)+"/course/"+String(idCourse)+"/schedule/"+String(idSchedule)+"/student/" + String(idStudent) + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayCriterios = dataUnwrapped as? [Any]
                self.criterios = []
                for criterio in arrayCriterios!{
                    let cr = criterio as! [String:AnyObject]
                    let id = cr["IdCalificacion"] as! Int
                    let idCriterio = cr["IdCriterio"] as! Int
                    let idAlumno = cr["IdAlumno"] as! Int
                    let grade = cr["Nota"] as! Int
                    let criterion = cr["criterion"] as! [String:AnyObject]
                    let name = criterion["Nombre"] as! String
                    let idAspecto = criterion["IdAspecto"] as! Int
                    
                    let criterio : GradeCriterio = GradeCriterio.init(id:id, idCriterio: idCriterio, idAlumno: idAlumno, grade: grade, criterio: name, idAspecto: idAspecto)
                    self.criterios.append(criterio)
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
        return criterios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCriterioCell
        cell.lblCriterio.text=criterios[indexPath.row].criterio
        cell.lblGrade.text=String(criterios[indexPath.row].grade)
        return cell
    }
    
    func do_table_refresh()
    {
        if(criterios.isEmpty){
            let errorAlert = UIAlertController(title: "Sin resultados",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "No se han encontrado criterios asociados del alumno en este horario"
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
