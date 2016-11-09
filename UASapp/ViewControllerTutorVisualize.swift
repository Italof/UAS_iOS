//
//  ViewControllerTutorVisualize.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerTutorVisualize: UIViewController {
    
    
    @IBOutlet var tutorCode: UILabel!
    
    @IBOutlet var tutorName: UILabel!
    
    @IBOutlet var tutorEmail: UILabel!
    
    @IBOutlet var tutorPhoneNumber: UILabel!
    
    @IBOutlet var tutorOffice: UILabel!
    
    @IBOutlet var tutorAnexo: UILabel!
    
    @IBOutlet weak var horaL: UILabel!
    @IBOutlet weak var horaMa: UILabel!
    @IBOutlet weak var horaMi: UILabel!
    @IBOutlet weak var horaJ: UILabel!
    @IBOutlet weak var horaV: UILabel!
    ////////
    @IBOutlet weak var labelCodigo: UILabel!
    @IBOutlet weak var labelNombresyAp: UILabel!
    @IBOutlet weak var labelCorreo: UILabel!
    @IBOutlet weak var labelTelefono: UILabel!
    @IBOutlet weak var labelOficina: UILabel!
    @IBOutlet weak var labelAnexo: UILabel!
    @IBOutlet weak var labelHorario: UILabel!
    
    
    
    
    
    @IBOutlet weak var botonNuevaCita: UIButton!
    
    var tutorC: tutor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Estos labels serán alimentados por la info del tutor del alumno
        
        

        
        
        //tutorC = consultarMitutor()
        
        
        
        ///////////////////////////////////////////////////////////////
       
        //tutorC = ((self.parent as! NavigationControllerC).tutorOb)
        
        tutorCode.text=tutorC?.codigo
        tutorName.text=tutorC?.nombre
        tutorEmail.text=tutorC?.correo
        tutorPhoneNumber.text=tutorC?.telefono
        tutorOffice.text=tutorC?.oficina
        tutorAnexo.text=tutorC?.anexo
        
        horaL.text=tutorC?.horarioL
        horaMa.text=tutorC?.horarioMa
        horaMi.text=tutorC?.horarioMi
        horaJ.text=tutorC?.horarioJ
        horaV.text=tutorC?.horarioV
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //tutorC = ((self.parent as! NavigationControllerC).tutorOb)
        
        tutorCode.text=tutorC?.codigo
        tutorName.text=tutorC?.nombre
        tutorEmail.text=tutorC?.correo
        tutorPhoneNumber.text=tutorC?.telefono
        tutorOffice.text=tutorC?.oficina
        tutorAnexo.text=tutorC?.anexo
        
        horaL.text=tutorC?.horarioL
        horaMa.text=tutorC?.horarioMa
        horaMi.text=tutorC?.horarioMi
        horaJ.text=tutorC?.horarioJ
        horaV.text=tutorC?.horarioV
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
                            
                            horarioL = horarioL + " " + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "2") {
                            
                            horarioMa = horarioMa + " " + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "3") {
                            
                            horarioMi = horarioMi + " " + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "4") {
                            
                            horarioJ = horarioJ + " " + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
                        }
                        
                        if ( (diaHo["dia"] as! String) == "5") {
                            
                            horarioV = horarioV + " " + dateFormater.string(from: hI!) + "-" + dateFormater.string(from: hF!)
                            
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
                
                
                
                
                let tutorX : tutor = tutor.init(idDocente: idDocente, idEspecialidad: idEspecialidad, codigo: codigo, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, correo: correo, oficina: oficina, telefono: telefono, anexo: anexo, horarioL: horarioL, horarioMa: horarioMa, horarioMi: horarioMi, horarioJ: horarioJ, horarioV: horarioV )
                
                print("tutor consultado")
                print(tutorX.nombre! + " " + tutorX.apellidoPaterno! + " " + tutorX.apellidoMaterno!)
                self.tutorC = tutorX
                if (self.tutorC != nil){
                    
                    
                    
                    self.labelCodigo.isHidden = false
                    self.labelNombresyAp.isHidden = false
                    self.labelCorreo.isHidden = false
                    self.labelTelefono.isHidden = false
                    self.labelOficina.isHidden = false
                    self.labelAnexo.isHidden = false
                    self.labelHorario.isHidden = false
                    
                    self.horaL.isHidden = false
                    self.horaMa.isHidden = false
                    self.horaMi.isHidden = false
                    self.horaJ.isHidden = false
                    self.horaV.isHidden = false
                    
                    self.tutorCode.text=self.tutorC?.codigo
                    self.tutorName.text=self.tutorC?.nombre
                    self.tutorEmail.text=self.tutorC?.correo
                    self.tutorPhoneNumber.text=self.tutorC?.telefono
                    self.tutorOffice.text=self.tutorC?.oficina
                    self.tutorAnexo.text=self.tutorC?.anexo
                    
                    self.horaL.text=self.tutorC?.horarioL
                    self.horaMa.text=self.tutorC?.horarioMa
                    self.horaMi.text=self.tutorC?.horarioMi
                    self.horaJ.text=self.tutorC?.horarioJ
                    self.horaV.text=self.tutorC?.horarioV
                    
                } else {
                    
                }

            }
            else {
                
                print(error)
                
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
                
                self.horaL.isHidden = true
                self.horaMa.isHidden = true
                self.horaMi.isHidden = true
                self.horaJ.isHidden = true
                self.horaV.isHidden = true
                
                
                
                
                //Se envia el mensaje de error
                let alert : UIAlertController = UIAlertController.init(title: "Sin tutor asignado", message: "Usted no cuenta con un tutor asignado", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion:nil)
                
                
                
                //Mostrar error y regresar al menù principal
                
                /*
                 let alert : UIAlertController = UIAlertController.init(title: "Sin tutor asignado", message: "Usted no cuenta con un tutor asignado", preferredStyle: .alert)
                 let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                 alert.addAction(action)
                 self.present(alert,animated: true, completion:nil)
                 */
                
            }
        })

        
        
        
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

}
