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
    
    var temaSel: Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateR.minimumDate = Date()
        timeR.minimumDate = Date()
        
        /*
         ruta: "getStudentsOfTutor/(idUsuario)?token=(token)"
         */
        
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUsuario = String.init(parser)
        /*
        let rolTutoria : Int = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! Int
        print(rolTutoria)
        
        if ( rolTutoria == 1){
            
        }
        */
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID especialidad = " + idUsuario)
        print("token = " + token)
        
        /*
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
        
        */
        
        let temaX1: tema = tema.init(id: -1, nombre: "Seleccione")
        
        self.temaA.append(temaX1)
        
        
        HTTPHelper.get(route: "getTopics" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                
                for c in tjd {
                    
                    var idTema: Int?
                    var nombreTema: String?
                    
                    idTema = c["id"] as! Int?
                    nombreTema = c["nombre"] as! String?
                    
                    
                    
                    let temaO: tema = tema.init(id: idTema, nombre: nombreTema)
                    
                    self.temaA.append(temaO)
                }
                
                self.DateThemesList.reloadAllComponents()
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
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temaSel = row
    }
    
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func registrarCita(_ sender: AnyObject) {
        
        
        let errorAlert = UIAlertController(title: "Error al registrar cita!",
                                           message: nil,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)
        
        
        
        let json = NSMutableDictionary()
        
        print(dateR.date)
        print(timeR.date)
        
        errorAlert.message = "Seleccione un tema o motivo de cita"
        
        return
        
        /*
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let  fI = dateFormater.date(from: (dateR.date as! String))
        
        dateFormater.dateFormat.
        dateFormater.dateFormat = "yyyy-MM-dd"
        let fechaCita = dateFormater.string(from: fI!)
        
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let  hI = dateFormater.date(from: (c["inicio"] as! String))
        dateFormater.dateFormat = "HH:mm:ss"
        
        horaI = dateFormater.string(from: hI!)
        
        json.setValue(dateR.date, forKey: "fecha")
        json.setValue(timeR.date, forKey: "hora")
        if ( temaSel != 0) {
            json.setValue(temaA[temaSel].nombre, forKey: "motivo") //nombre de tema
        } else {
            errorAlert.message = "Seleccione un tema o motivo de cita"
        }
        
        */
        
        //
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        json.setValue(idUser, forKey: "idUser") 
        //
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            print(jsonData)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print(decoded)
            let postData = decoded as! [String:AnyObject]
            print(postData)
            
            HTTPHelper.post(route: "registerStudentAppointment", authenticated: false, body: postData, completion: { (error, responseData) in
                if error != nil {
                    print("REQUESTED ERROR: \(error)")
                    let responseError = error?.userInfo[NSLocalizedDescriptionKey] as! NSString
                    let response = responseError.data(using: String.Encoding.utf8.rawValue)
                    print(response)
                    do {
                        let jsonError = try JSONSerialization.jsonObject(with: response!, options: []) as! [String:NSString]
                        let msgError = jsonError["error"]! as NSString
                        
                        if msgError.isEqual(to: "invalid_cedentials") {
                            errorAlert.message = "Credenciales invalidas, por favor intente nuevamente"
                        } else {
                            errorAlert.message = "Se produjo un error, intente nuevamente"
                        }
                        
                        self.present(errorAlert, animated: true, completion: nil)
                        
                    } catch {
                        print("NOT VALID JSON")
                    }
                    
                } else {
                    print("REQUESTED RESPONSE: \(responseData)")
                }
                
            })
            
        } catch let err as NSError{
            print("JSONObjet ERROR: \(err)")
        }
      
    }

}
