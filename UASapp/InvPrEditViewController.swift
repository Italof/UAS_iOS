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
    @IBOutlet weak var nameInvProject: UITextField!
    @IBOutlet weak var startDateInvProject: UIDatePicker!
    
    
    @IBOutlet weak var numberDerivablesInvPr: UITextField!
    @IBOutlet weak var endDateInvProject: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invPr = (parent as! InvNavViewController).invPr
        nameInvProject.text = invPr?.name
        let parser = invPr?.numberDerivables
        numberDerivablesInvPr.text = String(parser.unsafelyUnwrapped)
               
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
