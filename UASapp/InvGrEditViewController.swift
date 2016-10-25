//
//  InvGrEditViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvGrEditViewController: UIViewController {
    var invGr : InvestigationGroup?
    //variables de campos
    @IBOutlet weak var nameInvGroup: UITextField!
    @IBOutlet weak var descriptionInvGroup: UITextView!
    @IBOutlet weak var saveInvGroup: UIBarButtonItem!
    @IBOutlet weak var specialityInvGroup: UIPickerView!
    
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    //Presiona boton guardar
    @IBAction func pressedSaveInvGroup(_ sender: UIBarButtonItem) {
        print("hola")
        //alerta de guardado
        let alert : UIAlertController = UIAlertController.init(title: successTitle, message: successMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        //error variable
        var errorMessageCustom : String = ""
        //verificar que los campos son correctos
        print ((nameInvGroup!.text?.characters.count)!)
        if ((nameInvGroup!.text?.characters.count)! > 6){
            errorMessageCustom = "Nombre muy largo"
            alert.message = errorMessageCustom
            alert.title = errorTitle
            //mostrar alerta
            present(alert,animated: true, completion:nil)
            return
        }
        
        //enviar a api web
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa campos a editar
        invGr = (parent as! InvNavViewController).invGr
        nameInvGroup.text = invGr?.name?.uppercased()
        descriptionInvGroup.text = invGr?.description
        
        //ver si esta online o offline
        
        
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
