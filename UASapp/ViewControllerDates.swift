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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" Inicia VDL")
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if ( rol == "A"){
            botonAtenderSinCita.isHidden = true
        }
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
                    }
                    
                }
                else {
                    print(error)
                    //SI EL ALUMNO NO TIENE TUTOR, NO PODRA REALIZAR CITAS
                    self.botonNuevaCitaM.isHidden = true
                }
            })
            
            
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
                        let alumno: String?
                        let estado: String?
                        
                        var fI: Date?
                        var hI: Date?
                        
                        let idc: Int = (c["id"] as! Int?)!
                        citaId = String(idc)
                        tema = c["nombreTema"] as! String?
                        //alumno = c["nombreAlumno"] as! String?
                        alumno = "Prueba"
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
        
        
        
        
        //Citas para el tutor getTutorAppoints
        
        if ( rol == "T"){
            
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
        
        //EN ESTE PUNTO YA SE TIENEN LAS CITAS ( SEA DE ALUMNO O TUTOR )
        
        citS = ((self.parent as! NavigationControllerC).citasOb)
        if (citS == nil){// || citS?.count == 0){
            botonFiltrar.isHidden = true
        }
        
        
        
        if ( citS != nil ){//|| citS?.count != 0){
            for c in citS!{
                datesA.append(c.fechaI!)
                times.append(c.horaI!)
                themes.append(c.tema!)
                students.append(c.alumno!)
                statusA.append(c.estado!)
            }
        } else {
            //Mostrar error y regresar al menù principal
            let alert : UIAlertController = UIAlertController.init(title: "No tiene citas", message: "Usted no ha realizado citas", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion:nil)
        }
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
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
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Id de cita escogida")
        
        print(indexPath.row)
        
        
        let citEsc = (citS?[indexPath.row])! as cita
        elegido = indexPath.row
        
        
        
        print("Antes de asignar")
        print(citEsc.citaId)
        ((self.parent as! NavigationControllerC).citEsc) = citEsc
        
        print("Despues de asignar")
        print(((self.parent as! NavigationControllerC).citEsc)?.citaId)
        
        self.performSegue(withIdentifier: "SegueVerCita", sender: self)
        
    }
    
    
    
}
