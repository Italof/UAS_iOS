//
//  ViewControllerEvaluations.swift
//  UASapp
//
//  Created by inf227al on 16/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerEvaluations: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewEvaluation: UITableView!
    var evaluacionesA : [evaluation] = []
    
    var evaluacionSel: Int = -1
    var overlay: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        HTTPHelper.get(route: "evaluation/getAllEvaluations?token=" + token, authenticated: true, completion:{ (error,data) in
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                var cS: [evaluation] = []
                
                for c in tjd {
                    print(c)
                    
                    let evId: Int?
                    let evNombre: String?
                    let evAvance: String?
                    var evEstado: String?
                    let evVigenciaI: Date?
                    var evVigenciaF: Date?
                    let evDescripcion: String?
                    let evTiempo: Int?
                    
                    let evCerr: Int?
                    let evAbier: Int?
                    let evArc: Int?
                    let evPP: Int?
                    
                    evId = c["id"] as! Int?
                    evNombre = c["nombre"] as! String?
                    //evAvance = c["avance"] as! String?
                    evAvance = "-"
                    let est = c["estado"] as! String?
                    if (est  == "0" ) {
                        evEstado = "cancelado"
                    }
                    if (est  == "1" ) {
                        evEstado = "creado"
                    }
                    if (est  == "2" ) {
                        evEstado = "vigente"
                    }
                    if (est  == "3" ) {
                        evEstado = "expirado"
                    }
                    
                    evDescripcion = c["descripcion"] as! String?
                    let tiem = c["tiempo"] as! String?
                    evTiempo = Int(tiem!)
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "yyyy-MM-dd" // HH:mm:ss"
                    
                    
                    evVigenciaI = dateFormater.date(from: (c["fecha_inicio"] as! String))
                    evVigenciaF = dateFormater.date(from: (c["fecha_fin"] as! String))
               
                    evPP = 20
                    evArc = 2
                    evAbier = 3
                    evCerr = 4
                    
                    let evaO: evaluation = evaluation.init(nombre: evNombre, id: evId, avance: evAvance, estado: evEstado, vigenciaI: evVigenciaI, vigenciaF: evVigenciaF, descripcion: evDescripcion, tiempo: evTiempo, numCerr: evCerr, numAbie: evAbier, numArc: evArc, puntajeTotal: evPP)
                    cS.append(evaO)
                    
                }
                
                
                cS.reverse()
                
                
                ((self.parent as! NavigationControllerE).evalOb) = cS
                
                DispatchQueue.main.async {
                    self.loadData()
                    self.tableViewEvaluation.reloadData()
                    return
                }
 
                
            }   else {
                print("error,NO HAY NADA ACA")
            }
            
        })
         */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        
        
        HTTPHelper.get(route: "evaluation/getAllEvaluations?token=" + token, authenticated: true, completion:{ (error,data) in
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                var cS: [evaluation] = []
                
                for c in tjd {
                    print(c)
                    
                    let evId: Int?
                    let evNombre: String?
                    let evAvance: String?
                    var evEstado: String?
                    let evVigenciaI: Date?
                    var evVigenciaF: Date?
                    let evDescripcion: String?
                    let evTiempo: Int?
                    
                    let evCerr: Int?
                    let evAbier: Int?
                    let evArc: Int?
                    let evPP: Int?
                    
                    evId = c["id"] as! Int?
                    evNombre = c["nombre"] as! String?
                    //evAvance = c["avance"] as! String?
                    evAvance = "-"
                    let est = c["estado"] as! String?
                    if (est  == "0" ) {
                        evEstado = "cancelado"
                    }
                    if (est  == "1" ) {
                        evEstado = "creado"
                    }
                    if (est  == "2" ) {
                        evEstado = "vigente"
                    }
                    if (est  == "3" ) {
                        evEstado = "expirado"
                    }
                    
                    evDescripcion = c["descripcion"] as! String?
                    let tiem = c["tiempo"] as! String?
                    evTiempo = Int(tiem!)
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "yyyy-MM-dd" // HH:mm:ss"
                    
                    
                    evVigenciaI = dateFormater.date(from: (c["fecha_inicio"] as! String))
                    evVigenciaF = dateFormater.date(from: (c["fecha_fin"] as! String))
                    
                    evPP = 20
                    evArc = 2
                    evAbier = 3
                    evCerr = 4
                    
                    let evaO: evaluation = evaluation.init(nombre: evNombre, id: evId, avance: evAvance, estado: evEstado, vigenciaI: evVigenciaI, vigenciaF: evVigenciaF, descripcion: evDescripcion, tiempo: evTiempo, numCerr: evCerr, numAbie: evAbier, numArc: evArc, puntajeTotal: evPP)
                    cS.append(evaO)
                    
                }
                
                
                cS.reverse()
                
                
                ((self.parent as! NavigationControllerE).evalOb) = cS
                
                DispatchQueue.main.async {
                    self.loadData()
                    self.tableViewEvaluation.reloadData()
                    return
                }
                
                
            }   else {
                print("error,NO HAY NADA ACA")
            }
            
        })
        
        
    }
    func loadData(){
        if ( ((self.parent as! NavigationControllerE).filtro) == "N"){
            self.evaluacionesA = ((self.parent as! NavigationControllerE).evalOb)
        }
        if ( ((self.parent as! NavigationControllerE).filtro) == "S"){
            self.evaluacionesA = ((self.parent as! NavigationControllerE).evalObF)
            ((self.parent as! NavigationControllerE).filtro) = "N"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.evaluacionesA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy" //"yyyy-MM-dd HH:mm:ss"
        
        
        
        let  cell = tableViewEvaluation.dequeueReusableCell(withIdentifier: "cellEv", for: indexPath) as! TableViewCellEvaluation
        
        cell.estado.text = evaluacionesA[indexPath.row].estado
        cell.nombre.text = evaluacionesA[indexPath.row].nombre
        cell.avance.text = evaluacionesA[indexPath.row].avance
        cell.vigencia.text = dateFormater.string(from: evaluacionesA[indexPath.row].vigenciaI!) + "-" + dateFormater.string(from: evaluacionesA[indexPath.row].vigenciaF!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        evaluacionSel = indexPath.row
        
        let evEsc = (evaluacionesA[indexPath.row]) as evaluation
        
        ((self.parent as! NavigationControllerE).evalEsc) = evEsc
        
        self.performSegue(withIdentifier: "SegueVerEvaluacion", sender: self)
        
    }
}
