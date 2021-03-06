//
//  ViewControllerTutorVisualize.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerTutorVisualize: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tutorCode: UILabel!
    
    @IBOutlet var tutorName: UILabel!
    
    @IBOutlet var tutorEmail: UILabel!
    
    @IBOutlet var tutorPhoneNumber: UILabel!
    
    @IBOutlet var tutorOffice: UILabel!
    
    @IBOutlet var tutorAnexo: UILabel!
    

    
    @IBOutlet weak var labelCodigo: UILabel!
    @IBOutlet weak var labelNombresyAp: UILabel!
    @IBOutlet weak var labelCorreo: UILabel!
    @IBOutlet weak var labelTelefono: UILabel!
    @IBOutlet weak var labelOficina: UILabel!
    @IBOutlet weak var labelAnexo: UILabel!
    @IBOutlet weak var labelHorario: UILabel!
    
    
    @IBOutlet weak var tableViewHorario: UITableView!
    
    var horasCitas = ["Horas", "8:00 hs", "9:00 hs", "10:00 hs", "11:00 hs", "12:00 hs", "13:00 hs", "14:00 hs", "15:00 hs", "16:00 hs", "17:00 hs", "18:00 hs", "19:00 hs", "20:00 hs", "21:00 hs"]
    
    var hLu = ["Lun", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var hMa = ["Mar", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var hMi = ["Mie", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var hJu = ["Jue", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var hVi = ["Vie", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var hSa = ["Sab", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    @IBOutlet weak var botonNuevaCita: UIButton!
    
    var tutorC: tutor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let parser : Int = UserDefaults.standard.object( forKey: "USER_ID") as! Int
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
                
                
                if ((tj["oficina"] as? String) != nil){
                    oficina = tj["oficina"] as! String?
                } else {
                    
                    oficina = "-"
                }
                
                if ((tj["telefono"] as? String) != nil){
                    telefono = tj["telefono"] as! String?
                } else {
                    telefono = "-"
                }
                
                if ((tj["anexo"] as? String) != nil){
                    anexo = tj["anexo"] as! String?
                } else {
                    anexo = "-"
                }
                
                var horarioL: String! = "Lunes: "
                var horarioMa: String! = "Martes: "
                var horarioMi: String! = "Miercoles: "
                var horarioJ: String! = "Jueves: "
                var horarioV: String! = "Viernes: "
                var horarioS: String! = "Sábado: "
                
                if ((tj["scheduleInfo"])?.count != 0){
                    print(tj["scheduleInfo"])
                    horario = tj["scheduleInfo"] as! [AnyObject]
                    
                    ((self.parent as! NavigationControllerC).horasL) = []
                    ((self.parent as! NavigationControllerC).horasMa) = []
                    ((self.parent as! NavigationControllerC).horasMi) = []
                    ((self.parent as! NavigationControllerC).horasJ) = []
                    ((self.parent as! NavigationControllerC).horasV) = []
                    ((self.parent as! NavigationControllerC).horasS) = []
                    
                    for diaH in horario {
                      
                        
                        
                        let dateFormater = DateFormatter()
                        dateFormater.dateFormat = "HH:mm:ss"
                        let diaHo = diaH as! [String:AnyObject]
                        
                        let  hI = dateFormater.date(from: (diaHo["hora_inicio"] as! String))
                        //print(diaHo["hora_inicio"] as! String)
                        
                        dateFormater.dateFormat = "HH"
                        
                        if ( (diaHo["dia"] as! String) == "1") {
                            
                            ((self.parent as! NavigationControllerC).horasL.append(Int( dateFormater.string(from: hI!))!))
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "2") {
                            
                            ((self.parent as! NavigationControllerC).horasMa.append(Int( dateFormater.string(from: hI!))!))
                        }
                        
                        if ( (diaHo["dia"] as! String) == "3") {
                            
                            ((self.parent as! NavigationControllerC).horasMi.append(Int( dateFormater.string(from: hI!))!))
                        }
                        
                        if ( (diaHo["dia"] as! String) == "4") {
                            
                            ((self.parent as! NavigationControllerC).horasJ.append(Int( dateFormater.string(from: hI!))!))
                        }
                        
                        if ( (diaHo["dia"] as! String) == "5") {
                            
                            ((self.parent as! NavigationControllerC).horasV.append(Int( dateFormater.string(from: hI!))!))
                        }
                        
                        if ( (diaHo["dia"] as! String) == "6") {
                            
                            ((self.parent as! NavigationControllerC).horasS.append(Int( dateFormater.string(from: hI!))!))
                        }

                    }
                }
                else {
                    horarioL = horarioL + "-"
                    horarioMa = horarioMa + "-"
                    horarioMi = horarioMi + "-"
                    horarioJ = horarioJ + "-"
                    horarioV = horarioV + "-"
                    horarioS = horarioS + "-"
 
                    self.botonNuevaCita.isHidden = true
                }
                print("dia Lunes")
                for d in ((self.parent as! NavigationControllerC).horasL){
                    horarioL = horarioL + " " + String(d)
                }
                print("dia Martes")
                for d in ((self.parent as! NavigationControllerC).horasMa) {
                    horarioMa = horarioMa + " " + String(d)
                }
                print("dia Miercoles")
                for d in ((self.parent as! NavigationControllerC).horasMi) {
                    horarioMi = horarioMi + " " + String(d)
                }
                print("dia Jueves")
                for d in ((self.parent as! NavigationControllerC).horasJ) {
                    horarioJ = horarioJ + " " + String(d)
                }
                print("dia Viernes")
                for d in ((self.parent as! NavigationControllerC).horasV) {
                    horarioV = horarioV + " " + String(d)
                }
                print("dia Sabado")
                for d in ((self.parent as! NavigationControllerC).horasS) {
                    horarioS = horarioS + " " + String(d)
                }
                

                
                
                let tutorX : tutor = tutor.init(idDocente: idDocente, idEspecialidad: idEspecialidad, codigo: codigo, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, correo: correo, oficina: oficina, telefono: telefono, anexo: anexo, horarioL: horarioL, horarioMa: horarioMa, horarioMi: horarioMi, horarioJ: horarioJ, horarioV: horarioV, horarioS: horarioS )
                
                print("tutor consultado")
                print(tutorX.nombre! + " " + tutorX.apellidoPaterno! + " " + tutorX.apellidoMaterno!)
                self.tutorC = tutorX
                
                    
                    
                    
                self.labelCodigo.isHidden = false
                self.labelNombresyAp.isHidden = false
                self.labelCorreo.isHidden = false
                self.labelTelefono.isHidden = false
                self.labelOficina.isHidden = false
                self.labelAnexo.isHidden = false
                self.labelHorario.isHidden = false
                
 
                self.tutorCode.text=self.tutorC?.codigo
                self.tutorName.text=self.tutorC?.nombre
                self.tutorEmail.text=self.tutorC?.correo
                self.tutorPhoneNumber.text=self.tutorC?.telefono
                self.tutorOffice.text=self.tutorC?.oficina
                self.tutorAnexo.text=self.tutorC?.anexo

                
                DispatchQueue.main.async {
                    self.loadData()
                    self.tableViewHorario.reloadData()
                    return
                }
                
            }
            else {
                
                print(error)
                self.tutorC = nil
                
                //Se oculta el boton para realizar citas
                self.botonNuevaCita.isHidden = true
                
                /*
                 self.tutorCode.isHidden = true
                 self.tutorName.isHidden = true
                 self.tutorEmail.isHidden = true
                 self.tutorPhoneNumber.isHidden = true
                 self.tutorOffice.isHidden = true
                 self.tutorAnexo.isHidden = true
                 */
                
                self.labelCodigo.isHidden = true
                self.labelNombresyAp.isHidden = true
                self.labelCorreo.isHidden = true
                self.labelTelefono.isHidden = true
                self.labelOficina.isHidden = true
                self.labelAnexo.isHidden = true
                self.labelHorario.isHidden = true
                
                self.tableViewHorario.isHidden = true
                
                self.tutorCode.isHidden = true
                self.tutorName.isHidden = true
                self.tutorEmail.isHidden = true
                self.tutorPhoneNumber.isHidden = true
                self.tutorOffice.isHidden = true
                self.tutorAnexo.isHidden = true
                
                
                //Se envia el mensaje de error
                let alert : UIAlertController = UIAlertController.init(title: "Sin tutor asignado", message: "Usted no cuenta con un tutor asignado", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
            
            }
        })


    }
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewWillAppear(_ animated: Bool) {

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadData() {
        tutorCode.text=tutorC?.codigo
        
        tutorName.text=(tutorC?.nombre)! + " " + (tutorC?.apellidoPaterno)! + " " + (tutorC?.apellidoMaterno)!
        tutorEmail.text=tutorC?.correo
        tutorPhoneNumber.text=tutorC?.telefono
        tutorOffice.text=tutorC?.oficina
        tutorAnexo.text=tutorC?.anexo

        
        print("dia Lunes")
        for d in ((self.parent as! NavigationControllerC).horasL){
            print(d)
            hLu[d-7] = "O"
        }
        print("dia Martes")
        for d in ((self.parent as! NavigationControllerC).horasMa) {
            print(d)
            hMa[d-7] = "O"
        }
        print("dia Miercoles")
        for d in ((self.parent as! NavigationControllerC).horasMi) {
            print(d)
            hMi[d-7] = "O"
        }
        print("dia Jueves")
        for d in ((self.parent as! NavigationControllerC).horasJ) {
            print(d)
            hJu[d-7] = "O"
        }
        print("dia Viernes")
        for d in ((self.parent as! NavigationControllerC).horasV) {
            print(d)
            hVi[d-7] = "O"
        }
        print("dia Sabado")
        for d in ((self.parent as! NavigationControllerC).horasS) {
            print(d)
            hSa[d-7] = "O"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horasCitas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = self.tableViewHorario.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellScheduleTutor
        
        cell.hora.text = horasCitas[indexPath.row]
        cell.hL.text = hLu[indexPath.row]
        cell.hMa.text = hMa[indexPath.row]
        cell.hMi.text = hMi[indexPath.row]
        cell.hJ.text = hJu[indexPath.row]
        cell.hV.text = hVi[indexPath.row]
        cell.hS.text = hSa[indexPath.row]
        
        
        return cell
    }
    

 

}
