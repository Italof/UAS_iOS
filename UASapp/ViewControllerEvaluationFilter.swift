//
//  ViewControllerEvaluationFilter.swift
//  UASapp
//
//  Created by inf227al on 16/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerEvaluationFilter: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var pickerViewEstados: UIPickerView!
    
    var estadosEv: [String] = ["Seleccione"]
    var estadoSel: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                
                
                ((self.parent as! NavigationControllerE).evalObF) = cS
                
                DispatchQueue.main.async {
                    self.loadData()
                    self.pickerViewEstados.reloadAllComponents()
                    return
                }
                
                
            }   else {
                print("error,NO HAY NADA ACA")
            }
            
        })
        
        pickerViewEstados.delegate = self
        pickerViewEstados.dataSource = self
        // Do any additional setup after loading the view.
    }
    func loadData(){
        
        for d in ((self.parent as! NavigationControllerE).evalObF) {
            if ( estadosEv.contains(d.estado!) == false){
                estadosEv.append(d.estado!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return estadosEv[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estadosEv.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        estadoSel = row
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBAction func filtrarEv(_ sender: AnyObject) {
        let cS = ((self.parent as! NavigationControllerE).evalObF)
        var evList: [evaluation] = []
        for x in cS {
            if (nombre.text != ""){
                if (x.nombre?.range(of: nombre.text!) == nil) {        //Nombre
                    continue
                    
                }
            }
            if (estadoSel != 0){
                if ( x.estado != estadosEv[estadoSel]){     //Estados
                    continue
                }
            }
            
            evList.append(x)
        }
        ((self.parent as! NavigationControllerE).evalObF) = evList
        ((self.parent as! NavigationControllerE).filtro) = "S"
        for a in evList {
            print(a.nombre)
        }
        //self.performSegue(withIdentifier: "SegueFiltrarEvaluacion", sender: self)
        self.navigationController?.popViewController(animated: true)
    }
}
