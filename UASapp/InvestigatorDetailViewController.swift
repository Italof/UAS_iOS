//
//  InvestigatorDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 2/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvestigatorDetailViewController: UIViewController {
    var inv : Investigator?
    
    @IBOutlet var invEditButton: UIBarButtonItem!
    
    @IBOutlet var nameInvestigator: UILabel!
    
    @IBOutlet var lastNameInv: UILabel!
    
    @IBOutlet var emailInv: UILabel!
    
    @IBOutlet var cellphoneInv: UILabel!
    
    @IBOutlet var specialityInv: UILabel!
    
    @IBOutlet var areaInv: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        inv = ((parent! as! InvNavViewController).inv)
        let profile = (parent as! InvNavViewController).profile
        nameInvestigator.text = inv?.name
        lastNameInv.text = (inv?.lastNameP)! + " " + (inv?.lastNameM)!
        emailInv.text = inv?.email
        cellphoneInv.text = inv?.cellphone
        specialityInv.text = inv?.speciality
        areaInv.text = inv?.area
        
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        if( profilePermited.index( of: profile) == nil || isConnected == false ){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invEditButton.isEnabled = false
        }
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
