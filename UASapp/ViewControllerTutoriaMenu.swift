//
//  ViewControllerTutoriaMenu.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerTutoriaMenu: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rol : String? = UserDefaults.standard.object( forKey: "ROLTUTORIA") as? String
        
        if (rol == "T"){
            return 1
            
        }
        return 2
    }
    
    @IBAction func verAlumnos(_ sender: AnyObject) {
        /*
         ruta: "getStudents/(idUsuario)?token=(token)"
         */
        
        var cS: [alumno]=[] ///////////
        
        let alumnoO1: alumno = alumno.init(alumno: "Juan Perez", codigo: "20001234", tutor: "Miguel Guano", estado: "activo")
        cS.append(alumnoO1)
        let alumnoO2: alumno = alumno.init(alumno: "Juan Perez2", codigo: "20001235", tutor: "Miguel Guano2", estado: "pasivo")
        cS.append(alumnoO2)
        let alumnoO3: alumno = alumno.init(alumno: "Juan Perez3", codigo: "20001236", tutor: "Miguel Guano3", estado: "activo")
        cS.append(alumnoO3)
        
        /*
        let parser : Int = UserDefaults.standard.object( forKey: "SPECIALTY") as! Int
        let idEspecialidad = String.init(parser)
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID especialidad = " + idEspecialidad)
        print("token = " + token)
        HTTPHelper.get(route: "getStudents/" + idEspecialidad + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                
                
                for c in tjd {
                    
                    let alumn: String?
                    let tutor: String?
                    let estado: String?
                    let codigo: String?
                    
                    tutor = c["NombreTutor"] as! String?
                    alumn = c["NombreAlumno"] as! String?
                    codigo = c["CodigoAlumno"] as! String?
                    estado = c["Estado"] as! String?
                    
                    
                    let alumnoO: alumno = alumno.init(alumno: alumn, codigo: codigo, tutor: tutor, estado: estado)
                    
                    cS.append(alumnoO)
                    
                }
                
                
                ((self.parent as! NavigationControllerC).alumnosOb) = cS
                
                
                
                if (cS != nil) {
                    print(cS)
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                let alert : UIAlertController = UIAlertController.init(title: "No hay alumnos", message: "No se han registrado alumnos a la especialidad", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
                
            }
        })
        
        */
        
        
        ((self.parent as! NavigationControllerC).alumnosOb) = cS
        
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
