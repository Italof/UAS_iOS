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
    //Perfiles permitidos en edición en este modulo
    var profilePermited : [Int] = []

    //Grupo de investigacion elegido
    var invGr: InvestigationGroup?
    //Proyecto de investigacion elegido
    var invPr: InvestigationProject?
    //Evento de Proyecto de investigacion elegido
    var invPrEv: InvestigationProjectEvent?
    //Entregable elegido
    var invDer: InvestigationDerivable?
    //Investigador elegido
    //var inv: Investigator?

    //token que se usa para el consumo del api
    var token: String = UserDefaults.standart().objects(forkey: "TOKEN")
    //profile de usuario 
    var profile: int = UserDefaults.standart().objects(forkey: "PROFILE")

    //rutas que se usarán en el consumo de los apis
    //obtener y editar grupos de investigación
    var getGroups: String = "getAllInvGroups"
    var editGroups: String = ""
    //obtener y editar proyectos de investigacion
    var getProjects: String = "getAllProjects"
    var editProjects: String = ""
    //obtener y editar eventos
    var getEvents: String = ""
    var editEvents: String = ""
    //obtener y editar investigadores
    var getInvestigators: String = ""
    var editInvestigators: String = ""
    //obtener y editar entregables
    var getDerivables: String = ""
    var editDerivables: String = ""


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
