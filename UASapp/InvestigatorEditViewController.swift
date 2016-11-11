//
//  InvestigatorEditViewController.swift
//  UASapp
//
//  Created by inf227al on 2/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvestigatorEditViewController: UIViewController, UITextFieldDelegate {

    var inv : Investigator?
    
    @IBOutlet var nameInv: UITextField!
    @IBOutlet var lastNamePInv: UITextField!
    @IBOutlet var lastNameMInv: UITextField!
    @IBOutlet var emailInv: UITextField!
    @IBOutlet var cellphoneInv: UITextField!
    @IBOutlet var invSaveButton: UIBarButtonItem!
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"

    @IBOutlet var scrollView: UIScrollView!

    var activeField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        inv = ((parent as! InvNavViewController).inv)
        nameInv.text = inv?.name
        lastNameMInv.text = inv?.lastNameM
        lastNamePInv.text = inv?.lastNameP
        emailInv.text = inv?.email
        cellphoneInv.text = inv?.cellphone
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        let id = (parent as! InvNavViewController).id
        invSaveButton.isEnabled = false
        if( profilePermited.index( of: profile) != nil || isConnected != false || inv?.idUser == id){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invSaveButton.isEnabled = true
        }
        self.nameInv.delegate = self
        self.lastNameMInv.delegate = self
        self.lastNamePInv.delegate = self
        self.emailInv.delegate = self
        self.cellphoneInv.delegate = self
        
      }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let lCurrentWidth = self.view.frame.size.width;
        let lCurrentHeight = self.view.frame.size.height;
        scrollView.contentSize=CGSize(width : lCurrentWidth, height : lCurrentHeight)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InvestigatorEditViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedSaveButton(_ sender: AnyObject) {
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
        else{
        if (nameInv.text == inv?.name && lastNameMInv.text == inv?.lastNameM && lastNamePInv.text == inv?.lastNameP && emailInv.text == inv?.email && cellphoneInv.text == inv?.cellphone){
            errorMessageCustom = "No hay cambios"
            error = 1
        }
        else if((nameInv!.text?.characters.count)! > 254 || (nameInv!.text?.characters.count)! < 1){
            errorMessageCustom = "Nombre muy largo"
            error = 1
        }
        else if((lastNamePInv!.text?.characters.count)! > 254 || (lastNamePInv!.text?.characters.count)! < 1 ){
            errorMessageCustom = "Apellido no válido"
            error = 1
        }
        else if((lastNameMInv!.text?.characters.count)! > 254 || (lastNameMInv!.text?.characters.count)! < 1){
            errorMessageCustom = "Apellido no válido"
            error = 1
        }
        else if((emailInv!.text?.characters.count)! > 100 || (emailInv!.text?.characters.count)! < 3 ){
            errorMessageCustom = "Correo no válido"
            error = 1
        }
        else if((cellphoneInv!.text?.characters.count)! != 9){
            errorMessageCustom = "Número de celular no válido"
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
                json.setValue(self.inv?.id, forKey: "id")
                json.setValue(self.nameInv.text, forKey: "nombre")
                json.setValue(self.lastNamePInv.text , forKey: "ape_paterno")
                json.setValue(self.lastNameMInv.text , forKey: "ape_materno")
                json.setValue(self.emailInv.text , forKey: "correo")
                json.setValue(self.cellphoneInv.text , forKey: "celular")
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    print(jsonData)
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(decoded)
                    let postData = decoded as! [String:AnyObject]
                    print(postData)
                    let token = (self.parent as! InvNavViewController).token
                    let get = (self.parent as! InvNavViewController).editInvestigators
                    let parser = self.inv?.id
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
                            
                            self.inv?.name = self.nameInv.text
                            self.inv?.lastNameP = self.lastNamePInv.text
                            self.inv?.lastNameM = self.lastNameMInv.text
                            self.inv?.email = self.emailInv.text
                            self.inv?.cellphone = self.cellphoneInv.text
                            ((self.parent as! InvNavViewController).inv) = self.inv
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
                catch{
                    
                }
            }))
            
            uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
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
