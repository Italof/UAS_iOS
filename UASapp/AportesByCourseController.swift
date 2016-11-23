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
        let facultyId: Int = UserDefaults.standard.object(forKey: "SPECIALTY") as! Int
        let semesterId: Int = UserDefaults.standard.object(forKey: "SEMESTER") as! Int
        let courseId: Int = UserDefaults.standard.object(forKey: "COURSE") as! Int
        /*print("http://52.89.227.55/api/faculties/"+String(facultyId)+"/evaluated_courses/"+String(courseId)+"/semesters/" + String(semesterId) + "?token=" + token)
        let url = NSURL (string: "http://52.89.227.55/api/faculties/"+String(facultyId)+"/evaluated_courses/"+String(courseId)+"/semesters/" + /*String(semesterId)*/"1" + "?token=" + token);
        let requestObj = NSURLRequest(url: url! as URL);*/
        
        // Do any additional setup after loading the view.

        
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
                
        HTTPHelper.get(route: "faculties/course/78/2/contributions" + "?token=" + token, authenticated: true, completion:{ (error,data) in
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
        cell.textLabel?.text = "\(outcome.identifier) - \(outcome.name)"
               
        
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
