//
//  InvPrEditViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEditViewController: UIViewController, UITextFieldDelegate {
    var invPr : InvestigationProject?
     //variables de campos
    @IBOutlet var nameInvProject: UITextField!
    @IBOutlet var startDateInvProject: UIDatePicker!
    @IBOutlet var numberDerivablesInvPr: UITextField!
    @IBOutlet var endDateInvProject: UIDatePicker!
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    
    @IBOutlet var invPrSaveButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa campos a editar
        invPr = (parent as! InvNavViewController).invPr
        nameInvProject.text = invPr?.name
        let parser = invPr?.numberDerivables
        numberDerivablesInvPr.text = String(parser.unsafelyUnwrapped)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormater.date(from: (invPr?.startDate)!)
        let endDate = dateFormater.date(from: (invPr?.endDate)!)
        startDateInvProject.setDate(startDate!, animated: false)
        endDateInvProject.setDate(endDate!, animated: false)
        let today : Date = Date.init()
        startDateInvProject.minimumDate = today
        endDateInvProject.minimumDate = today
        //ver si esta online o offline
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        if( profilePermited.index( of: profile) == nil || isConnected == false ){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invPrSaveButton.isEnabled = false
        }
        self.nameInvProject.delegate = self
        self.numberDerivablesInvPr.delegate = self
        // Do any additional setup after loading the view.
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
    
    @IBAction func pressedSaveInvProject(_ sender: AnyObject) {
        let alert : UIAlertController = UIAlertController.init(title: successTitle, message: successMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        //error variable
        var errorMessageCustom : String = ""
        var error = 0
        let today : Date = Date.init()
        //verificar que los campos son correctos
        if((nameInvProject!.text?.characters.count)! > 254 || (nameInvProject!.text?.characters.count)! < 1){
            errorMessageCustom = "Nombre no válido"
            error = 1
        }
        if((numberDerivablesInvPr!.text?.characters.count)! > 2){
            errorMessageCustom = "Número de entregables muy grande"
            error = 1
        }
        if((numberDerivablesInvPr!.text?.characters.count)! < 1){
            errorMessageCustom = "Número de entregables vacío"
            error = 1
        }
        if(startDateInvProject.date >= endDateInvProject.date){
            errorMessageCustom = "Fecha de fin anterior o igual a fecha de inicio"
            error = 1
        }
        if(startDateInvProject.date <= today){
            errorMessageCustom = "Fecha de inicio igual a hoy"
            error = 1
        }
        if (error == 1){
            alert.title = errorTitle
            alert.message = errorMessageCustom
            present(alert,animated: true, completion:nil)
        }
        else{
            //Gruadar en servidor
            let json = NSMutableDictionary()
            json.setValue(invPr?.id, forKey: "id")
            json.setValue(nameInvProject.text, forKey: "nombre")
            json.setValue(numberDerivablesInvPr.text , forKey: "num_entregables")
            let startDate = startDateInvProject.date
            let endDate = endDateInvProject.date
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            json.setValue(dateFormater.string(from: startDate), forKey: "fecha_ini")
            json.setValue(dateFormater.string(from: endDate), forKey: "fecha_fin")
            //json.setValue(startDate, forKey: "fecha_ini")
            //json.setValue(endDate, forKey: "fecha_fin")
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                print(jsonData)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                print(decoded)
                let postData = decoded as! [String:AnyObject]
                print(postData)
                let token = (parent as! InvNavViewController).token
                let get = (parent as! InvNavViewController).editProjects
                let parser = invPr?.id
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
                        alert.title = self.successTitle
                        alert.message = self.successMessage
                        self.present(alert,animated: true, completion:nil)
                        self.invPr?.name = self.nameInvProject.text
                        self.invPr?.numberDerivables = Int (self.numberDerivablesInvPr.text!)!
                        let startDate = self.startDateInvProject.date
                        let endDate = self.endDateInvProject.date
                        let dateFormater = DateFormatter()
                        dateFormater.dateFormat = "yyyy-MM-dd"
                        self.invPr?.endDate = dateFormater.string(from: endDate)
                        self.invPr?.startDate = dateFormater.string(from: startDate)
                        ((self.parent as! InvNavViewController).invPr) = self.invPr
                    }
                    
                })

            }
            catch{
                
            }
            
        }
        
        //enviar a api web
        
        //alerta de guardado
        
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
