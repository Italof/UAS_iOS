//
//  InvPrEvDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEvDetailViewController: UIViewController {

    var invPrEv : InvestigationProjectEvent?
    
    @IBOutlet weak var nameInvProEvent: UILabel!
    
    
    
    @IBOutlet weak var dateInvProEvent: UILabel!
    
    @IBOutlet weak var timeInvProEvent: UILabel!
    
    @IBOutlet weak var placeInvProEvent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invPrEv = (parent as! InvNavViewController).invPrEv
        nameInvProEvent.text = invPrEv?.name?.uppercased()
        dateInvProEvent.text = invPrEv?.date
        timeInvProEvent.text = invPrEv?.time
        placeInvProEvent.text = invPrEv?.place
        
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
