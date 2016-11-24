//
//  ViewControllerAtenderNoCita.swift
//  UASapp
//
//  Created by inf227al on 23/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerAtenderNoCita: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var PVAlumno: UIPickerView!
    @IBOutlet weak var TPHoraI: UIDatePicker!
    @IBOutlet weak var TPHoraF: UIDatePicker!
    @IBOutlet weak var PVTema: UIPickerView!
    @IBOutlet weak var TFObservaciones: UITextField!
    
    var motivos : [tema] = []
    
    var motivoSel: Int = 0
    
    var alumnos : [alumno] = []
    
    var alumnoSel: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUsuario = String.init(parser)
        
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
                
                self.PVTema.reloadAllComponents()
            }
        })
        
        let alumnoX1: alumno = alumno.init(alumno: "Seleccione", codigo: -1)
        self.alumnos.append(alumnoX1)
        
        HTTPHelper.get(route: "getAppointInformationTuto/" + idUsuario + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                //let x = tjd[0] as! [String:AnyObject]
                
                
                for c in tjd {
                    
                    let alumn: String?
                    let codigo: Int?
                    
                    alumn = c["fullName"] as! String?
                    codigo = c["id"] as! Int?
                    
                    print("Alumno de este tutor")
                    print(alumn)
                    
                    let alumnoO: alumno = alumno.init(alumno: alumn, codigo: codigo)
                    
                    self.alumnos.append(alumnoO)
                }
                
                self.PVAlumno.reloadAllComponents()
            }
        })
        
        PVTema.delegate=self
        PVTema.dataSource=self
        
        PVAlumno.delegate = self
        PVAlumno.dataSource = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == PVTema){
            return motivos[row].nombre
        } else {
            return alumnos[row].alumno
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == PVTema){
            return motivos.count
        } else {
            return alumnos.count
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == PVTema){
            motivoSel = row
        } else {
            alumnoSel = row
        }
    }
    @IBAction func atenderSinCita(_ sender: AnyObject) {
        
        
        
        
        let errorAlert = UIAlertController(title: "Error al registrar cita!",
                                           message: nil,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)
        
        let json = NSMutableDictionary()
        
        
        if ( alumnoSel == 0) {
            errorAlert.message = "Seleccione un alumno"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        if ( motivoSel == 0) {
            errorAlert.message = "Seleccione un tema o motivo de cita"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        if (TPHoraI.date > TPHoraF.date){
            errorAlert.message = "Las horas de inicio y fin de la atención no son válidas"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        /*
        this.idUser = idUser;
        this.fecha = fecha;
        this.hora = hora;
        this.tema = tema;
        this.observacion = observacion;
        this.idAlumno = idAlumno;
        this.duracionCita = duracionCita;
        */
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm" //"yyyy-MM-dd HH:mm:ss"
        
        
        let  hI = dateFormater.string(from: TPHoraI.date)
        let  hF = dateFormater.string(from: TPHoraF.date)
        //LA hora que se le pasa solo es hora y min
        
        dateFormater.dateFormat = "yyyy"//"yyyy-MM-dd"
        let anio = dateFormater.string(from: TPHoraI.date)
        dateFormater.dateFormat = "MM"//"yyyy-MM-dd"
        let mm = dateFormater.string(from: TPHoraI.date)
        dateFormater.dateFormat = "dd"//"yyyy-MM-dd"
        let dd = dateFormater.string(from: TPHoraI.date)
        let fecha = dd + "/" + mm + "/" + anio
        
        
        
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUsuario = String.init(parser)
        
        json.setValue(idUsuario, forKey: "idUser")
        json.setValue(fecha, forKey: "fecha")
        json.setValue(hI, forKey: "hora")
        //json.setValue(hF, forKey: "horaF")
        json.setValue(motivos[motivoSel].nombre, forKey: "tema")
        json.setValue(TFObservaciones.text, forKey: "observacion")
        json.setValue(alumnos[alumnoSel].codigo, forKey: "idAlumno")
        json.setValue(10, forKey: "duracionCita")
        
        print(fecha)
        print(hI)
        print(alumnos[alumnoSel].codigo)
        
        let alert : UIAlertController = UIAlertController.init(title: "Atender sin cita", message: "Esta a punto de registrar la atención sin cita. ¿Desea continuar?", preferredStyle: .alert)
        let actionNo = UIAlertAction(title: "No", style: .destructive, handler: nil)
        let actionSi = UIAlertAction(title: "Si", style: .default, handler: { action in
            //Aca se invoca el api de cancelar cita
            
            let c = ((self.parent as! NavigationControllerC).citEsc)
            
            
            let json = NSMutableDictionary()
            json.setValue(c?.citaId, forKey: "idUser")
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                //print(jsonData)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                //print(decoded)
                let postData = decoded as! [String:AnyObject]
                print("Este es post data")
                print(postData)
                let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
                
                HTTPHelper.post(route: "atenderNoCita?token=" + token, authenticated: false, body: postData, completion: { (error, responseData) in
                    if error == nil {
                        
                        let alertSuccess : UIAlertController = UIAlertController.init(title: "Atención sin cita", message: "Se registró la atención sin cita exitosamente", preferredStyle: .alert)
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
        })
        
        alert.addAction(actionNo)
        alert.addAction(actionSi)
        self.present(alert,animated: true, completion:nil)
    }

}
