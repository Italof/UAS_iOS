//
//  ViewControllerAtenderCita.swift
//  UASapp
//
//  Created by inf227al on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerAtenderCita: UIViewController {

    @IBOutlet var labelCodigo: UILabel!
    @IBOutlet var labelAlumno: UILabel!
    @IBOutlet var labelFecha: UILabel!
    @IBOutlet var labelHoraI: UILabel!
    @IBOutlet var labelLugar: UILabel!
    @IBOutlet var labelTema: UILabel!
    @IBOutlet var labelInfoExtra: UILabel!
    @IBOutlet var DPHoraF: UIDatePicker!
    @IBOutlet var TFObservaciones: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = ((self.parent as! NavigationControllerC).citEsc)
        labelCodigo.text = c?.citaId
        labelAlumno.text = c?.alumno
        labelFecha.text = c?.fechaI
        labelHoraI.text = c?.horaI
        labelLugar.text = c?.lugar
        labelTema.text = c?.tema
        labelInfoExtra.text = c?.infoExtra
        
        
        
        
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func atenderC(_ sender: AnyObject) {
        let c = ((self.parent as! NavigationControllerC).citEsc)
        /*
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss" //"HH:mm:ss" //"yyyy-MM-dd HH:mm:ss"
        let DiaHoraIS = (c?.fechaI)! + " " + (c?.horaI!)! + ":00"
        let  hI = dateFormater.date(from: DiaHoraIS) // hI dia y hora inicio de la cita
        print(hI)
        print(DPHoraF.date)
        dateFormater.dateFormat = "HH:mm:ss"
        let hF = dateFormater.string(from: DPHoraF.date)
        
        print(hF)
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dF = dateFormater.string(from: Date.init())
        let dhF = dF + " " + hF
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let ff = dateFormater.date(from: dhF)
        
        print("fecha escogida")
        print(ff)
        
        if (ff! < hI!){
            let errorAlert = UIAlertController(title: "Error al atender cita!", message: "Hora de finalización de atención de cita debe ser posterior a la hora de inicio", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        */
            ///Llamar al API de registro de atencion de cita
            
            let json = NSMutableDictionary()
            json.setValue(c?.citaId, forKey: "idUser")
            json.setValue(TFObservaciones.text, forKey: "fecha")
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                //print(jsonData)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                //print(decoded)
                let postData = decoded as! [String:AnyObject]
                print("Este es post data")
                print(postData)
                let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
                
                HTTPHelper.post(route: "atenderCita?token=" + token, authenticated: false, body: postData, completion: { (error, responseData) in
                    if error == nil {
                        
                        let alertSuccess : UIAlertController = UIAlertController.init(title: "Se atendió la cita!", message: "Se realizó exitosamente el regitro de atención de cita", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler:{ action in
                            self.navigationController?.popViewController(animated: true)
                            //self.performSegue(withIdentifier: "SegueCitasReg", sender: self)
                        })
                        alertSuccess.addAction(action)
                        self.present(alertSuccess,animated: false, completion:nil)
                        
                        
                        
                    } else {
                        print("REQUESTED RESPONSE: \(responseData)")
                    }
                })
                
            } catch let err as NSError{
                print("JSONObjet ERROR: \(err)")
            }
            /*
            
            let errorAlert = UIAlertController(title: "Se atendió la cita!", message: "Se realizó exitosamente el regitro de atención de cita", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            
            self.present(errorAlert, animated: true, completion: nil)
            return
            */
        
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
