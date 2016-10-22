//
//  InvGrDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvGrDetailViewController: UIViewController {
    //Controlador de la pantalla de vista de detalle de Grupo de investigacion
    
    //variable de GRupo de investigacion
    var invGr : InvestigationGroup?
    //labels donde se mostraràn la informacion del grupo
    
    @IBOutlet weak var nameInvGroup: UILabel!
    @IBOutlet weak var descriptionInvGroup: UITextView!
    @IBOutlet weak var specialityInvGroup: UILabel!
    @IBOutlet weak var leaderInvGroup: UILabel!
    @IBOutlet weak var imageInvGroup: UIImageView!
    //Boton de editar grupo, desactivar si no es lider de especialidad
    @IBOutlet weak var editInvGroup: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print((parent as! InvNavViewController).elegido)
        invGr = (parent as! InvNavViewController).invGr
        
        //se manejan los campos importantes
        nameInvGroup.text = invGr?.name?.uppercased()
        descriptionInvGroup.text = invGr?.description
        specialityInvGroup.text = invGr?.speciality
        leaderInvGroup.text = invGr?.leaderName
        //se maneja la imagen del grupo
        
        
        
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
