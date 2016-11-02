//
//  InvPrDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrDetailViewController: UIViewController {
    var invPr : InvestigationProject?
    
    //variables de labels
    @IBOutlet weak var nameInvProject: UILabel!
    @IBOutlet weak var startDateInvProject: UILabel!
    @IBOutlet weak var endDateInvProject: UILabel!
    @IBOutlet weak var numberDerivablesInvProject: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //toma Proyecto desde controlador de navegador
        invPr = (parent as! InvNavViewController).invPr
        nameInvProject.text = invPr?.name?.uppercased()
        startDateInvProject.text = invPr?.startDate
        endDateInvProject.text = invPr?.endDate
        //parse to String from optional Int
        let parser = invPr?.numberDerivables
        numberDerivablesInvProject.text = String(parser.unsafelyUnwrapped)
        // inicializa botones -- PERMISOS
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        if( profilePermited.index( of: profile) == nil || isConnected == false ){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            //editInvGroup.hidden = true
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
