//
//  InvDerDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDerDetailViewController: UIViewController {
    var invDer: InvestigationDerivable?
    @IBOutlet weak var nameInvDer: UILabel!
    @IBOutlet weak var versionInvDer: UILabel!
    @IBOutlet weak var respInvDer: UITextView!
    @IBOutlet weak var limitDateInvDer: UILabel!
    @IBOutlet weak var deliverDateInvDer: UILabel!
    @IBOutlet weak var percentageInvDer: UILabel!
    
    @IBOutlet weak var observationInvDoc: UITextView!
    
    @IBAction func downloadDocument(_ sender: AnyObject) {
       
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        invDer = (parent as! InvNavViewController).invDer
        nameInvDer.text = invDer?.name
        versionInvDer.text = "Ultima Versión"
        percentageInvDer.text = String((invDer?.percentage)!) + "%"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let limitDate = dateFormat.date(from: (invDer?.dateLimit)!)
        dateFormat.dateFormat = "dd/MM/yyyy"
        limitDateInvDer.text = dateFormat.string(from: limitDate!)
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
