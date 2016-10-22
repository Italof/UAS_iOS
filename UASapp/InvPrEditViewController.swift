//
//  InvPrEditViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEditViewController: UIViewController {

    @IBOutlet weak var nameInvProject: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var startDateInvProject: UIDatePicker!

    @IBOutlet weak var numberDerivablesInvProject: UIPickerView!
    @IBOutlet weak var endDateInvProject: UIDatePicker!
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
