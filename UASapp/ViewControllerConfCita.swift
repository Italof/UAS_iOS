//
//  ViewControllerConfCita.swift
//  UASapp
//
//  Created by inf227al on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerConfCita: UIViewController {

    @IBOutlet var textLugar: UITextField!
    @IBOutlet var textInfoExtra: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmarCita(_ sender: AnyObject) {
        let errorAlert = UIAlertController(title: "Error al confirmar cita!", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)

        if (textLugar.text == ""){
            errorAlert.message = "Indique lugar de la cita"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        if ((textLugar.text?.characters.count)! > 50){
            errorAlert.message = "El lugar de la cita no debe sobrepasar los 50  caracteres"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        if (textInfoExtra.text == ""){
            errorAlert.message = "Indique información extra de la cita"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        if ((textLugar.text?.characters.count)! > 100){
            errorAlert.message = "La información extra de la cita no debe sobrepasar los 100 caracteres"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        //Invocar el api para cancelar o rechazar cita
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
