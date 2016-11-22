//
//  ViewControllerDatesFilter.swift
//  UASapp
//
//  Created by inf227al on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerDatesFilter: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var botonFiltrar: UIBarButtonItem!
    
    @IBOutlet var labelAlumno: UILabel!
    
    @IBOutlet var textoAlumno: UITextField!
    var estadosCitasTemp: [String] = ["Seleccionar"]
    
    var citS: [cita]?
    
    @IBOutlet var fechaIF: UIDatePicker!
    @IBOutlet var fechaFF: UIDatePicker!
    var estadoSeleccionado: Int = 0
    
    @IBOutlet weak var pickerViewEstados: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if ( rol == "A"){
            labelAlumno.isHidden = true
            textoAlumno.isHidden = true
        }
        textoAlumno.text = ""
        
        //SE ELABORA EL LISTADO DE LOS ESTADOS DE LAS CITAS
        
        for d in ((self.parent as! NavigationControllerC).citasOb)! {
            if ( estadosCitasTemp.contains(d.estado!) == false){
                estadosCitasTemp.append(d.estado!)
            }
        }
        
        
        pickerViewEstados.delegate = self
        pickerViewEstados.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return estadosCitasTemp[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estadosCitasTemp.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        estadoSeleccionado = row
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBAction func filtrar(_ sender: AnyObject) {
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        
        //print("id usuario")
        //print(UserDefaults.standard.object( forKey: "USER_ID"))
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        
        let errorAlert = UIAlertController(title: "Error al filtrar citas!",
                                           message: nil,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)
        if ( fechaIF.date > fechaFF.date){
            errorAlert.message = "Rango de fechas seleccionado no es válido"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        
        if ( rol == "A") {
            
            
            HTTPHelper.get(route: "getAppointmentList/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    
                    
                    var cS: [cita] = [] ///////////
                    
                    for c in tjd {
                        //print("cita:")
                        //print(c)
                        
                        
                        let citaId: String?
                        let fechaI: String?
                        let horaI: String?
                        let tema: String?
                        var alumno: String?
                        let estado: String?
                        
                        //Nuevos campos del Json
                        //var citaId: String?
                        //var fechaI: String?
                        //var horaI: String?
                        var idTema: Int?
                        //var tema: String?
                        var lugar: String?
                        var infoExtra: String?
                        var asistio: String?
                        var observaciones: String?
                        var idEstado: Int?
                        //var estado: String?
                        var flagCreador: String?
                        var idTutor: Int?
                        var tutor: String?
                        var idAlumno: Int?
                        //var alumno: String?
                        
                        var fI: Date?
                        var hI: Date?
                        
                        let idc: Int = (c["id"] as! Int?)!
                        citaId = String(idc)
                        tema = c["nombreTema"] as! String?
                        //alumno = c["nombreAlumno"] as! String?
                        alumno = "Prueba"
                        estado = c["nombreEstado"] as! String?
                        let idTemaTemp = c["id_topic"] as! String?
                        idTema = Int(idTemaTemp!)
                        
                        if ((c["lugar"] as? String!) != nil){
                            lugar = c["lugar"] as! String?
                        } else {
                            lugar = "-"
                        }
                        /*
                         if ((tj["telefono"] as? String) != nil){
                         telefono = tj["telefono"] as! String?
                         } else {
                         telefono = "-"
                         }
                         */
                        
                        if ((c["adicional"] as? String!) != nil){
                            infoExtra = c["adicional"] as! String?
                        } else {
                            infoExtra = "-"
                        }
                        
                        
                        asistio = "-"
                        
                        if ((c["observacion"] as? String!) != nil){
                            observaciones = c["observacion"] as! String?
                        } else {
                            observaciones = "-"
                        }
                        
                        let idEstadoTemp = c["estado"] as! String?
                        idEstado = Int(idEstadoTemp!)
                        let flagCreadorTemp = c["creador"] as! String?
                        if flagCreadorTemp == "0" {
                            flagCreador = "A"
                        }
                        if flagCreadorTemp == "1" {
                            flagCreador = "T"
                        }
                        let idTutorTemp = c["id_docente"] as! String?
                        idTutor = Int(idTutorTemp!)
                        tutor = "---"
                        let idAlumnoTemp = c["id_tutstudent"] as! String?
                        idAlumno = Int(idAlumnoTemp!)
                        alumno = "----"
                        
                        let dateFormater = DateFormatter()
                        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        
                        fI = dateFormater.date(from: (c["inicio"] as! String))
                        //Verificando que la fecha de cita que se registro no es nula
                        if (fI == nil){
                            fI = Date()
                        }
                        
                        dateFormater.dateFormat = "yyyy-MM-dd"//"yyyy-MM-dd"
                        fechaI = dateFormater.string(from: fI!)
                        
                        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        hI = dateFormater.date(from: (c["inicio"] as! String))
                        
                        if (hI == nil){
                            hI = Date()
                        }
                        dateFormater.dateFormat = "HH:mm"
                        
                        horaI = dateFormater.string(from: hI!)
                        
                        let citaO: cita = cita.init(citaId: citaId, fechaI: fechaI, horaI: horaI, idTema: idTema, tema: tema, lugar: lugar, infoExtra: infoExtra, asistio: asistio, observaciones: observaciones, idEstado: idEstado, estado: estado, flagCreador: flagCreador, idTutor: idTutor, tutor: tutor, idAlumno: idAlumno, alumno: alumno)
                        cS.append(citaO)
                        
                    }
                    
                    
                    cS.reverse()
                    
                    
                    ((self.parent as! NavigationControllerC).citasOb) = cS
                    
                    
                    
                }   else {
                    print("error,NO HAY NADA ACA")
                }
                
            })
            
            
        }
        
        
        
        //Citas para el tutor getTutorAppoints
        
        if ( rol == "T"){
            
            
            HTTPHelper.get(route: "getTutorAppoints/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    
                    
                    var cS: [cita] = [] ///////////
                    
                    for c in tjd {
                        //print("cita:")
                        //print(c)
                        
                        
                        let citaId: String?
                        let fechaI: String?
                        let horaI: String?
                        let tema: String?
                        let alumno: String?
                        let estado: String?
                        
                        var fI: Date?
                        var hI: Date?
                        
                        let idc: Int = (c["id"] as! Int?)!
                        citaId = String(idc)
                        tema = c["nombreTema"] as! String?
                        alumno = c["nombreAlumno"] as! String?
                        //alumno = "Prueba"
                        estado = c["nombreEstado"] as! String?
                        
                        let dateFormater = DateFormatter()
                        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        
                        fI = dateFormater.date(from: (c["inicio"] as! String))
                        //Verificando que la fecha de cita que se registro no es nula
                        if (fI == nil){
                            fI = Date()
                        }
                        
                        dateFormater.dateFormat = "yyyy-MM-dd"//"yyyy-MM-dd"
                        fechaI = dateFormater.string(from: fI!)
                        
                        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        hI = dateFormater.date(from: (c["inicio"] as! String))
                        
                        if (hI == nil){
                            hI = Date()
                        }
                        dateFormater.dateFormat = "HH:mm"
                        
                        horaI = dateFormater.string(from: hI!)
                        
                        let citaO: cita = cita.init(citaId: citaId, fechaI: fechaI, horaI: horaI, tema: tema, alumno: alumno, estado: estado)
                        
                        cS.append(citaO)
                        
                    }
                    
                    cS.reverse()
                    
                    ((self.parent as! NavigationControllerC).citasOb) = cS
                }   else {
                    print("error,NO HAY NADA ACA")
                }
                
            })
            
            
        }
        
        //SE COMIENZA A FILTRAR LAS CITAS DE ACUERDO A LOS PARAMETROS
        
        print("Se hizo la consulta de todas las citas")
        citS = ((self.parent as! NavigationControllerC).citasOb)
        var citSFiltrado: [cita] = []
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        var fff: String
        for x in citS! {
            fff = x.fechaI!
            let dI = dateFormater.date(from: (fff))
            if ( fechaIF.date <= dI! && fechaFF.date >= dI!){                   //Fechas
                
                if (estadoSeleccionado != 0){
                    if ( x.estado != estadosCitasTemp[estadoSeleccionado]){     //Estados
                        continue
                    }
                }
                if (textoAlumno.text != "") {
                    
                    if (x.alumno?.range(of: textoAlumno.text!) == nil) {        //Alumnos
                        continue
                    }
                }
                citSFiltrado.append(x)
            }
        }
        
        
    }
}
