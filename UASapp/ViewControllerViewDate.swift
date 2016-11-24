//
//  ViewControllerViewDate.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerViewDate: UIViewController {
    
    //Contenido
    @IBOutlet weak var codigo: UILabel!
    @IBOutlet weak var estadoC: UILabel!
    
    @IBOutlet weak var alumnoOtutor: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var lugar: UILabel!
    @IBOutlet weak var tema: UILabel!
    @IBOutlet weak var infoExtra: UILabel!
    @IBOutlet weak var observaciones: UILabel!
    
    
    //Etiquetas
    @IBOutlet weak var labelAlumnoOtutor: UILabel!
    
    //Botones
    @IBOutlet weak var botonAtender: UIButton!

    @IBOutlet var botonCancelar: UIButton!
    
    @IBOutlet var botonNoAtender: UIButton!
    
    @IBOutlet var botonConfirmar: UIButton!
    
    @IBOutlet var botonRechazar: UIButton!
    
    
    /*
     Pendiente ----1
     Confirmada ---2
     Cancelada ----3
     Sugerida -----4
     Rechazada ----5
     Asistida -----6
     No asistida --7
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        print("rol es")
        print(rol)
        
        if (rol == "A"){
            labelAlumnoOtutor.text = "Tutor:"
            botonAtender.isHidden = true
            botonNoAtender.isHidden = true
            
            
        }
        if (rol == "T"){
            labelAlumnoOtutor.text = "Alumno:"
        }
        
        
        let citaO = ((self.parent as! NavigationControllerC).citEsc)
        
        print(citaO?.idEstado)
        
        //Visibilidad de los botones de cambio de estados y segun el usuario
        

        if (rol == "A"){
            //Pendiente
            if (citaO?.estado == "Pendiente"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
            }
            //Confirmada
            if (citaO?.estado == "Confirmada"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = false
                botonRechazar.isHidden = true
            }
            //Cancelada
            if (citaO?.estado == "Cancelada"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
            }
            //Sugerida
            if (citaO?.estado == "Sugerida"){
                botonConfirmar.isHidden = false
                botonCancelar.isHidden = true
                botonRechazar.isHidden = false
            }
            //Rechazada
            if (citaO?.estado == "Rechazada"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                
            }
            //Asistida
            if (citaO?.estado == "Asistida"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                
            }
            //No asistida
            if (citaO?.estado == "No asistida"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
            }
        }
        
        if (rol == "T"){
            //Pendiente
            if (citaO?.estado == "Pendiente"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                botonAtender.isHidden = true
                botonNoAtender.isHidden = true
            }
            //Confirmada
            if (citaO?.estado == "Confirmada"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = false
                botonRechazar.isHidden = true
                botonAtender.isHidden = false
                botonNoAtender.isHidden = false
            }
            //Cancelada
            if (citaO?.estado == "Cancelada"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                botonAtender.isHidden = true
                botonNoAtender.isHidden = true
            }
            //Sugerida
            if (citaO?.estado == "Sugerida"){
                botonConfirmar.isHidden = false
                botonCancelar.isHidden = true
                botonRechazar.isHidden = false
                botonAtender.isHidden = true
                botonNoAtender.isHidden = true
            }
            //Rechazada
            if (citaO?.estado == "Rechazada"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                botonAtender.isHidden = true
                botonNoAtender.isHidden = true
            }
            //Asistida
            if (citaO?.estado == "Asistida"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                botonAtender.isHidden = true
                botonNoAtender.isHidden = true
            }
            //No asistida
            if (citaO?.estado == "No asistida"){
                botonConfirmar.isHidden = true
                botonCancelar.isHidden = true
                botonRechazar.isHidden = true
                botonAtender.isHidden = true
                botonNoAtender.isHidden = true
            }
            //botonAtender.isHidden = false
        }
        
        
        
        ///Jalar del API toda la info necesaria de la cita
        //Esto de aca es chancho
        codigo.text = citaO?.citaId
        estadoC.text = citaO?.estado
        if (rol == "A"){
            alumnoOtutor.text = citaO?.tutor
        }
        if (rol == "T"){
            alumnoOtutor.text = citaO?.alumno
        }
        fecha.text = citaO?.fechaI
        hora.text = citaO?.horaI
        lugar.text = citaO?.lugar
        tema.text = citaO?.tema
        infoExtra.text = citaO?.infoExtra
        observaciones.text = citaO?.observaciones
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelarCita(_ sender: AnyObject) {        
        ((self.parent as! NavigationControllerC).citaCanRec) = "C"
        self.performSegue(withIdentifier: "SegueCRCita", sender: self)
    }

    
    @IBAction func rechazarCita(_ sender: AnyObject) {
        ((self.parent as! NavigationControllerC).citaCanRec) = "R"
        self.performSegue(withIdentifier: "SegueCRCita", sender: self)
    }
    @IBAction func confirmarCita(_ sender: AnyObject) {
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        if (rol == "A"){
            let c = ((self.parent as! NavigationControllerC).citEsc)
            let mens = "Esta a punto de confirmar una cita con su tutor para el " + (c?.fechaI)! + " a las "
            let m = mens + (c?.horaI)! + ". ¿Desea continuar?"
            let alert : UIAlertController = UIAlertController.init(title: "Confirmación de cita", message: m, preferredStyle: .alert)
            let actionNo = UIAlertAction(title: "No", style: .destructive, handler: nil)
            let actionSi = UIAlertAction(title: "Si", style: .default, handler: { action in
                //Aca se invoca el api de
                
                let alert2 : UIAlertController = UIAlertController.init(title: "Confirmación de cita", message: "Se realizó la confirmación de cita exitosamente", preferredStyle: .alert)
                let actionX = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert2.addAction(actionX)
                self.present(alert2,animated: true, completion:nil)
            })
            
            alert.addAction(actionNo)
            alert.addAction(actionSi)
            self.present(alert,animated: true, completion:nil)
            
        }
        if (rol == "T"){
            
            self.performSegue(withIdentifier: "SegueConfCita", sender: self)
            
        }
    }
    
    
    @IBAction func atenderCita(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "SegueAtenderCita", sender: self)
        
    }
    

}
