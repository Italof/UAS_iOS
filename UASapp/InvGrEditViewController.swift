//
//  InvGrEditViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvGrEditViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    var invGr : InvestigationGroup?
    var specialities : [String] = ["Ingenierría Informatica","Otros"]
    //variables de campos
    @IBOutlet weak var nameInvGroup: UITextField!
    @IBOutlet weak var descriptionInvGroup: UITextView!
    @IBOutlet weak var saveInvGroup: UIBarButtonItem!
    @IBOutlet weak var specialityInvGroup: UITextField!
    
    @IBOutlet var invGroupSaveButton: UIBarButtonItem!
    
    
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    //Presiona boton guardar
    @IBAction func pressedSaveInvGroup(_ sender: UIBarButtonItem) {
        //alerta de guardado
        let alert : UIAlertController = UIAlertController.init(title: successTitle, message: successMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        //error variable
        var errorMessageCustom : String = ""
        var error = 0
        //verificar que los campos son correctos
        if((nameInvGroup!.text?.characters.count)! > 254){
            errorMessageCustom = "Nombre muy largo"
            error = 1
        }
        if((descriptionInvGroup!.text?.characters.count)! > 254){
            errorMessageCustom = "Descripción muy larga"
            error = 1
        }
        if (nameInvGroup.text == invGr?.name && descriptionInvGroup.text == invGr?.description){
            errorMessageCustom = "No hay cambios"
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
            json.setValue(invGr?.id, forKey: "id")
            json.setValue(nameInvGroup.text, forKey: "nombre")
            json.setValue(descriptionInvGroup.text , forKey: "descripcion")
            do{
              let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
              print(jsonData)
              let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
              print(decoded)
              let postData = decoded as! [String:AnyObject]
              print(postData)
              let token = (parent as! InvNavViewController).token
              let get = (parent as! InvNavViewController).editGroups
              let parser = invGr?.id
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
                  self.invGr?.name = self.nameInvGroup.text
                  self.invGr?.description = self.descriptionInvGroup.text
                  ((self.parent as! InvNavViewController).invGr) = self.invGr
                }
                
              })
            }
            catch let err as NSError{
                print("JSON OBJECT ERROR: \(err)")
            }
          
        }
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return specialities[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return specialities.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa campos a editar
        invGr = (parent as! InvNavViewController).invGr
        nameInvGroup.text = invGr?.name?.uppercased()
        descriptionInvGroup.text = invGr?.description
        specialityInvGroup.text = invGr?.speciality
        //ver si esta online o offline
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        if( profilePermited.index( of: profile) == nil || isConnected == false ){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invGroupSaveButton.isEnabled = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
