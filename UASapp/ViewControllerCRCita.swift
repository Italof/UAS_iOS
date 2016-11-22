//
//  ViewControllerCRCita.swift
//  UASapp
//
//  Created by inf227al on 16/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerCRCita: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var motivos : [tema] = []
    
    var motivoSel: Int = 0

    @IBOutlet var pickerViewMotivos: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        let temaX1: tema = tema.init(id: -1, nombre: "Seleccione")
        self.motivos.append(temaX1)
        
        
        //Esta ruta debe ser de Motivos de cancelacion o rechazo
        HTTPHelper.get(route: "getTopics" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                
                for c in tjd {
                    
                    var idTema: Int?
                    var nombreTema: String?
                    
                    idTema = c["id"] as! Int?
                    nombreTema = c["nombre"] as! String?
                    
                    
                    
                    let temaO: tema = tema.init(id: idTema, nombre: nombreTema)
                    
                    self.motivos.append(temaO)
                }
                
                self.pickerViewMotivos.reloadAllComponents()
            }
        })
        
        pickerViewMotivos.delegate=self
        pickerViewMotivos.dataSource=self
        

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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return motivos[row].nombre
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return motivos.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        motivoSel = row
        
    }
    @IBAction func CancelarRechazarCita(_ sender: AnyObject) {
        
        if (motivoSel == 0){
            let errorAlert = UIAlertController(title: "Error al cancelar/rechazar cita!", message: "Seleccione un motivo", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        //Invocar el api para cancelar o rechazar cita
    }

}
