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
    var profilePermited : [Int] = [3,5]

    //Grupo de investigacion elegido
    var invGr: InvestigationGroup?
    //Proyecto de investigacion elegido
    var invPr: InvestigationProject?
    //Evento de Proyecto de investigacion elegido
    var invPrEv: InvestigationProjectEvent?
    //Entregable elegido
    var invDer: InvestigationDerivable?
    //Investigador elegido
    var inv: Investigator?

    //token que se usa para el consumo del api
  
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    //profile de usuario 
    var profile: Int = Int(UserDefaults.standard.object(forKey: "ROLE") as! String)!
    //id de usuario
    var id : Int = UserDefaults.standard.object(forKey: "USER_ID") as! Int
    //rutas que se usarán en el consumo de los apis
    //obtener y editar grupos de investigación
    var getGroups: String = "getAllInvGroups"
    var editGroups: String = "groups"
    //obtener y editar proyectos de investigacion
    var getProjects: String = "getAllProjects"
    var editProjects: String = "projects"
    //obtener y editar eventos
    var getEvents: String = "events"
    var editEvents: String = "event"
    //obtener y editar investigadores
    var getInvestigators: String = "getAllInvestigators"
    var editInvestigators: String = "investigators"
    //obtener y editar entregables
    var getDerivables: String = "deriverables"
    var editDerivables: String = "deriverable"


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Atrás";
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
