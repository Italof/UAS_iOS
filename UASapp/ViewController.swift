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
  

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let userDefaults = UserDefaults.standard
        let isLoggedIn = userDefaults.integer(forKey: "ISLOGGEDIN")
        if (isLoggedIn == 1) {
          self.performSegue(withIdentifier: "moduleSegue", sender: self)
        }
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
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

    }

}

