//
//  ViewControllerTutoriaMenu.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerTutoriaMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func viewMyTutor(_ sender: AnyObject) {
        /*
        ruta: "getTutorInfo/(idUsuario)?token=(token)"
        */
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID user = " + idUser)
        print("token = " + token)
        HTTPHelper.get(route: "getTutorInfo/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
       
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                let tj = tjd[0] as! [String:AnyObject]
                print(tj)
                
                let idDocente: String?
                let idEspecialidad: String?
                let codigo: String?
                let nombre: String?
                let apellidoPaterno: String?
                let apellidoMaterno: String?
                let correo: String?
                let oficina: String?
                let telefono: String?
                let anexo: String?
                let horario: [Any]
                
                //Variables que vienen del Json diferente a string
                let idDc: Int
                
                if ((tj["IdDocente"]) != nil){
                    idDc = (tj["IdDocente"] as! Int?)!
                    idDocente = String(idDc)
                } else {
                    idDocente = "-"
                }
                
                if ((tj["IdEspecialidad"]) != nil){
                    idEspecialidad = tj["IdEspecialidad"] as! String?
                } else {
                    idEspecialidad = "-"
                }
                
                if ((tj["Codigo"]) != nil){
                    codigo = tj["Codigo"] as! String?
                } else {
                    codigo = "-"
                }
                
                if ((tj["Nombre"]) != nil){
                    nombre = tj["Nombre"] as! String?
                } else {
                    nombre = "-"
                }
                
                if ((tj["ApellidoPaterno"]) != nil){
                    apellidoPaterno = tj["ApellidoPaterno"] as! String?
                } else {
                    apellidoPaterno = "-"
                }
                
                if ((tj["ApellidoMaterno"]) != nil){
                    apellidoMaterno = tj["ApellidoMaterno"] as! String?
                } else {
                    apellidoMaterno = "-"
                }
                
                if ((tj["Correo"]) != nil){
                    correo = tj["Correo"] as! String?
                } else {
                    correo = "-"
                }
                
                if ((tj["oficina"]) != nil){
                    oficina = tj["oficina"] as! String?
                } else {
                    oficina = "-"
                }
                
                if ((tj["telefono"]) != nil){
                    telefono = tj["telefono"] as! String?
                } else {
                    telefono = "-"
                }
                
                if ((tj["anexo"]) != nil){
                    anexo = tj["anexo"] as! String?
                } else {
                    anexo = "-"
                }
                
                var horarioL: String! = "Lunes: "
                var horarioMa: String! = "Martes: "
                var horarioMi: String! = "Miercoles: "
                var horarioJ: String! = "Jueves: "
                var horarioV: String! = "Viernes: "
                
                if ((tj["scheduleInfo"]) != nil){
                    print(tj["scheduleInfo"])
                    horario = tj["scheduleInfo"] as! [AnyObject]
                    
                    
                    for diaH in horario {
                        
                        let dateFormater = DateFormatter()
                        dateFormater.dateFormat = "HH:mm:ss"
                        let diaHo = diaH as! [String:AnyObject]
                        
                        let  hI = dateFormater.date(from: (diaHo["hora_inicio"] as! String))
                        let  hF = dateFormater.date(from: (diaHo["hora_fin"] as! String))
                        
                        dateFormater.dateFormat = "HH:mm"
                        
                        if ( (diaHo["dia"] as! String) == "1") {
                            
                            horarioL = horarioL + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "2") {
                            
                            horarioMa = horarioMa + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "3") {
                            
                            horarioMi = horarioMi + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "4") {
                            
                            horarioJ = horarioJ + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "5") {
                            
                            horarioV = horarioV + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                    }
                }
                else {
                    horarioL = horarioL + "-"
                    horarioMa = horarioMa + "-"
                    horarioMi = horarioMi + "-"
                    horarioJ = horarioJ + "-"
                    horarioV = horarioV + "-"
                }               
               
                
                
                
                let tutorO : tutor = tutor.init(idDocente: idDocente, idEspecialidad: idEspecialidad, codigo: codigo, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, correo: correo, oficina: oficina, telefono: telefono, anexo: anexo, horarioL: horarioL, horarioMa: horarioMa, horarioMi: horarioMi, horarioJ: horarioJ, horarioV: horarioV )
                ((self.parent as! NavigationControllerC).tutorOb) = tutorO
            
            
            
                print(tutorO)
            }
            else {
                //Mostrar error y regresar al menù principal
                let alert : UIAlertController = UIAlertController.init(title: "Sin tutor asignado", message: "Usted no cuenta con un tutor asignado", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
                
            }
    })
    
    }
    
    @IBAction func verCitas(_ sender: AnyObject) {
        /*
         ruta: "getAppointmentList/(idUsuario)?token=(token)"
         */
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID user = " + idUser)
        print("token = " + token)
        HTTPHelper.get(route: "getAppointmentList/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                var cS: [cita]! ///////////
                
                for c in tjd {
                    
                    let citaId: String?
                    let fechaI: String?
                    let horaI: String?
                    let tema: String?
                    let alumno: String?
                    let estado: String?
                    
                    
                    citaId = c["id"] as! String?
                    tema = c["nombreTema"] as! String?
                    alumno = c["nombreAlumno"] as! String?
                    estado = c["nombreEstado"] as! String?
                    
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    
                    let  fI = dateFormater.date(from: (c["inicio"] as! String))
                    
                    
                    dateFormater.dateFormat = "yyyy-MM-dd"
                    fechaI = dateFormater.string(from: fI!)
                    
                    dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let  hI = dateFormater.date(from: (c["inicio"] as! String))
                    dateFormater.dateFormat = "HH:mm:ss"
                    
                    horaI = dateFormater.string(from: hI!)
                    
                    let citaO: cita = cita.init(citaId: citaId, fechaI: fechaI, horaI: horaI, tema: tema, alumno: alumno, estado: estado)
                    
                    cS.append(citaO)
                    
                }
                
                
                ((self.parent as! NavigationControllerC).citasOb) = cS
                
                
                
                if (cS != nil) {
                        print(cS)
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                let alert : UIAlertController = UIAlertController.init(title: "No tiene citas", message: "Usted no ha realizado citas", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
                
            }
        })

        
    }
    
    
    @IBAction func verAlumnos(_ sender: AnyObject) {
        /*
         ruta: "getStudents/(idUsuario)?token=(token)"
         */
        
        
        let parser : Int = UserDefaults.standard.object( forKey: "IdEspecialidad") as! Int
        let idEspecialidad = String.init(parser)
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID especialidad = " + idEspecialidad)
        print("token = " + token)
        HTTPHelper.get(route: "getStudents/" + idEspecialidad + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let tjd = dataUnwrapped as! [AnyObject]
                
                
                var cS: [alumno]! ///////////
                
                for c in tjd {
                    
                    let alumn: String?
                    let tutor: String?
                    let estado: String?
                    let codigo: String?
                    
                    tutor = c["NombreTutor"] as! String?
                    alumn = c["NombreAlumno"] as! String?
                    codigo = c["CodigoAlumno"] as! String?
                    estado = c["Estado"] as! String?
                    
                    
                    let alumnoO: alumno = alumno.init(alumno: alumn, codigo: codigo, tutor: tutor, estado: estado)
                    
                    cS.append(alumnoO)
                    
                }
                
                
                ((self.parent as! NavigationControllerC).alumnosOb) = cS
                
                
                
                if (cS != nil) {
                    print(cS)
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                let alert : UIAlertController = UIAlertController.init(title: "No hay alumnos", message: "No se han registrado alumnos a la especialidad", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
                
            }
        })
        
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
