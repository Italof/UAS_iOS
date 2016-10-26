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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      
    @IBAction func login() {
        let username = txtUser.text! as NSString
        let password = txtPass.text! as NSString

        if ( username.isEqual(to: "") || password.isEqual(to: "")) {
            let alert = UIAlertController(title: "Error al Iniciar Sesión!",
                                    message: "Por favor ingrese su nombre de usuario y contraseña",
                                    preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                 style: .default,
                                 handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            let postData = "username=\(username)&password=\(password)" as NSString
            print("PostData: \(postData)")
            
            HTTPHelper.get(route: "/questions", authenticated: false, completion: {(error,data) in
                if error != nil {
                    print(error)
                } else {
                    print(data)
                }
            })
        }

    }

}

