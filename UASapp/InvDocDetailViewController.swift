//
//  InvDocDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDocDetailViewController: UIViewController {
    var invDer: InvestigationDerivable?
    var invDoc: InvestigationDocument?
    @IBOutlet weak var nameInvDoc: UILabel!
    @IBOutlet weak var dateDeliverInvDoc: UILabel!
    @IBOutlet weak var versionInvDoc: UILabel!
    @IBOutlet weak var respInvDoc: UITextView!
    @IBOutlet weak var observationInvdoc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadDocument(_ sender: AnyObject) {
        invDer = (parent as! InvNavViewController).invDer
        invDoc = (parent as! InvNavViewController).invDoc
        nameInvDoc.text = invDer?.name
        versionInvDoc.text = invDoc?.version
        observationInvdoc.text = invDoc?.observation
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let limitDate = dateFormat.date(from: (invDoc?.dateDeliver)!)
        dateFormat.dateFormat = "dd/MM/yyyy"
        dateDeliverInvDoc.text = dateFormat.string(from: limitDate!)
        
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
