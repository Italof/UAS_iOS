//
//  ViewControllerStudentFilter.swift
//  UASapp
//
//  Created by inf227al on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerStudentFilter: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /*
    var statusS = ["Activo", "Inactivo"]
    var tutors = ["Miguel Guano","Aguilera"]
    */
    
    var statusS: [String] = []
    var tutors: [tutor] = []

    @IBOutlet var tutorP: UIPickerView!
    @IBOutlet var status: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         ruta: "getTutores/(idEspecialidad)?token=(token)"  estados de los alumnos
         */
        
        let parser : Int = UserDefaults.standard.object( forKey: "IdEspecialidad") as! Int
        let idEspecialidad = String.init(parser)
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID especialidad = " + idEspecialidad)
        print("token = " + token)
        HTTPHelper.get(route: "getTutors/" + idEspecialidad + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                for c in tjd {
                    let idDoc: String?
                    let cod: String?
                    let nom: String?
                    let apPat: String?
                    let apMat: String?
                    
                    idDoc = c["IdDocente"] as! String?
                    cod = c["Codigo"] as! String?
                    nom = c["Nombre"] as! String?
                    apPat = c["ApellidoPaterno"] as! String?
                    apMat = c["ApellidoMaterno"] as! String?
                    
                    let tutorX: tutor = tutor.init(idDocente: idDoc, codigo: cod, nombre: nom, apellidoPaterno: apPat, apellidoMaterno: apMat)
                    
                    self.tutors.append(tutorX)
                }
            }
        })
        
        /*
         ruta: "getStatusS/(idEspecialidad)?token=(token)"  estados de los alumnos
         */
        
        HTTPHelper.get(route: "getStatusS/" + idEspecialidad + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                for c in tjd {
                    let statusN: String?
                    statusN = c["estado"] as! String?
                    self.statusS.append(statusN!)
                }
            }
        })
        
        status.delegate=self
        status.dataSource=self
        tutorP.delegate=self
        tutorP.dataSource=self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == status){
        return statusS[row]
        }
        else {
            return tutors[row].nombre! + " " + tutors[row].apellidoPaterno! + " " + tutors[row].apellidoMaterno!
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == status){
            return statusS.count
        }
        else {
            return tutors.count
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    /*
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 10.0
    }
    */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
