//
//  ViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 10/21/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
  
    var isLoggedIn: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let userDefaults = UserDefaults.standard
        isLoggedIn = userDefaults.integer(forKey: "ISLOGGEDIN")
        print(isLoggedIn)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (isLoggedIn == 1) {
            self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      
    @IBAction func login() {
        let username = txtUser.text! as NSString
        let password = txtPass.text! as NSString

        
        let errorAlert = UIAlertController(title: "Error al Iniciar Sesión!",
                                      message: nil,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)

        if ( username.isEqual(to: "") || password.isEqual(to: "")) {
            errorAlert.message = "Por favor ingrese su nombre de usuario y contraseña"
            present(errorAlert, animated: true, completion: nil)
        } else {
            let json = NSMutableDictionary()
            json.setValue(username, forKey: "user")
            json.setValue(password, forKey: "password")
            
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
                        print(response!)
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
                            errorAlert.message = "Error en el servidor, intente más tarde"
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                        
                    } else {
                        print("REQUESTED RESPONSE: \(responseData)")
                        let data = responseData as! [String:AnyObject]
                        let user = data["user"] as! [String:AnyObject]
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(1, forKey: "ISLOGGEDIN")
                        userDefaults.set(user["Usuario"], forKey: "USER")
                        userDefaults.set(data["token"], forKey: "TOKEN")
                        userDefaults.set(user["IdUsuario"], forKey: "USER_ID")
                        userDefaults.set(user["IdPerfil"], forKey: "ROLE")
                        
                        let role = userDefaults.integer(forKey: "ROLE")
                        var specialty = 0
                        var name, lastname, roleName, email: String?
                        // Professor
                        if  (role == 2 || role == 1) {
                            let professor = user["professor"] as! [String:AnyObject]
                            specialty = Int(professor["IdEspecialidad"] as! String)!
                            name = professor["Nombre"] as? String
                            lastname = (professor["ApellidoPaterno"] as? String)! + " " + (professor["ApellidoMaterno"] as? String)!
                            email = professor["Correo"] as? String
                            roleName = "Profesor"
                            
                            userDefaults.set(professor["IdDocente"], forKey: "DOCENTE_ID")
                            
                            let rolTuto = professor["rolTutoria"] as? String
                            userDefaults.set(rolTuto, forKey: "ROLTUTORIA")
                            let rolEvalua = professor["rolEvaluaciones"] as? String
                            userDefaults.set(rolEvalua, forKey: "ROLEVALUA")
                            let esAdmin = professor["es_adminpsp"] as? String
                            userDefaults.set(esAdmin, forKey: "ADMINPSP")
                            let esSuper = professor["es_supervisorpsp"] as? String
                            userDefaults.set(esSuper, forKey: "SUPERPSP")
                            
                            
                        }
                        // Accreditor
                        else if role == 4 {
                            let accreditor = user["accreditor"] as! [String:AnyObject]
                            specialty = Int(accreditor["IdEspecialidad"] as! String)!
                            name = accreditor["Nombre"] as? String
                            lastname = (accreditor["ApellidoPaterno"] as? String)! + " " + (accreditor["ApellidoMaterno"] as? String)!
                            roleName = "Acreditador"
                        }
                        // Investigator
                        else if role == 5 {
                            let investigator = user["investigator"] as! [String:AnyObject]
                            specialty = Int(investigator["id_especialidad"] as! String)!
                            name = investigator["nombre"] as? String
                            lastname = (investigator["ape_paterno"] as? String)! + " " + (investigator["ape_materno"] as? String)!
                            email = investigator["correo"] as? String
                            roleName = "Investigador"
                            
                            
                            userDefaults.set(investigator["id_area"], forKey: "AREA_ID")
                        }
                        
                        userDefaults.set(specialty, forKey: "SPECIALTY")
                        userDefaults.set(name, forKey: "NAME")
                        userDefaults.set(lastname, forKey: "LASTNAME")
                        userDefaults.set(roleName, forKey: "ROLE_NAME")
                        userDefaults.set(email, forKey: "EMAIL")
                        
                        self.performSegue(withIdentifier: "homeSegue", sender: self)
                    }
                    
                })
                
            } catch let err as NSError{
                print("JSONObjet ERROR: \(err)")
            }
            
            
        }

    }

}

