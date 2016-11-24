//
//  AportesByCourseController.swift
//  UASapp
//
//  Created by inf227al on 9/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class AportesByCourseController: UITableViewController {
    
    
    var studentOutcomes: [StudentOutcome] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        let semesterId: Int = UserDefaults.standard.object(forKey: "SEMESTER") as! Int
        let courseId: Int = UserDefaults.standard.object(forKey: "COURSE") as! Int
        
        // Do any additional setup after loading the view.

        
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
                
        HTTPHelper.get(route: "faculties/course/"+String(courseId)+"/"+String(semesterId)+"/contributions" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayStudentOutcomes = dataUnwrapped as? [Any]
                self.studentOutcomes = []
                for studentOutcome in arrayStudentOutcomes!{
                    let so = studentOutcome as! [String:AnyObject]
                    let id = so["IdResultadoEstudiantil"] as! Int
                    let identificador = so["Identificador"] as! String
                    let descripcion = so["Descripcion"] as! String
                    let status = Int(so["Estado"] as! String)
                    
                    let studentOutcome = StudentOutcome.init(id: id, identifier: identificador, name: descripcion, status:status!)
                    self.studentOutcomes.append(studentOutcome!)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return studentOutcomes.count
        
        //        return outcomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let outcome = studentOutcomes[indexPath.row] as StudentOutcome
        
        cell.textLabel?.font = cell.textLabel?.font.withSize(14)
        cell.textLabel?.text = "\(outcome.identifier) - \(outcome.name)"
               
        
        return cell
    }
    
    func do_table_refresh()
    {
        if(studentOutcomes.isEmpty){
            let errorAlert = UIAlertController(title: "Sin resultados",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "No se han encontrado resultados estudiantiles asociados a este horario"
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
