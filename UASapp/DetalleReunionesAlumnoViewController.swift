//
//  DetalleReunionesAlumnoViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class DetalleReunionesAlumnoViewController: UIViewController {
 var cadena:String = "ho"
 var reunion:PspReunionesAlumnos?
    
    @IBOutlet weak var idReunionDetalle: UILabel!
    
    @IBOutlet weak var supervisor: UILabel!
    @IBOutlet weak var fechaReunion: UILabel!
    
    @IBOutlet weak var horaInicio: UILabel!
    
    @IBOutlet weak var horaFin: UILabel!
    
    @IBOutlet weak var lugar: UILabel!
    
    @IBOutlet weak var retroalimentacion: UITextView!
    @IBOutlet weak var observaciones: UITextView!
    @IBOutlet weak var estado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Reunion escogida Alumno:",cadena)
        // Do any additional setup after loading the view.
        idReunionDetalle.text = String(reunion!.idMeeting)
        supervisor.text = (reunion!.supervisor?.nombres)! + " " + (reunion!.supervisor?.apellido_paterno)!
        fechaReunion.text = reunion?.fecha
        horaInicio.text = reunion?.hora_inicio
        horaFin.text = reunion?.hora_fin
        lugar.text = reunion?.lugar
        estado.text=reunion?.idTipoEstado
        observaciones.text=reunion?.observaciones
        retroalimentacion.text=reunion?.retroalimentacion
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
