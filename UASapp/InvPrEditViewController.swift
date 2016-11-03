//
//  InvPrEditViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEditViewController: UIViewController {
    var invPr : InvestigationProject?
     //variables de campos
    @IBOutlet weak var nameInvProject: UITextField!
    @IBOutlet weak var startDateInvProject: UIDatePicker!
    @IBOutlet weak var numberDerivablesInvPr: UITextField!
    @IBOutlet weak var endDateInvProject: UIDatePicker!
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa campos a editar
        invPr = (parent as! InvNavViewController).invPr
        nameInvProject.text = invPr?.name
        let parser = invPr?.numberDerivables
        numberDerivablesInvPr.text = String(parser.unsafelyUnwrapped)
        //ver si esta online o offline
        
        
        // Do any additional setup after loading the view.
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
        //verificar que los campos son correctos
        if((nameInvProject!.text?.characters.count)! > 254){
            errorMessageCustom = "Nombre muy largo"
            error = 1
        }
        if((numberDerivablesInvPr!.text?.characters.count)! > 3){
            errorMessageCustom = "Nùmero de entregables muy grande"
            error = 1
        }
        if(startDateInvProject.date < endDateInvProject.date){
            errorMessageCustom = "Fecha de inicio anterior a fecha de fin"
            error = 1
        }
        if (error == 1){
            alert.title = errorTitle
            alert.message = errorMessageCustom
            present(alert,animated: true, completion:nil)
        }
        else{
            //Gruadar en servidor
            let postData = ""
            print(postData)
            
            HTTPHelper.post(route: "", authenticated: true, body : [:], completion: {(error,data) in
                if(error != nil){
                    //Mostrar error y regresar al menù principal
                }
                else {
                    //obtener data
                    
                    
                }
                
            })
            
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
