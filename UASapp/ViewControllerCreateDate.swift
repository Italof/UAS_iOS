//
//  ViewControllerCreateDate.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerCreateDate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var DateThemesList: UIPickerView!
    
    @IBOutlet weak var StudentList: UIPickerView!
    
    @IBOutlet weak var dateR: UIDatePicker!
    @IBOutlet weak var timeR: UIDatePicker!
    
    @IBOutlet var labelAlumno: UILabel!
    //Este array será alimentado por el contenido de la tabla de temas de reunion
    var alumA: [alumno] = []
    var temaA: [tema] = []
    
    var Array = ["Rendimiento académico","económico","familiar","otros"]
    
    var temaSel: Int = 0
    var alumnoSel: Int = 0
    
    var horarioL: [Int] = []
    var horarioMa: [Int] = []
    var horarioMi: [Int] = []
    var horarioJ: [Int] = []
    var horarioV: [Int] = []
    var horarioS: [Int] = []
    
    var intervaloAnticipacion: Int = 1
    var intervaloDuracionCita: Int = 1
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateR.minimumDate = Date()
        //timeR.minimumDate = Date()
        
        //ACA SE CONFIGURA EL TIME PICKER CON LA DURACION DE LAS CITAS DE LA ESPECIALIDAD
        
        
        
        
        //SE DEBE JALAR DE API, PERO UN NO EXISTE GG GERARDO
        intervaloDuracionCita = 10 //minutos
        
        if (intervaloDuracionCita == 0){
            intervaloDuracionCita = 1   //Si del api viene cero, seteamos 1
        } else {
            timeR.minuteInterval = intervaloDuracionCita
        }
        //ACA SE CONFIGURA EL PLAZO MAXIMO DE TIEMPO QUE SE PUEDE RESERVAR UNA CITA CON ANTICIPACION
        
        intervaloAnticipacion = 5184000 //segundos
        
        
        dateR.maximumDate = Date(timeIntervalSinceNow: TimeInterval(intervaloAnticipacion))
        
        
        
        
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if (rol == "A"){
            labelAlumno.isHidden = true
            StudentList.isHidden = true
        }
        
     
        
        
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUsuario = String.init(parser)
        
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID especialidad = " + idUsuario)
        print("token = " + token)
        
        //getAppointInformationTuto/5?token=
        let alumnoX1: alumno = alumno.init(alumno: "Seleccione", codigo: -1)
        self.alumA.append(alumnoX1)
        
        if ( rol == "T"){
            HTTPHelper.get(route: "obtenerInformacionNoCita/" + idUsuario + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    
                    if (tjd.count != 0){
                        let tj = tjd[0] as! [String:AnyObject]
                        
                        let Ic: String?
                        let Ia: String?
                        print(tj["numberDays"])
                        if ((tj["numberDays"]) != nil){
                            Ia = (tj["numberDays"] as! String?)!
                            print(tj["numberDays"])
                            //Ia = Ia * 24 * 60 * 60
                            self.intervaloAnticipacion = Int(Ia!)! * 24 * 60 * 60
                        } else {
                            self.intervaloAnticipacion = 5184000
                        }
                        
                        if ((tj["duracionCita"]) != nil){
                            print(tj["duracionCita"])
                            Ic = (tj["duracionCita"] as! String?)!
                            self.intervaloDuracionCita = Int(Ic!)!
                        } else {
                            self.intervaloDuracionCita = 10
                        }
                        
                        self.timeR.minuteInterval = self.intervaloDuracionCita
                        self.dateR.maximumDate = Date(timeIntervalSinceNow: TimeInterval(self.intervaloAnticipacion))
                        
                        self.timeR.reloadInputViews()
                        self.dateR.reloadInputViews()
                        
                        let alu = tj["studentInfo"] as! [AnyObject]
                        if (alu.count != 0){
                            for c in alu {
                                
                                let alumn: String?
                                let codigo: Int?
                                let nom: String?
                                let apP: String?
                                let apM: String?
                                
                                nom = c["nombre"] as! String?
                                apP = c["ape_paterno"] as! String?
                                apM = c["ape_materno"] as! String?
                                alumn = apP! + " " + apM! + " " + nom!
                                codigo = c["id"] as! Int?
                                
                                print("Alumno de este tutor")
                                print(alumn)
                                
                                let alumnoO: alumno = alumno.init(alumno: alumn, codigo: codigo)
                                
                                self.alumA.append(alumnoO)
                            }
                        }
                    
                    
                    self.StudentList.reloadAllComponents()
                    } else {
                        let alert : UIAlertController = UIAlertController.init(title: "Sin alumnos asignados", message: "Usted no cuenta alumnos asignados, por lo tanto, no puede registrar citas", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "OK", style: .default, handler:{ action in
                            self.navigationController?.popViewController(animated: true)
                            //self.performSegue(withIdentifier: "SegueCitasReg", sender: self)
                        })
                        alert.addAction(action)
                        self.present(alert,animated: true, completion:nil)
                        //self.navigationController?.popViewController(animated: true)
                    }
                }
            })
            
          
        }
        
        if ( rol == "A"){
            HTTPHelper.get(route: "getTutorInfo/" + idUsuario + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    let tj = tjd[0] as! [String:AnyObject]
                    
                    let Ic: String?
                    let Ia: String?
                    print(tj["numberDays"])
                    if ((tj["numberDays"]) != nil){
                        Ia = (tj["numberDays"] as! String?)!
                        print(tj["numberDays"])
                        //Ia = Ia * 24 * 60 * 60
                        self.intervaloAnticipacion = Int(Ia!)! * 24 * 60 * 60
                    } else {
                        self.intervaloAnticipacion = 5184000
                    }
                    
                    if ((tj["duracionCita"]) != nil){
                        print(tj["duracionCita"])
                        Ic = (tj["duracionCita"] as! String?)!
                        self.intervaloDuracionCita = Int(Ic!)!
                    } else {
                        self.intervaloDuracionCita = 10
                    }
                    self.timeR.minuteInterval = self.intervaloDuracionCita
                    self.dateR.maximumDate = Date(timeIntervalSinceNow: TimeInterval(self.intervaloAnticipacion))
                    
                    self.timeR.reloadInputViews()
                    self.dateR.reloadInputViews()
                    
                }
            })
        }
 
        
        let temaX1: tema = tema.init(id: -1, nombre: "Seleccione")
        self.temaA.append(temaX1)
        
       
        
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
                    
                    self.temaA.append(temaO)
                }
                
                self.DateThemesList.reloadAllComponents()
            }
        })
        
        DispatchQueue.main.async {
            //self.loadData()
            //self.Dates.reloadData()
            if (self.intervaloDuracionCita == 0){
                self.intervaloDuracionCita = 1   //Si del api viene cero, seteamos 1
            }
            self.timeR.minuteInterval = self.intervaloDuracionCita
            
            //ACA SE CONFIGURA EL PLAZO MAXIMO DE TIEMPO QUE SE PUEDE RESERVAR UNA CITA CON ANTICIPACION
            
            //intervaloAnticipacion = 5184000 //segundos
            
            
            self.dateR.maximumDate = Date(timeIntervalSinceNow: TimeInterval(self.intervaloAnticipacion))
            
            print("Datos para registrar cita")
            
            print(self.intervaloAnticipacion)
            print(self.intervaloDuracionCita)
            
            self.timeR.reloadInputViews()
            self.dateR.reloadInputViews()
            
            self.DateThemesList.delegate=self
            self.DateThemesList.dataSource=self
            
            self.StudentList.delegate=self
            self.StudentList.dataSource=self
            
            return
        }
        /*
        if (intervaloDuracionCita == 0){
            intervaloDuracionCita = 1   //Si del api viene cero, seteamos 1
        } else {
            timeR.minuteInterval = intervaloDuracionCita
        }
        //ACA SE CONFIGURA EL PLAZO MAXIMO DE TIEMPO QUE SE PUEDE RESERVAR UNA CITA CON ANTICIPACION
        
        //intervaloAnticipacion = 5184000 //segundos
        
        
        dateR.maximumDate = Date(timeIntervalSinceNow: TimeInterval(intervaloAnticipacion))
        
        
        DateThemesList.delegate=self
        DateThemesList.dataSource=self
        
        StudentList.delegate=self
        StudentList.dataSource=self
 */
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == DateThemesList){
            return temaA[row].nombre
        }
        else {
            return alumA[row].alumno
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == DateThemesList){
            return temaA.count
        }
        else {
            return alumA.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == DateThemesList){
            temaSel = row
        }
        else {
            alumnoSel = row
        }
    }
    
 
    @IBAction func registrarCita(_ sender: AnyObject) {
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        let errorAlert = UIAlertController(title: "Error al registrar cita!",
                                           message: nil,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        errorAlert.addAction(action)
        
        let json = NSMutableDictionary()
        
        
        
        if ( temaSel != 0) {
            json.setValue(temaA[temaSel].nombre, forKey: "tema") //Seteo el tema
            json.setValue(temaA[temaSel].nombre, forKey: "motivo") //Seteo el tema
        } else {
            errorAlert.message = "Seleccione un tema o motivo de cita"
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy" //"yyyy-MM-dd HH:mm:ss"
        
       
        
        
        let  fI = dateFormater.string(from: dateR.date)
        
        //LA hora que se le pasa solo es hora y min
        
        dateFormater.dateFormat = "HH:mm"
        
        let hI = dateFormater.string(from: timeR.date)
        
        //CONCATENO EL DATE PICKER Y EL TIME PICKER PARA VERIFICAR QUE ES UNA FECHA Y HORA VALIDA
        
        let fechaYhoraS: String = fI + " " + hI + ":" + "00"
        dateFormater.dateFormat = "dd/MM/yyyy HH:mm:ss" // "EEEE"
        let fechayhoraD: Date = dateFormater.date(from: fechaYhoraS)!
        
        
        dateFormater.dateFormat = "EEEE" // "EEEE" devuelve el dia de semana

        //VERIFICAR QUE EL DIA Y HORA SELECCIONADOS SEAN ACORDE AL HORARIO DEL TUTOR
        let diaSemana = dateFormater.string(from: fechayhoraD) //En ingles
        
        print(diaSemana)
        
        dateFormater.dateFormat = "HH"
        
        let horaCita = Int(dateFormater.string(from: fechayhoraD))
        
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUsuario = String.init(parser)
        json.setValue(parser, forKey: "idUser")
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        if (rol == "A"){
            /*
            HTTPHelper.get(route: "getTutorInfo/" + idUsuario + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    let tj = tjd[0] as! [String:AnyObject]
                    print(tj)
                    
                    
                    let horario: [Any]
                    
                    
                    
                    if ((tj["scheduleInfo"])?.count != 0){
                        print(tj["scheduleInfo"])
                        horario = tj["scheduleInfo"] as! [AnyObject]
                        
                        
                        for diaH in horario {
                            
                            let dateFormater = DateFormatter()
                            dateFormater.dateFormat = "HH:mm:ss"
                            let diaHo = diaH as! [String:AnyObject]
                            
                            let  hI = dateFormater.date(from: (diaHo["hora_inicio"] as! String))
                            //print(diaHo["hora_inicio"] as! String)
                            
                            dateFormater.dateFormat = "HH"
                            
                            if ( (diaHo["dia"] as! String) == "1") {
                                
                                //self.horarioL.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasL.append(Int( dateFormater.string(from: hI!))!))
                                
                            }
                            
                            if ( (diaHo["dia"] as! String) == "2") {
                                
                                //self.horarioMa.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasMa.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "3") {
                                
                                //self.horarioMi.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasMi.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "4") {
                                
                                //self.horarioJ.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasJ.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "5") {
                                
                                //self.horarioV.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasV.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "6") {
                                
                                //self.horarioS.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasS.append(Int( dateFormater.string(from: hI!))!))
                            }
                        }
                    }
                }
            })
             */
            //getHorarioTutor()
            horarioL = ((self.parent as! NavigationControllerC).horasL)
            horarioMa = ((self.parent as! NavigationControllerC).horasMa)
            print("dia Lunes")
            for d in ((self.parent as! NavigationControllerC).horasL){
                print(d)
            }
            print("dia Martes")
            for d in ((self.parent as! NavigationControllerC).horasMa) {
                print(d)
            }
            print("dia Miercoles")
            for d in ((self.parent as! NavigationControllerC).horasMi) {
                print(d)
            }
            print("dia Jueves")
            for d in ((self.parent as! NavigationControllerC).horasJ) {
                print(d)
            }
            print("dia Viernes")
            for d in ((self.parent as! NavigationControllerC).horasV) {
                print(d)
            }
            print("dia Sabado")
            for d in ((self.parent as! NavigationControllerC).horasS) {
                print(d)
            }
            
            
            
            //return
            
            //diaSemana y horaCita
            if diaSemana == "Monday" {
                if ((self.parent as! NavigationControllerC).horasL).contains(horaCita!) == false {
                    errorAlert.message = "Fecha y hora seleccionadas no estan en la disponibilidad del tutor"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
            if diaSemana == "Tuesday" {
                if ((self.parent as! NavigationControllerC).horasMa).contains(horaCita!) == false {
                    errorAlert.message = "Fecha y hora seleccionadas no estan en la disponibilidad del tutor"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
            if diaSemana == "Wednesday" {
                if ((self.parent as! NavigationControllerC).horasMi).contains(horaCita!) == false {
                    errorAlert.message = "Fecha y hora seleccionadas no estan en la disponibilidad del tutor"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
            if diaSemana == "Thursday" {
                if ((self.parent as! NavigationControllerC).horasJ).contains(horaCita!) == false {
                    errorAlert.message = "Fecha y hora seleccionadas no estan en la disponibilidad del tutor"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
            if diaSemana == "Friday" {
                if ((self.parent as! NavigationControllerC).horasV).contains(horaCita!) == false {
                    errorAlert.message = "Fecha y hora seleccionadas no estan en la disponibilidad del tutor"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
            if diaSemana == "Saturday" {
                if ((self.parent as! NavigationControllerC).horasS).contains(horaCita!) == false {
                    errorAlert.message = "Fecha y hora seleccionadas no estan en la disponibilidad del tutor"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
            if diaSemana == "Sunday" {
                if horarioS.contains(horaCita!) == false {
                    errorAlert.message = "Los domingos no se brindan asesorias"
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                    
                }
            }
            
        }
    
        //////////////////////////////////////////////////SETEAR VALORES AL JSON DEL POST
        
        if ( fechayhoraD > Date.init() && fechayhoraD < Date(timeIntervalSinceNow: TimeInterval(intervaloAnticipacion))) {
            
            print("Valido")
            json.setValue(fI, forKey: "fecha")  //Seteo la fecha
            json.setValue(hI, forKey: "hora")   //Seteo la hora
        } else {
            print("No valido")
            errorAlert.message = "Fecha y hora seleccionadas no son válidas"
            self.present(errorAlert, animated: true, completion: nil)
            return
            
        }
        
        
        //let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        //let idUser = String.init(parser)
        json.setValue(idUsuario, forKey: "idUser") //Seteo el idUsuario
        
        
        
        
        //let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
 
        
        //
        
        //
        if (rol == "A"){
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                //print(jsonData)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                //print(decoded)
                let postData = decoded as! [String:AnyObject]
                print("Este es post data")
                print(postData)
                
                HTTPHelper.post(route: "registerStudentAppointment?token=" + token, authenticated: false, body: postData, completion: { (error, responseData) in
                    if error == nil {
                        
                        let alertSuccess : UIAlertController = UIAlertController.init(title: "Registro de cita exitoso", message: "Se ha registrado la cita exitosamente", preferredStyle: .alert)
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
        }
        if (rol == "T"){
            if ( alumnoSel != 0) {
                //json.setValue(alumA[alumnoSel].alumno, forKey: "studentFullName") //Seteo el alumno, el nombre, porque gerardo lo hizo chancho, debio meterle el idAlumno
                json.setValue(alumA[alumnoSel].codigo, forKey: "idAlumno")
                
                print("alalslalsdsadasdasdasdsadas")
                print("alalslalsdsadasdasdasdsadas")
                print(alumA[alumnoSel].codigo)
                
                json.setValue("", forKey: "observacion")
                json.setValue(10, forKey: "duracionCita")
            } else {
                errorAlert.message = "Seleccione un alumno"
                self.present(errorAlert, animated: true, completion: nil)
                return
            }
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                //print(jsonData)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                //print(decoded)
                let postData = decoded as! [String:AnyObject]
                print("Este es post data")
                print(postData)
                
                HTTPHelper.post(route: "registerTutorAppointment?token=" + token, authenticated: false, body: postData, completion: { (error, responseData) in
                    if error == nil {
                        
                        let alertSuccess : UIAlertController = UIAlertController.init(title: "Registro de cita exitoso", message: "Se ha registrado la cita exitosamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler:{ action in
                            
                            self.navigationController?.popViewController(animated: true)
                            //self.performSegue(withIdentifier: "SegueCitasReg", sender: self)
                            
                        })
                        alertSuccess.addAction(action)
                        self.present(alertSuccess,animated: false, completion:nil)
                        
                        
                        
                    } else {
                        //errorAlert.message = "No se pudo registrar la cita"
                        //self.present(errorAlert, animated: true, completion: nil)
                        
                        print("REQUESTED RESPONSE: \(responseData)")
                        
                        let alertSuccess : UIAlertController = UIAlertController.init(title: "Registro de cita exitoso", message: "Se ha registrado la cita exitosamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler:{ action in
                            
                            self.navigationController?.popViewController(animated: true)
                            //self.performSegue(withIdentifier: "SegueCitasReg", sender: self)
                            
                        })
                        alertSuccess.addAction(action)
                        self.present(alertSuccess,animated: false, completion:nil)
                    }
                })
                
            } catch let err as NSError{
                print("JSONObjet ERROR: \(err)")
            }
        }
    }
    
    func getHorarioTutor(){
        
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUsuario = String.init(parser)
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        if (rol == "A"){
            HTTPHelper.get(route: "getTutorInfo/" + idUsuario + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    let tj = tjd[0] as! [String:AnyObject]
                    print(tj)
                    
                    
                    let horario: [Any]
                    
                    
                    
                    if ((tj["scheduleInfo"])?.count != 0){
                        print(tj["scheduleInfo"])
                        horario = tj["scheduleInfo"] as! [AnyObject]
                        
                        
                        for diaH in horario {
                            
                            let dateFormater = DateFormatter()
                            dateFormater.dateFormat = "HH:mm:ss"
                            let diaHo = diaH as! [String:AnyObject]
                            
                            let  hI = dateFormater.date(from: (diaHo["hora_inicio"] as! String))
                            //print(diaHo["hora_inicio"] as! String)
                            
                            dateFormater.dateFormat = "HH"
                            
                            if ( (diaHo["dia"] as! String) == "1") {
                                
                                //self.horarioL.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasL.append(Int( dateFormater.string(from: hI!))!))
                                
                            }
                            
                            if ( (diaHo["dia"] as! String) == "2") {
                                
                                //self.horarioMa.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasMa.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "3") {
                                
                                //self.horarioMi.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasMi.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "4") {
                                
                                //self.horarioJ.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasJ.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "5") {
                                
                                //self.horarioV.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasV.append(Int( dateFormater.string(from: hI!))!))
                            }
                            
                            if ( (diaHo["dia"] as! String) == "6") {
                                
                                //self.horarioS.append(Int( dateFormater.string(from: hI!))!)
                                ((self.parent as! NavigationControllerC).horasS.append(Int( dateFormater.string(from: hI!))!))
                            }
                        }
                    }
                }
            })
            
        }
    }
 

}
