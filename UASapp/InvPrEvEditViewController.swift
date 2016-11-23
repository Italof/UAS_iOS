//
//  InvPrEvEditViewController.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEvEditViewController: UIViewController, UITextFieldDelegate {
    var invPrEv : InvestigationProjectEvent?
    //variables de campos
    @IBOutlet var nameInvPrEvent: UITextField!
    @IBOutlet var dateInvPrEvent: UIDatePicker!
    @IBOutlet var timeInvPrEvent: UIDatePicker!
    @IBOutlet var placeInvPrEvent: UITextField!
    @IBOutlet var saveEventButton: UIBarButtonItem!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    let invalidCharacters = "1234567890+-*/=!\"·$%&/()=?=¿.;:_¨Ç*^\\|@#¢∞¬¬÷“”“≠´][{}–„…œå∫∑©√Ω©.,"
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    override func viewDidLoad() {
        super.viewDidLoad()
        let today : Date = Date.init()
        //inicializa campos a editar
        invPrEv = (parent as! InvNavViewController).invPrEv
        nameInvPrEvent.text = invPrEv?.name
        let id = (parent as! InvNavViewController).id
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: (invPrEv?.date)!)
        dateFormater.dateFormat = "dd/MM/yyyy"
        dateInvPrEvent.setDate(date!, animated: false)
        self.nameInvPrEvent.delegate = self
        self.placeInvPrEvent.delegate = self
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var time = dateFormater.date(from: (invPrEv?.time)!)
        dateFormater.dateFormat = "HH:mm"
        if (time == nil){
            time = Date.init()
        }
        timeInvPrEvent.setDate(time!, animated: false)
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        saveEventButton.isEnabled = false
        if( profilePermited.index( of: profile) != nil || isConnected != false || id == invPrEv?.idLeader){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            saveEventButton.isEnabled = true
        }
        
        if(dateInvPrEvent.date <= today){
            saveEventButton.isEnabled = false
        }
        else{
            dateInvPrEvent.minimumDate = today
        }
        
        //endDateInvProject.text = dateFormater.string(from: endDate!)
        
        
        //ver si esta online o offline

        
        placeInvPrEvent.text = invPrEv?.place
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
    
    @IBAction func pressedSaveInvPrEvent(_ sender: AnyObject) {
        let alert : UIAlertController = UIAlertController.init(title: successTitle, message: successMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        //error variable
        var errorMessageCustom : String = ""
        var error = 0
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.string(from:dateInvPrEvent.date)
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dateFormater.string(from: timeInvPrEvent.date)
        //verificar que los campos son correctos
        if (AskConectivity.isInternetAvailable() == false){
            errorMessageCustom = "No conectado a internet"
            error = 1
        }
        else
        {
        if (nameInvPrEvent.text == invPrEv?.name && placeInvPrEvent.text == invPrEv?.place && date == invPrEv?.date && time == invPrEv?.time){
            errorMessageCustom = "No hay cambios"
            error = 1
        }
        else if((nameInvPrEvent!.text?.characters.count)! > 50 || (nameInvPrEvent!.text?.characters.count)! < 1){
            errorMessageCustom = "Nombre no válido"
            error = 1
        }
        else if((placeInvPrEvent!.text?.characters.count)! > 100 || (placeInvPrEvent!.text?.characters.count)! < 1){
            errorMessageCustom = "Nombre de lugar no válido"
            error = 1
        }
        else if(contains(text: nameInvPrEvent.text!, find: invalidCharacters)){
            errorMessageCustom = "Nombre no acepta números o símbolos"
            error = 1
        }
        else if(contains(text: placeInvPrEvent.text!, find: invalidCharacters)){
            errorMessageCustom = "Nombre de lugar no acepta números o símbolos"
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
                json.setValue(self.invPrEv?.id, forKey: "id")
                json.setValue(self.nameInvPrEvent.text, forKey: "nombre")
                json.setValue(self.placeInvPrEvent.text , forKey: "ubicacion")
                json.setValue(self.invPrEv?.description, forKey: "descripcion")
                let date = self.dateInvPrEvent.date
                let time = self.timeInvPrEvent.date
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd"
                json.setValue(dateFormater.string(from: date), forKey: "fecha")
                dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                json.setValue(dateFormater.string(from: time), forKey: "hora")
                
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    print(jsonData)
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(decoded)
                    let postData = decoded as! [String:AnyObject]
                    print(postData)
                    let token = (self.parent as! InvNavViewController).token
                    let get = (self.parent as! InvNavViewController).editEvents
                    let parser = self.invPrEv?.id
                    let routeApi = "investigation/" + String(parser.unsafelyUnwrapped) + "/" + get + "?token=" + token
                    self.activity.startAnimating()
                    HTTPHelper.post(route: routeApi, authenticated: true, body : postData, completion: {(error,data) in
                        DispatchQueue.main.async {
                            self.activity.stopAnimating()
                            self.activity.isHidden = true
                        }
                        if(error != nil){
                            //Mostrar error y regresar al menù principal
                            print(error)
                            alert.title = self.errorTitle
                            alert.message = self.errorMessage
                            self.present(alert,animated: true, completion:nil)
                        }
                        else {
                            //obtener data
                            self.invPrEv?.name = self.nameInvPrEvent.text
                            self.invPrEv?.place = self.placeInvPrEvent.text
                            let date = self.dateInvPrEvent.date
                            let time = self.timeInvPrEvent.date
                            let dateFormater = DateFormatter()
                            dateFormater.dateFormat = "yyyy-MM-dd"
                            self.invPrEv?.date = dateFormater.string(from: date)
                            dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            self.invPrEv?.time = dateFormater.string(from: time)
                            ((self.parent as! InvNavViewController).invPrEv) = self.invPrEv
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
