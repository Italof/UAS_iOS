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
        let cr = ((self.parent as! NavigationControllerC).citaCanRec)
        if (motivoSel == 0){
            var errTitle: String = " "
            if ( cr == "C"){
                errTitle = "Error al cancelar cita!"
            }
            if ( cr == "R"){
                errTitle = "Error al rechazar cita!"
            }
            let errorAlert = UIAlertController(title: errTitle, message: "Seleccione un motivo", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        let c = ((self.parent as! NavigationControllerC).citEsc)
        
        //CANCELACIÓN DE CITAS
        if ( cr == "C"){
            
            let alert : UIAlertController = UIAlertController.init(title: "Cancelar cita", message: "Esta a punto de cancelar su cita. ¿Desea continuar?", preferredStyle: .alert)
            let actionNo = UIAlertAction(title: "No", style: .destructive, handler: nil)
            let actionSi = UIAlertAction(title: "Si", style: .default, handler: { action in
                //Aca se invoca el api de cancelar cita
                
                let alert2 : UIAlertController = UIAlertController.init(title: "Cancelación de cita", message: "Se canceló la cita exitosamente", preferredStyle: .alert)
                let actionX = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert2.addAction(actionX)
                self.present(alert2,animated: true, completion:nil)
            })
            
            alert.addAction(actionNo)
            alert.addAction(actionSi)
            self.present(alert,animated: true, completion:nil)
        }
        //RECHAZO DE CITAS
        if ( cr == "R"){
            let alert : UIAlertController = UIAlertController.init(title: "Rechazar cita", message: "Esta a punto de rechazar su cita. ¿Desea continuar?", preferredStyle: .alert)
            let actionNo = UIAlertAction(title: "No", style: .destructive, handler: nil)
            let actionSi = UIAlertAction(title: "Si", style: .default, handler: { action in
                //Aca se invoca el api de rechazar cita
                
                let alert2 : UIAlertController = UIAlertController.init(title: "Rechazo de cita", message: "Se rechazó la cita exitosamente", preferredStyle: .alert)
                let actionX = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert2.addAction(actionX)
                self.present(alert2,animated: true, completion:nil)
            })
            
            alert.addAction(actionNo)
            alert.addAction(actionSi)
            self.present(alert,animated: true, completion:nil)
        }
        
        
        
        
        
        //self.navigationController?.popViewController(animated: true)
    }

}
