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
        //verificar que los campos son correctos
        
        //enviar a api web
        
        //alerta de guardado
        print("hola")
        let alert : UIAlertController = UIAlertController.init(title: "Guardado", message: "Los cambios han sido guardados", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
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
