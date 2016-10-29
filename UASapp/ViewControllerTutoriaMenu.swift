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
        HTTPHelper.get(route: "", authenticated: true, completion:{ (error,data) in
       
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tj = dataUnwrapped as! [String:AnyObject]
                let idDocente = tj["idDocente"] as! String?
                let idEspecialidad = tj["idEspecialidad"] as! String?
                let codigo = tj["codigo"] as! String?
                let nombre = tj["nombre"] as! String?
                let apellidoPaterno = tj["apellidoPaterno"] as! String?
                let apellidoMaterno = tj["apellidoMaterno"] as! String?
                let correo = tj["correo"] as! String?
                let oficina = tj["oficina"] as! String?
                let telefono = tj["telefono"] as! String?
                let anexo = tj["anexo"] as! String?
                let tutorO : tutor = tutor(idDocente: idDocente, idEspecialidad: idEspecialidad, codigo: codigo, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, correo: correo, oficina: oficina, telefono: telefono, anexo: anexo)
                ((self.parent as! NavigationControllerC).tutorOb) = tutorO
                
                print(tutorO)
            }
            else {
                //Mostrar error y regresar al menù principal
                
                
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
