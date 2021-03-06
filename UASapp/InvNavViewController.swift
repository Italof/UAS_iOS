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
    //variables offline
    var jsonGroups: Any?
    var jsonProjects: Any?
    var jsonEvents: Any?
    var jsonInves: Any?
    var jsonDer:Any?
    var jsonDoc:Any?
    
    
    //variables que se usan en las pantallas que usan este navegador
    //Perfiles permitidos en edición en este modulo
    var profilePermited : [Int] = [3]

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
    //Documento elegido
    var invDoc: InvestigationDocument?

    //token que se usa para el consumo del api
  
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    //profile de usuario 
    var profile: Int = Int(UserDefaults.standard.object(forKey: "ROLE") as! String)!
    //id de usuario
    var idUser : Int = UserDefaults.standard.integer(forKey: "USER_ID")
    var id : Int = -1
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
    var getDerivables: String = "deliverables"
    var editDerivables: String = "deliverable"
    //obtener  documentos
    var getDocuments: String = "versions"
    var getResponsibles: String = "deliverable"
    //registrar observaciones
    var registerObs:  String = "observation"
    override func viewDidLoad() {
        super.viewDidLoad()
        let role = UserDefaults.standard.integer(forKey: "ROLE")
        if(role == 2 || role == 1){
            id = UserDefaults.standard.object(forKey: "DOCENTE_ID") as! Int
        }
            
        //self.navigationController?.navigationBar.topItem?.title = "Atrás";
        /*
        UserDefaults.standard.set(nil, forKey: "GROUPS")
        jsonGroups = UserDefaults.standard.object(forKey: "GROUPS")
        UserDefaults.standard.set(nil, forKey: "PROJECTS")
        jsonProjects = UserDefaults.standard.object(forKey: "PROJECTS")
        UserDefaults.standard.set(nil, forKey: "EVENTS")
        jsonEvents = UserDefaults.standard.object(forKey: "EVENTS")
        UserDefaults.standard.set(nil, forKey: "INVESTIGATORS")
        jsonInves =  UserDefaults.standard.object(forKey: "INVESTIGATORS")
        UserDefaults.standard.set(nil, forKey: "DERIVABLES")
        jsonDer = UserDefaults.standard.object(forKey: "DERIVABLES")
        UserDefaults.standard.set(nil, forKey: "DOCUMENTS")
        jsonDoc = UserDefaults.standard.object(forKey: "DOCUMENTS")
        */
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
