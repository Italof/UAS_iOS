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
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        
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
        
        
        //let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        //let idUser = String.init(parser)
        //let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("Haciendo el get")
        HTTPHelper.get(route: "getAppointmentList/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            print("Dentro  del get")
            
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
                    //self.citS?.append(citaO)
                }
                
                print("temporal")
                for c in cS {
                    print(c.citaId)
                }
                
                ((self.parent as! NavigationControllerC).citasOb) = cS
             
                /*
                self.citS = cS
                
                print("real")
                for x in (self.citS)! {
                    print(x.citaId)
                }
                */
                
              
                
            }   else {
                print("error,NO HAY NADA ACA")
            }
            
        })
        print("Acabo el get")
        
        
        citS = ((self.parent as! NavigationControllerC).citasOb)
       
        
 
        
        if ( citS != nil || citS?.count == 0){
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
        
        //super.viewDidAppear()
        
        citS = ((self.parent as! NavigationControllerC).citasOb)
        print("Numero de citas")
        print(citS?.count)
        print("c")
        if ( citS != nil){
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
        
        ((self.parent as! NavigationControllerC).citEsc) = citEsc
        
    }
    


}
