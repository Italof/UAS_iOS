//
//  InvGrDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvGrDetailViewController: UIViewController {
    var invGr : InvestigationGroup?
    @IBOutlet weak var titleInvGroup: UILabel!
    @IBOutlet weak var descriptionInvGroup: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print((parent as! InvNavViewController).elegido)
        invGr = (parent as! InvNavViewController).invGr
        titleInvGroup?.text = invGr?.name?.uppercased()
        descriptionInvGroup.text = invGr?.description
        print (invGr)
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
