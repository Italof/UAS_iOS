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
    
    @IBOutlet var labelAlumno: UILabel!
    //Este array será alimentado por el contenido de la tabla de temas de reunion
    var alumA: [alumno] = []
    var temaA: [tema] = []
    
    var Array = ["Rendimiento académico","económico","familiar","otros"]
    
    var temaSel: Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dateR.minimumDate = Date()
        //timeR.minimumDate = Date()
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if (rol == "A"){
            labelAlumno.isHidden = true
            StudentList.isHidden = true
        }
        
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
    
 
    @IBAction func registrarCita(_ sender: AnyObject) {
        
        
        let errorAlert = UIAlertController(title: "Error al registrar cita!",
                                           message: nil,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)
        
        let json = NSMutableDictionary()
        
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy" //"yyyy-MM-dd HH:mm:ss"
        
        
 
        
        
        let  fI = dateFormater.string(from: dateR.date)
        
        //LA hora que se le pasa solo es hora y min
        
        dateFormater.dateFormat = "HH:mm"
        
        let hI = dateFormater.string(from: timeR.date)
        
        //CONCATENO EL DATE PICKER Y EL TIME PICKER PARA VERIFICAR QUE ES UNA FECHA Y HORA VALIDA
        
        let fechaYhoraS: String = fI + " " + hI + ":" + "00"
        dateFormater.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let fechayhoraD: Date = dateFormater.date(from: fechaYhoraS)!
        
        
        if ( fechayhoraD > Date.init() ) {
            
            print("Valido")
            
            json.setValue(fI, forKey: "fecha")  //Seteo la fecha
            json.setValue(hI, forKey: "hora")   //Seteo la hora
        } else {
            print("No valido")
            errorAlert.message = "Fecha y hora seleccionadas no son válidas"
            self.present(errorAlert, animated: true, completion: nil)
            return
            
        }
        
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        json.setValue(idUser, forKey: "idUser") //Seteo el idUsuario
        
        if ( temaSel != 0) {
            json.setValue(temaA[temaSel].nombre, forKey: "motivo") //Seteo el tema
        } else {
            errorAlert.message = "Seleccione un tema o motivo de cita"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
 
        
        //
        
        //
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            //print(jsonData)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            //print(decoded)
            let postData = decoded as! [String:AnyObject]
            print("Este es post data")
            print(postData)
            
            HTTPHelper.post(route: "registerStudentAppointment?token=" + token, authenticated: false, body: postData, completion: { (error, responseData) in
                if error == nil {
                    
                    
                    let alertSuccess : UIAlertController = UIAlertController.init(title: "Registro de cita exitoso", message: "Se ha registrado la cita exitosamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler:{ action in
                        let navController = self.navigationController
                        if navController != nil {
                            navController?.popViewController(animated: true)
                            
                            //Actualizar citas
                            
                        }
                        print(navController)
                    })
                    alertSuccess.addAction(action)
                    self.present(alertSuccess,animated: false, completion:nil)
                    
                    
                    self.performSegue(withIdentifier: "SegueCitasReg", sender: self)
                    
                    
                    
                    
                } else {
                    print("REQUESTED RESPONSE: \(responseData)")
                }
            })
         
            
        } catch let err as NSError{
            print("JSONObjet ERROR: \(err)")
        }
      
    }
 

}
