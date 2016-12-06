//
//  SpecialtyViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class SpecialtyViewController: UIViewController {
    var faculty : Faculty?

    @IBOutlet var lblEspec: UILabel!
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var lblCoord: UILabel!
    @IBOutlet var lblDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        faculty = (parent as! UASNavViewController).faculty
        lblEspec.text = faculty?.name
        lblCode.text = faculty?.code
        lblCoord.text = faculty?.coordinator
        lblDesc.text = faculty?.description
        
        lblEspec.sizeToFit()
        lblDesc.sizeToFit()
        lblCoord.sizeToFit()
        
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
