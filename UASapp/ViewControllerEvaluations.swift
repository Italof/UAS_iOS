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

    override func viewDidLoad() {
        super.viewDidLoad()
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        HTTPHelper.get(route: "getAppointmentList?token=" + token, authenticated: true, completion:{ (error,data) in
            
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
                    let evEstado: String?
                    let evVigenciaI: Date?
                    var evVigenciaF: Date?
                    
                    
                    
                    evId = c["id"] as! Int?
                    evNombre = c["nombre"] as! String?
                    evAvance = c["avance"] as! String?
                    evEstado = c["estado"] as! String?
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "yyyy-MM-dd" // HH:mm:ss"
                    
                    
                    evVigenciaI = dateFormater.date(from: (c["fecha_inicio"] as! String))
                    evVigenciaF = dateFormater.date(from: (c["fecha_fin"] as! String))
               
                    
                    
                    
                    let evaO: evaluation = evaluation.init(nombre: evNombre, id: evId, avance: evAvance, estado: evEstado, vigenciaI: evVigenciaI, vigenciaF: evVigenciaF)
                    cS.append(evaO)
                    
                }
                
                /*
                cS.reverse()
                
                
                ((self.parent as! NavigationControllerC).citasOb) = cS
                
                DispatchQueue.main.async {
                    self.loadData()
                    self.Dates.reloadData()
                    return
                }
                */
                
            }   else {
                print("error,NO HAY NADA ACA")
            }
            
        })

        let evax: evaluation = evaluation.init(nombre: "nom", id: 2, avance: "12/12", estado: "bien", vigenciaI: Date.init(), vigenciaF: Date.init())
        
        evaluacionesA.append(evax)
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
        
        //let citEsc = (citS?[indexPath.row])! as cita
        
        
        
        //((self.parent as! NavigationControllerC).citEsc) = citEsc
        
        
        //self.performSegue(withIdentifier: "SegueVerCita", sender: self)
        
    }
}
