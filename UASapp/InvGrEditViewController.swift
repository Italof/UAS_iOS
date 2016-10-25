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
    @IBOutlet weak var nameInvGroup: UITextField!
    @IBOutlet weak var descriptionInvGroup: UITextView!
    @IBOutlet weak var saveInvGroup: UIBarButtonItem!
    @IBAction func pressedSaveInvGroup(_ sender: UIBarButtonItem) {
        print("hola")
        let alert : UIAlertController = UIAlertController.init(title: "Guardado", message: "Los cambios han sido guardados", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true, completion:nil)
    }
    @IBOutlet weak var specialityInvGroup: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        invGr = (parent as! InvNavViewController).invGr
        nameInvGroup.text = invGr?.name?.uppercased()
        descriptionInvGroup.text = invGr?.description
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
