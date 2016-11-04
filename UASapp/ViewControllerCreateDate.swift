//
//  ViewControllerCreateDate.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerCreateDate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var DateThemesList: UIPickerView!
    
    @IBOutlet weak var StudentList: UIPickerView!
    
    @IBOutlet weak var dateR: UIDatePicker!
    @IBOutlet weak var timeR: UIDatePicker!
    
    //Este array será alimentado por el contenido de la tabla de temas de reunion
    var alumA: [alumno] = []
    var temaA: [tema] = []
    
    var Array = ["Rendimiento académico","económico","familiar","otros"]
    /*
    var PlacementAnswer =0
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
         ruta: "getStudentsOfTutor/(idUsuario)?token=(token)"
         */
        
        
        let parser : Int = UserDefaults.standard.object( forKey: "IdUsuario") as! Int
        let idUsuario = String.init(parser)
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID especialidad = " + idUsuario)
        print("token = " + token)
        HTTPHelper.get(route: "getStudentsOfTutor/" + idUsuario + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                
                for c in tjd {
                    
                    let alumn: String?
                    let codigo: String?
                    
                    alumn = c["NombreAlumno"] as! String?
                    codigo = c["CodigoAlumno"] as! String?
                    
                    
                    
                    let alumnoO: alumno = alumno.init(alumno: alumn, codigo: codigo)
                    
                    self.alumA.append(alumnoO)
                }
            }
        })
        
        
        HTTPHelper.get(route: "getTopics" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                
                for c in tjd {
                    
                    let idTema: String?
                    let nombreTema: String?
                    
                    idTema = c["Id"] as! String?
                    nombreTema = c["Nombre"] as! String?
                    
                    
                    
                    let temaO: tema = tema.init(id: idTema, nombre: nombreTema)
                    
                    self.temaA.append(temaO)
                }
            }
        })
        
        
        
        
        
        
        DateThemesList.delegate=self
        DateThemesList.dataSource=self
        
        StudentList.delegate=self
        StudentList.dataSource=self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == DateThemesList){
            return temaA[row].nombre
        }
        else {
            return alumA[row].alumno
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == DateThemesList){
            return temaA.count
        }
        else {
            return alumA.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     
    Ejemplo de utilizar la opcion escogida del pickerview
    @IBAction func Submit(sender: AnyObject){
        if (PlacementAnswer == 0){
            Label.text = "Prueba"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PlacementAnswer = row
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
