//
//  InvDerEditViewController.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDerEditViewController: UIViewController {
    var invDer : InvestigationDerivable?
    
    @IBOutlet var saveButtonInvDoc: UIBarButtonItem!
    @IBOutlet var nameInvDoc: UITextField!
    @IBOutlet var limitDateInvDoc: UIDatePicker!
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    override func viewDidLoad() {
        super.viewDidLoad()
        let invPr = (parent as! InvNavViewController).invPr
        invDer = (parent as! InvNavViewController).invDer
        nameInvDoc.text = invDer?.name
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        let limitDate = dateformat.date(from: (invDer?.dateLimit)!)
        limitDateInvDoc.setDate(limitDate!, animated: true)
        let id = (parent as! InvNavViewController).id
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        saveButtonInvDoc.isEnabled = false
        if(profilePermited.index( of: profile) != nil || isConnected != false || invPr?.idLeader == id){
            //si no se encuentra el perfil permitido
            saveButtonInvDoc.isEnabled = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveInvDer(_ sender: AnyObject) {
        //alerta de guardado
        let alert : UIAlertController = UIAlertController.init(title: successTitle, message: successMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        //error variable
        var errorMessageCustom : String = ""
        var error = 0
        //verificar que los campos son correctos
        if (AskConectivity.isInternetAvailable() == false){
            errorMessageCustom = "No conectado a internet"
            error = 1
        }
        else
        {
            if((nameInvDoc!.text?.characters.count)! > 254 || (nameInvDoc!.text?.characters.count)! < 1){
                errorMessageCustom = "Nombre no válido"
                error = 1
            }
            if (error == 1){
                alert.title = errorTitle
                alert.message = errorMessageCustom
                present(alert,animated: true, completion:nil)
            }
            else{
                let uiAlert = UIAlertController(title: "Aviso", message: "¿Desea guardar los cambios?", preferredStyle: UIAlertControllerStyle.alert)
                uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    //Gruadar en servidor
                    let json = NSMutableDictionary()
                    json.setValue(self.invDer?.id, forKey: "id")
                    json.setValue(self.nameInvDoc.text, forKey: "nombre")
                    let dateformat = DateFormatter()
                    dateformat.dateFormat = "yyyy-MM-dd"
                    json.setValue(dateformat.string(from: (self.limitDateInvDoc?.date)!) , forKey: "descripcion")
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                        print(jsonData)
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        print(decoded)
                        let postData = decoded as! [String:AnyObject]
                        print(postData)
                        let token = (self.parent as! InvNavViewController).token
                        let get = (self.parent as! InvNavViewController).editGroups
                        let parser = self.invDer?.id
                        let routeApi = "investigation/" + String(parser.unsafelyUnwrapped) + "/" + get + "?token=" + token
                        print(routeApi)
                        HTTPHelper.post(route: routeApi, authenticated: true, body : postData, completion: {(error,data) in
                            if(error != nil){
                                //Mostrar error y regresar al menù principal
                                print(error)
                                alert.title = self.errorTitle
                                alert.message = self.errorMessage
                                self.present(alert,animated: true, completion:nil)
                            }
                            else {
                                //obtener data
                                let dateformat = DateFormatter()
                                dateformat.dateFormat = "yyyy-MM-dd"
                                self.invDer?.name = self.nameInvDoc.text
                                self.invDer?.dateLimit = dateformat.string(from: self.limitDateInvDoc.date)
                                ((self.parent as! InvNavViewController).invDer) = self.invDer
                                let alertSuccess : UIAlertController = UIAlertController.init(title: self.successTitle, message: self.successMessage, preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler:{ action in
                                    let navController = self.navigationController
                                    if navController != nil {
                                        navController?.popViewController(animated: true)
                                    }
                                    print(navController)
                                })
                                alertSuccess.addAction(action)
                                self.present(alertSuccess,animated: false, completion:nil)
                            }
                            
                        })
                    }
                    catch let err as NSError{
                        print("JSON OBJECT ERROR: \(err)")
                    }
                    
                    print("Click of default button")
                }))
                uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(uiAlert, animated: true, completion: nil)
            }
        }
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
