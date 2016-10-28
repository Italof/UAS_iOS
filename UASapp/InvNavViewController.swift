//
//  InvNavViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvNavViewController: UINavigationController {
    //Controlador de navegación de investigación
    
    //variables que se usan en las pantallas que usan este navegador
    //prueba
    var elegido: Int = 0
    //Grupo de investigacion elegido
    var invGr: InvestigationGroup?
    //Proyecto de investigacion elegido
    var invPr: InvestigationProject?
    //Evento de Proyecto de investigacion elegido
    var invPrEv: InvestigationProjectEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
