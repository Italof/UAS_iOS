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
    //varialbles de alert de sistema
    let successTitle :  String = "Guardado"
    let successMessage: String = "Los cambios han sido guardados"
    let errorTitle: String = "Error"
    let errorMessage: String = "No se han guardado los cambios"
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializa campos a editar
        invPrEv = (parent as! InvNavViewController).invPrEv
        nameInvPrEvent.text = invPrEv?.name?.uppercased()
        
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
            alert.message = errorMessageCustom
            present(alert,animated: true, completion:nil)
        }
        else{
            //Gruadar en servidor
            
            
        }
        present(alert,animated: true, completion:nil)
        
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
