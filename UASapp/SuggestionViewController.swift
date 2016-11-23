//
//  SuggestionViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/21/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    var userDefaults = UserDefaults.standard
    var impPlan : ImprovementPlan!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtComent: UITextView!
    
    let alert = UIAlertController(title: "¡Atención!", message: nil, preferredStyle: .alert)
    let saveAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            let navController = self.navigationController
            if navController != nil {
                navController!.popViewController(animated: true)
            }})
        
        alert.addAction(okAction)
        saveAlert.addAction(saveAction)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveSuggestion(_ sender: UIBarButtonItem) {
        let title = txtTitle.text! as NSString
        let coment = txtComent.text! as NSString
   
        if (title.isEqual(to: "")) {
            alert.message = "Debe ingresar un titulo para su sugerencia"
            self.present(alert, animated: true, completion: nil)
        } else if (coment.isEqual(to: "")) {
            alert.message = "Debe ingresar una sugerencia"
            self.present(alert, animated: true, completion: nil)
        } else {
            let json = NSMutableDictionary()
            json.setValue(title, forKey: "titulo")
            json.setValue(coment, forKey: "descripcion")
            json.setValue(userDefaults.integer(forKey: "DOCENTE_ID"), forKey: "idDocente")
            json.setValue(userDefaults.integer(forKey: "SPECIALTY"), forKey: "idEspecialidad")
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                let postData = decoded as! [String:AnyObject]
                
                let token = userDefaults.string(forKey: "TOKEN")!
                let impPlanId = impPlan.id
                let url = "improvementplans/\(impPlanId)/suggestions?token=\(token)"
                print (postData)
                HTTPHelper.post(route: url, authenticated: false, body: postData, completion: { (error, response) in
                    if (error != nil) {
                        print(error!)
                        self.saveAlert.title = "¡Error!"
                        self.saveAlert.message = "No se pudo guardar su sugerencia"
                        self.present(self.saveAlert, animated: true, completion: nil)
                    } else {
                        let responseData = response as! [String:AnyObject]
                        let msg = responseData["mensaje"] as! String
                        
                        self.saveAlert.title = "¡Perfecto!"
                        self.saveAlert.message = msg

                        self.present(self.saveAlert, animated: true, completion: nil)
                    }
                })
                
            } catch let err as NSError {
                print("JSONObject: ERROR: \(err)")
            }
            
            
        }
    }
}
