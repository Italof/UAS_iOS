//
//  ViewControllerDates.swift
//  UASapp
//
//  Created by inf227al on 24/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerDates: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var Dates: UITableView!
    @IBOutlet weak var botonFiltrar: UIButton!
    
    @IBOutlet var botonAtenderSinCita: UIButton!
    
    @IBOutlet weak var botonNuevaCitaM: UIButton!
    
    var citS: [cita]?
    
    var elegido: Int = -1
    
    var datesA = [String]()
    var times = [String]()
    var themes = [String]()
    var students = [String]()
    var statusA = [String]()
    var filtroC: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if ( rol == "A"){
            botonAtenderSinCita.isHidden = true
        }
        
        filtroC = ((self.parent as! NavigationControllerC).filtroCitas)
        //print("id usuario")
        //print(UserDefaults.standard.object( forKey: "USER_ID"))
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        if ( rol == "A") {
            HTTPHelper.get(route: "getTutorInfo/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                if(error == nil){
                    
                    self.botonNuevaCitaM.isHidden = false
                    
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    let tj = tjd[0] as! [String:AnyObject]
                    
                    //SI EL TUTOR NO HA REGISTRADO SU HORARIO DE ATENCION, EL ALUMNO NO PODRA REALIZAR CITAS
                    if ((tj["scheduleInfo"])?.count == 0){
                        self.botonNuevaCitaM.isHidden = true
                    } else {
                        
                        ((self.parent as! NavigationControllerC).horasL) = []
                        ((self.parent as! NavigationControllerC).horasMa) = []
                        ((self.parent as! NavigationControllerC).horasMi) = []
                        ((self.parent as! NavigationControllerC).horasJ) = []
                        ((self.parent as! NavigationControllerC).horasV) = []
                        ((self.parent as! NavigationControllerC).horasS) = []
                        
                        
                        let horario = tj["scheduleInfo"] as! [AnyObject]
                        
                        
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
                else {
                    print(error)
                    //SI EL ALUMNO NO TIENE TUTOR, NO PODRA REALIZAR CITAS
                    self.botonNuevaCitaM.isHidden = true
                }
            })
            
            
            
            if ( filtroC == "S"){
                self.loadData()
                //((self.parent as! NavigationControllerC).filtroCitas) = "N"
            } else {
                HTTPHelper.get(route: "getAppointmentList/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                    
                    if(error == nil){
                        //obtener data
                        let dataUnwrapped = data.unsafelyUnwrapped
                        let tjd = dataUnwrapped as! [AnyObject]
                        
                        
                        var cS: [cita] = [] ///////////
                        
                        for c in tjd {
                            print("cita:")
                            print(c)
                            
                            
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
                            alumno = c["nombreAlumno"] as! String?
                            //alumno = "Prueba"
                            estado = c["nombreEstado"] as! String?
                            let idTemaTemp = c["id_topic"] as! String?
                            idTema = Int(idTemaTemp!)
                            
                            if ((c["lugar"] as? String!) != nil){
                                lugar = c["lugar"] as! String?
                            } else {
                                lugar = "-"
                            }
                            
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
                            //alumno = "----"
                            
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
                        
                        DispatchQueue.main.async {
                            self.loadData()
                            self.Dates.reloadData()
                            return
                        }
                        
                    }   else {
                        print("error,NO HAY NADA ACA")
                    }
                    
                })
            }
        }
        
        
        
        
        //Citas para el tutor getTutorAppoints
        
        if ( rol == "T"){
            
            if ( filtroC == "S"){
                self.loadData()
                //((self.parent as! NavigationControllerC).filtroCitas) = "N"
            }else {
                
            
            
            /* QUE GERARDO SUBA EL API A PRODUCCION Y CORRERA
             
             HTTPHelper.get(route: "getAppointInformationTuto/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
             
             if(error == nil){
             
             self.botonNuevaCitaM.isHidden = false
             
             let dataUnwrapped = data.unsafelyUnwrapped
             let tjd = dataUnwrapped as! [AnyObject]
             let tj = tjd[0] as! [String:AnyObject]
             
             //SI EL TUTOR NO HA REGISTRADO SU HORARIO DE ATENCION, EL TUTOR NO PODRA REALIZAR CITAS
             if ((tj["scheduleInfo"])?.count == 0){
             self.botonNuevaCitaM.isHidden = true
             self.botonAtenderSinCita = true
             }
             
             }
             else {
             
             }
             })
             */
            
            
            HTTPHelper.get(route: "getTutorAppoints/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    
                    
                    var cS: [cita] = [] ///////////
                    
                    for c in tjd {
                        print("cita:")
                        print(c)
                        
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
                        alumno = c["nombreAlumno"] as! String?
                        //alumno = "Prueba"
                        estado = c["nombreEstado"] as! String?
                        let idTemaTemp = c["id_topic"] as! String?
                        idTema = Int(idTemaTemp!)
                        
                        if ((c["lugar"] as? String!) != nil){
                            lugar = c["lugar"] as! String?
                        } else {
                            lugar = "-"
                        }
                        
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
                        //alumno = "----"
                        
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

                        /*
                        
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
                        */
                        
                    }
                    
                    
                    cS.reverse()
                    
                    
                    ((self.parent as! NavigationControllerC).citasOb) = cS
                    
                    DispatchQueue.main.async {
                        self.loadData()
                        self.Dates.reloadData()
                        return
                    }
                    
                    
                    
                    
                }   else {
                    print("error,NO HAY NADA ACA")
                }
                
            })
            }
        }
        self.Dates.reloadData()
        
        //EN ESTE PUNTO YA SE TIENEN LAS CITAS ( SEA DE ALUMNO O TUTOR )
        
        ((self.parent as! NavigationControllerC).filtroCitas) = "N"
        */
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //let admi: Int = UserDefaults.standard.object(forKey: "")
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if ( rol == "A"){
            botonAtenderSinCita.isHidden = true
        }
        
        filtroC = ((self.parent as! NavigationControllerC).filtroCitas)
       
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
        if ( rol == "A") {
            HTTPHelper.get(route: "getTutorInfo/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                
                if(error == nil){
                    
                    self.botonNuevaCitaM.isHidden = false
                    
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let tjd = dataUnwrapped as! [AnyObject]
                    let tj = tjd[0] as! [String:AnyObject]
                    
                    //SI EL TUTOR NO HA REGISTRADO SU HORARIO DE ATENCION, EL ALUMNO NO PODRA REALIZAR CITAS
                    if ((tj["scheduleInfo"])?.count == 0){
                        self.botonNuevaCitaM.isHidden = true
                    } else {
                        
                        ((self.parent as! NavigationControllerC).horasL) = []
                        ((self.parent as! NavigationControllerC).horasMa) = []
                        ((self.parent as! NavigationControllerC).horasMi) = []
                        ((self.parent as! NavigationControllerC).horasJ) = []
                        ((self.parent as! NavigationControllerC).horasV) = []
                        ((self.parent as! NavigationControllerC).horasS) = []
                        
                        
                        let horario = tj["scheduleInfo"] as! [AnyObject]
                        
                        
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
                else {
                    print(error)
                    //SI EL ALUMNO NO TIENE TUTOR, NO PODRA REALIZAR CITAS
                    self.botonNuevaCitaM.isHidden = true
                }
            })
            
            
            
            if ( filtroC == "S"){
                self.loadData()
                //((self.parent as! NavigationControllerC).filtroCitas) = "N"
            } else {
                HTTPHelper.get(route: "getAppointmentList/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                    
                    if(error == nil){
                        //obtener data
                        let dataUnwrapped = data.unsafelyUnwrapped
                        let tjd = dataUnwrapped as! [AnyObject]
                        
                        
                        var cS: [cita] = [] ///////////
                        
                        for c in tjd {
                            print("cita:")
                            print(c)
                            
                            
                            let citaId: String?
                            let fechaI: String?
                            let horaI: String?
                            let tema: String?
                            var alumno: String?
                            var estado: String?
                            
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
                            alumno = c["nombreAlumno"] as! String?
                            //alumno = "Prueba"
                            
                            let idTemaTemp = c["id_topic"] as! String?
                            idTema = Int(idTemaTemp!)
                            
                            if ((c["lugar"] as? String!) != nil){
                                lugar = c["lugar"] as! String?
                            } else {
                                lugar = "-"
                            }
                            
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
                            
                            let flagCreadorTemp = c["creador"] as! String?
                            if flagCreadorTemp == "0" {
                                flagCreador = "A"
                            }
                            if flagCreadorTemp == "1" {
                                flagCreador = "T"
                            }
                            
                            let idEstadoTemp = c["estado"] as! String?
                            idEstado = Int(idEstadoTemp!)
                            
                            //if ((c["nombreEstado"] as? String!) != nil){
                            //    estado = c["nombreEstado"] as! String?
                            //} else {
                            if (idEstado == 1){
                                estado = "Pendiente"
                            }
                            if (idEstado == 2){
                                estado = "Confirmada"
                            }
                            if (idEstado == 3){
                                estado = "Cancelada"
                            }
                            if (idEstado == 4){
                               if (flagCreador == "T"){
                                   estado = "Sugerida"
                               }
                               if (flagCreador == "A"){
                                    estado = "Pendiente"
                                }
                            }
                            if (idEstado == 5){
                                estado = "Rechazada"
                            }
                            if (idEstado == 6){
                                estado = "Asistida"
                            }
                            if (idEstado == 7){
                                estado = "No asistida"
                            }
                            //}
                            //estado = c["nombreEstado"] as! String?
                            
                            let idTutorTemp = c["id_docente"] as! String?
                            idTutor = Int(idTutorTemp!)
                            tutor = "---"
                            let idAlumnoTemp = c["id_tutstudent"] as! String?
                            idAlumno = Int(idAlumnoTemp!)
                            //alumno = "----"
                            
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
                        
                        DispatchQueue.main.async {
                            self.loadData()
                            self.Dates.reloadData()
                            return
                        }
                        
                    }   else {
                        print("error,NO HAY NADA ACA")
                    }
                    
                })
            }
        }
        
        
        
        
        //Citas para el tutor getTutorAppoints
        
        if ( rol == "T"){
            
            if ( filtroC == "S"){
                self.loadData()
                //((self.parent as! NavigationControllerC).filtroCitas) = "N"
            }else {
                
                
                
                /* QUE GERARDO SUBA EL API A PRODUCCION Y CORRERA
                 
                 HTTPHelper.get(route: "getAppointInformationTuto/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                 
                 if(error == nil){
                 
                 self.botonNuevaCitaM.isHidden = false
                 
                 let dataUnwrapped = data.unsafelyUnwrapped
                 let tjd = dataUnwrapped as! [AnyObject]
                 let tj = tjd[0] as! [String:AnyObject]
                 
                 //SI EL TUTOR NO HA REGISTRADO SU HORARIO DE ATENCION, EL TUTOR NO PODRA REALIZAR CITAS
                 if ((tj["scheduleInfo"])?.count == 0){
                 self.botonNuevaCitaM.isHidden = true
                 self.botonAtenderSinCita = true
                 }
                 
                 }
                 else {
                 
                 }
                 })
                 */
                
                
                HTTPHelper.get(route: "getTutorAppoints/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
                    
                    if(error == nil){
                        //obtener data
                        let dataUnwrapped = data.unsafelyUnwrapped
                        let tjd = dataUnwrapped as! [AnyObject]
                        
                        
                        var cS: [cita] = [] ///////////
                        
                        for c in tjd {
                            print("cita:")
                            print(c)
                            
                            let citaId: String?
                            let fechaI: String?
                            let horaI: String?
                            let tema: String?
                            var alumno: String?
                            var estado: String?
                            
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
                            alumno = c["nombreAlumno"] as! String?
                            //alumno = "Prueba"
                            //estado = c["nombreEstado"] as! String?
                            let idTemaTemp = c["id_topic"] as! String?
                            idTema = Int(idTemaTemp!)
                            
                            if ((c["lugar"] as? String!) != nil){
                                lugar = c["lugar"] as! String?
                            } else {
                                lugar = "-"
                            }
                            
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
                            let flagCreadorTemp = c["creador"] as! String?
                            if flagCreadorTemp == "0" {
                                flagCreador = "A"
                            }
                            if flagCreadorTemp == "1" {
                                flagCreador = "T"
                            }
                            
                            let idEstadoTemp = c["estado"] as! String?
                            idEstado = Int(idEstadoTemp!)
                            
                            //if ((c["nombreEstado"] as? String!) != nil){
                            //    estado = c["nombreEstado"] as! String?
                            //} else {
                            if (idEstado == 1){
                                estado = "Pendiente"
                            }
                            if (idEstado == 2){
                                estado = "Confirmada"
                            }
                            if (idEstado == 3){
                                estado = "Cancelada"
                            }
                            print("ENTRO A CAMBIAR los ESTADOs DE ESTA VAINA")
                            if (idEstado == 4){
                               if (flagCreador == "A"){
                                    
                                    print("ENTRO A CAMBIAR ESTADO DE ESTA VAINA seguraida")
                                    estado = "Sugerida"
                                }
                                if (flagCreador == "T"){
                                    estado = "Pendiente"
                                }
                            }
                            if (idEstado == 5){
                                estado = "Rechazada"
                            }
                            if (idEstado == 6){
                                estado = "Asistida"
                            }
                            if (idEstado == 7){
                                estado = "No asistida"
                            }
                            //}
                            
                            let idTutorTemp = c["id_docente"] as! String?
                            idTutor = Int(idTutorTemp!)
                            tutor = "---"
                            let idAlumnoTemp = c["id_tutstudent"] as! String?
                            idAlumno = Int(idAlumnoTemp!)
                            //alumno = "----"
                            
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
                        
                        DispatchQueue.main.async {
                            self.loadData()
                            self.Dates.reloadData()
                            return
                        }
                        
                        
                        
                        
                    }   else {
                        print("error,NO HAY NADA ACA")
                    }
                    
                })
            }
        }
        
        self.Dates.reloadData()
        ((self.parent as! NavigationControllerC).filtroCitas) = "N"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datesA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = Dates.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellDate
        
        cell.date.text = datesA[indexPath.row]
        cell.time.text = times[indexPath.row]
        cell.theme.text = themes[indexPath.row]
        cell.student.text = students[indexPath.row]
        cell.status.text = statusA[indexPath.row]

        
        if (cell.status.text == "Pendiente"){
            cell.status.backgroundColor = UIColor(red: 255.0/255.0, green: 152.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        if (cell.status.text == "Confirmada"){
            cell.status.backgroundColor = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        }
        if (cell.status.text == "Cancelada"){
            cell.status.backgroundColor = UIColor(red: 217.0/255.0, green: 83.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        }
        if (cell.status.text == "Sugerida"){
            cell.status.backgroundColor = UIColor(red: 255.0/255.0, green: 235.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        }
        if (cell.status.text == "Rechazada"){
            cell.status.backgroundColor = UIColor(red: 158.0/255.0, green: 158.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        }
        if (cell.status.text == "Asistida"){
            cell.status.backgroundColor = UIColor(red: 64.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        }
        if (cell.status.text == "No asistida"){
            cell.status.backgroundColor = UIColor(red: 76.0/255.0, green: 175.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        }
        return cell
        
    }
    
    func loadData() {
        if (((self.parent as! NavigationControllerC).filtroCitas) == "N"){
            citS = ((self.parent as! NavigationControllerC).citasOb)
        }
        
        if (((self.parent as! NavigationControllerC).filtroCitas) == "S"){
            citS = ((self.parent as! NavigationControllerC).citasObF)
            //((self.parent as! NavigationControllerC).filtroCitas) = "N"
        }
        if (citS == nil || citS?.count == 0){
            if (((self.parent as! NavigationControllerC).filtroCitas) == "N"){
            botonFiltrar.isHidden = true
            //Mostrar error y regresar al menù principal
            let alert : UIAlertController = UIAlertController.init(title: "No tiene citas", message: "Usted no ha realizado citas", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion:nil)
            }
            if (((self.parent as! NavigationControllerC).filtroCitas) == "S"){
                //botonFiltrar.isHidden = true
                //Mostrar error y regresar al menù principal
                let alert : UIAlertController = UIAlertController.init(title: "Filtro de citas", message: "No se han encontrado resultados", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
            }
        }
        
        if ( citS != nil || citS?.count != 0){
            datesA = []
            times = []
            themes = []
            students = []
            statusA = []
            for c in citS!{
                datesA.append(c.fechaI!)
                times.append(c.horaI!)
                themes.append(c.tema!)
                students.append(c.alumno!)
                statusA.append(c.estado!)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("Id de cita escogida")
        
        //print(indexPath.row)
        
        
        let citEsc = (citS?[indexPath.row])! as cita
        elegido = indexPath.row
        
        
        
        //print("Antes de asignar")
        //print(citEsc.citaId)
        ((self.parent as! NavigationControllerC).citEsc) = citEsc
        
        //print("Despues de asignar")
        //print(((self.parent as! NavigationControllerC).citEsc)?.citaId)
        
        self.performSegue(withIdentifier: "SegueVerCita", sender: self)
        
    }
}
