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
    var overlay: UIView?
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    let invalidCharacters = "·/()=?=_¨Ç*^\\|@#¢∞¬¬÷“”“≠´][{}–œå∫∑©√Ω©"
    let isnumber = ",+-*/=!\"·$%&/(.)=?=¿;:_¨Ç*^\\|@#¢∞¬¬÷“”“≠‚´][{}–„…œå∫∑©√Ω©abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
    @IBOutlet var invPrSaveButton: UIBarButtonItem!
    @IBOutlet var descriptionInvProject: UITextView!
    //@IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa campos a editar
        invPr = (parent as! InvNavViewController).invPr
        nameInvProject.text = invPr?.name
        let parser = invPr?.numberDerivables
        numberDerivablesInvPr.text = String(parser.unsafelyUnwrapped)
        let id = (parent as! InvNavViewController).id
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
        invPrSaveButton.isEnabled = false
        descriptionInvProject.text = invPr?.description
        if( profilePermited.index( of: profile) != nil || isConnected != false || invPr?.idLeader == id){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invPrSaveButton.isEnabled = true
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
        let numberDer = invPr?.numberDerivables
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormater.string(from: startDateInvProject.date)
        let endDate = dateFormater.string(from: endDateInvProject.date)
        //verificar que los campos son correctos
        if (AskConectivity.isInternetAvailable() == false){
            errorMessageCustom = "No conectado a internet"
            error = 1
        }
        else
        {
        if (nameInvProject.text == invPr?.name && numberDerivablesInvPr.text == String(numberDer.unsafelyUnwrapped) && startDate == invPr?.startDate && endDate == invPr?.endDate && descriptionInvProject.text == invPr?.description){
            errorMessageCustom = "No hay cambios"
            error = 1
        }
        else if((nameInvProject!.text?.characters.count)! > 50 || (nameInvProject!.text?.characters.count)! < 1){
            errorMessageCustom = "Nombre no válido"
            error = 1
        }
        else if(contains(text: descriptionInvProject.text!, find: invalidCharacters)){
            errorMessageCustom = "Descripción no acepta números o símbolos"
            error = 1
        }
        else if((descriptionInvProject!.text?.characters.count)! > 200 || (descriptionInvProject!.text?.characters.count)! < 1){
            errorMessageCustom = "Descripción no válido"
            error = 1
        }
        else if(contains(text: nameInvProject.text!, find: invalidCharacters)){
            errorMessageCustom = "Nombre no acepta números o símbolos"
            error = 1
        }
        else if(contains(text: numberDerivablesInvPr.text!, find: isnumber)){
            errorMessageCustom = "Número de entregables no válido"
            error = 1
        }
        else if((numberDerivablesInvPr!.text?.characters.count)! > 2){
            errorMessageCustom = "Número de entregables muy grande"
            error = 1
        }
        else if((numberDerivablesInvPr!.text?.characters.count)! < 1){
            errorMessageCustom = "Número de entregables vacío"
            error = 1
        }
        else if(startDateInvProject.date >= endDateInvProject.date){
            errorMessageCustom = "Fecha de fin anterior o igual a fecha de inicio"
            error = 1
        }
        else if(startDateInvProject.date <= today){
            errorMessageCustom = "Fecha de inicio igual a hoy"
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
                json.setValue(self.invPr?.id, forKey: "id")
                json.setValue(self.nameInvProject.text, forKey: "nombre")
                json.setValue(self.numberDerivablesInvPr.text , forKey: "num_entregables")
                json.setValue(self.descriptionInvProject.text, forKey: "descripcion")
                let startDate = self.startDateInvProject.date
                let endDate = self.endDateInvProject.date
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
                    let token = (self.parent as! InvNavViewController).token
                    let get = (self.parent as! InvNavViewController).editProjects
                    let parser = self.invPr?.id
                    let routeApi = "investigation/" + String(parser.unsafelyUnwrapped) + "/" + get + "?token=" + token
                    print(routeApi)
                    DispatchQueue.main.async {
                        self.overlay = UIView(frame: (self.parent?.view.frame)!)
                        self.overlay!.backgroundColor = UIColor.black
                        self.overlay!.alpha = 0.8
                        self.parent?.view.addSubview(self.overlay!)
                        LoadingOverlay.shared.showOverlay(view: self.overlay!)
                    }
                    HTTPHelper.post(route: routeApi, authenticated: true, body : postData, completion: {(error,data) in
                        DispatchQueue.main.async {
                            LoadingOverlay.shared.hideOverlayView()
                            self.overlay?.removeFromSuperview()
                        }
                        if(error != nil){
                            //Mostrar error y regresar al menù principal
                            //print(error)
                            alert.title = self.errorTitle
                            alert.message = self.errorMessage
                            self.present(alert,animated: true, completion:nil)
                        }
                        else {
                            //obtener data
                            self.invPr?.name = self.nameInvProject.text
                            self.invPr?.numberDerivables = Int (self.numberDerivablesInvPr.text!)!
                            let startDate = self.startDateInvProject.date
                            let endDate = self.endDateInvProject.date
                            self.invPr?.description = self.descriptionInvProject.text
                            let dateFormater = DateFormatter()
                            dateFormater.dateFormat = "yyyy-MM-dd"
                            self.invPr?.endDate = dateFormater.string(from: endDate)
                            self.invPr?.startDate = dateFormater.string(from: startDate)
                            ((self.parent as! InvNavViewController).invPr) = self.invPr
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
        //enviar a api web
        
        //alerta de guardado
        
    }
    
    func contains(text: String, find: String) -> Bool{
        for c in find.characters{
            if(text.contains(String(c))){
                return true
            }
        }
        return false
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
