//
//  InvPrEvEditViewController.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEvEditViewController: UIViewController {
    var invPrEv : InvestigationProjectEvent?
    //variables de campos
    @IBOutlet weak var nameInvPrEvent: UITextField!
    @IBOutlet weak var dateInvPrEvent: UIDatePicker!
    @IBOutlet weak var timeInvPrEvent: UIDatePicker!
    @IBOutlet weak var placeInvPrEvent: UITextField!
    @IBOutlet weak var saveEventButton: UIBarButtonItem!
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
        nameInvPrEvent.text = invPrEv?.name?.uppercased()
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: (invPrEv?.date)!)
        dateFormater.dateFormat = "dd/MM/yyyy"
        dateInvPrEvent.setDate(date!, animated: false)
        
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
        if( profilePermited.index( of: profile) == nil || isConnected == false ){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            saveEventButton.isEnabled = false
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
       
        //verificar que los campos son correctos
        if((nameInvPrEvent!.text?.characters.count)! > 254){
            errorMessageCustom = "Nombre muy largo"
            error = 1
        }
        if((placeInvPrEvent!.text?.characters.count)! > 254){
            errorMessageCustom = "Nombre de lugar muy grande"
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
            json.setValue(invPrEv?.id, forKey: "id")
            json.setValue(nameInvPrEvent.text, forKey: "nombre")
            json.setValue(placeInvPrEvent.text , forKey: "ubicacion")
            json.setValue(invPrEv?.description, forKey: "descripcion")
            let date = dateInvPrEvent.date
            let time = timeInvPrEvent.date
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
                let token = (parent as! InvNavViewController).token
                let get = (parent as! InvNavViewController).editEvents
                let parser = invPrEv?.id
                let routeApi = "investigation/" + String(parser.unsafelyUnwrapped) + "/" + get + "?token=" + token
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
                    }
                    
                })
            }
            catch{
                
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
