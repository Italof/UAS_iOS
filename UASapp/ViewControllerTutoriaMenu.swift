//
//  ViewControllerTutoriaMenu.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerTutoriaMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func viewMyTutor(_ sender: AnyObject) {
        /*
        ruta: "getTutorInfo/Fuente.idUsuario?token=Fuente.token"
        */
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        HTTPHelper.get(route: "getTutorInfo/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
       
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                let tj = tjd[0] as! [String:AnyObject]
                print(tj)
                
                let idDocente: String?
                let idEspecialidad: String?
                let codigo: String?
                let nombre: String?
                let apellidoPaterno: String?
                let apellidoMaterno: String?
                let correo: String?
                let oficina: String?
                let telefono: String?
                let anexo: String?
                let horario: [Any]
                
                if ((tj["idDocente"]) != nil){
                    idDocente = tj["idDocente"] as! String?
                } else {
                    idDocente = "-"
                }
                
                if ((tj["idEspecialidad"]) != nil){
                    idEspecialidad = tj["idEspecialidad"] as! String?
                } else {
                    idEspecialidad = "-"
                }
                
                if ((tj["codigo"]) != nil){
                    codigo = tj["codigo"] as! String?
                } else {
                    codigo = "-"
                }
                
                if ((tj["nombre"]) != nil){
                    nombre = tj["nombre"] as! String?
                } else {
                    nombre = "-"
                }
                
                if ((tj["apellidoPaterno"]) != nil){
                    apellidoPaterno = tj["apellidoPaterno"] as! String?
                } else {
                    apellidoPaterno = "-"
                }
                
                if ((tj["apellidoMaterno"]) != nil){
                    apellidoMaterno = tj["apellidoMaterno"] as! String?
                } else {
                    apellidoMaterno = "-"
                }
                
                if ((tj["correo"]) != nil){
                    correo = tj["correo"] as! String?
                } else {
                    correo = "-"
                }
                
                if ((tj["oficina"]) != nil){
                    oficina = tj["oficina"] as! String?
                } else {
                    oficina = "-"
                }
                
                if ((tj["telefono"]) != nil){
                    telefono = tj["telefono"] as! String?
                } else {
                    telefono = "-"
                }
                
                if ((tj["anexo"]) != nil){
                    anexo = tj["anexo"] as! String?
                } else {
                    anexo = "-"
                }
                
                var horarioL: String! = "Lunes: "
                var horarioMa: String! = "Martes: "
                var horarioMi: String! = "Miercoles: "
                var horarioJ: String! = "Jueves: "
                var horarioV: String! = "Viernes: "
                
                if ((tj["scheduleInfo"]) != nil){
                    horario = tj["scheduleInfo"] as! [Any]
                    
                    
                    for diaH in horario {
                        
                        let dateFormater = DateFormatter()
                        dateFormater.dateFormat = "HH:mm:ss"
                        let diaHo = diaH as! [String:AnyObject]
                        
                        let  hI = dateFormater.date(from: (diaHo["hora_inicio"] as! String))
                        let  hF = dateFormater.date(from: (diaHo["hora_fin"] as! String))
                        
                        dateFormater.dateFormat = "HH:mm"
                        
                        if ( (diaHo["dia"] as! String) == "1") {
                            
                            horarioL = horarioL + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "2") {
                            
                            horarioMa = horarioMa + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "3") {
                            
                            horarioMi = horarioMi + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "4") {
                            
                            horarioJ = horarioJ + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "5") {
                            
                            horarioV = horarioV + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                    }
                }
                else {
                    horarioL = horarioL + "-"
                    horarioMa = horarioMa + "-"
                    horarioMi = horarioMi + "-"
                    horarioJ = horarioJ + "-"
                    horarioV = horarioV + "-"
                }
                
                
                
                
                
                
                
                
                
                    
                }
                
                
                let tutorO : tutor = tutor.init(idDocente: idDocente, idEspecialidad: idEspecialidad, codigo: codigo, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, correo: correo, oficina: oficina, telefono: telefono, anexo: anexo, horarioL: horarioL, horarioMa: horarioMa, horarioMi: horarioMi, horarioJ: horarioJ, horarioV: horarioV )
                ((self.parent as! NavigationControllerC).tutorOb) = tutorO
                
                print(tutorO)
            }
            else {
                //Mostrar error y regresar al menù principal
                let alert : UIAlertController = UIAlertController.init(title: "Sin tutor asignado", message: "Usted no cuenta con un tutor asignado", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
                
            }
    })
    
    }
    /*
    
    @IBAction func myTutor(_ sender: AnyObject) {
        
        let idAlumno: NSString
        
        let errorAlert = UIAlertController(title:"Alumno sin tutor", message: nil, preferredStyle:.alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)
        
        //Verificar si esta loggeado
        
        if (isLoggedIn == 1){
            //sacar datos de las tablas para offline
            
            
            //si no tiene tutor asignado
            
            errorAlert.message = "Alumno no tiene un tutor asignado"
            present(errorAlert, animated: true, completion: nil)
            
            
        }else{
            
            //Sacar datos del Json
            
            let json = NSMutableDictionary()
            json.setValue(idAlumno, forKey: "idAlumno")
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                print(jsonData)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                print(decoded)
                let postData = decoded as! [String:AnyObject]
                print(postData)
                
                HTTPHelper.post(route: "authenticate", authenticated: false, body: postData, completion: { (error, responseData) in
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
                        self.performSegue(withIdentifier: "moduleSegue", sender: self)
                        
                    }
                    
                })
                
            } catch let err as NSError{
                print("JSONObjet ERROR: \(err)")
            }
            
            
        }
            
            //si no tiene tutor asignado
            
            errorAlert.message = "Alumno no tiene un tutor asignado"
            present(errorAlert, animated: true, completion: nil)
        }
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
