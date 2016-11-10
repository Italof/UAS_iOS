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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if (rol == "A"){
            labelAlumnoOtutor.text = "Tutor:"
            botonAtender.isHidden = true
        }
        if (rol == "T"){
            labelAlumnoOtutor.text = "Alumno:"
        }
        
        
        let citaO = ((self.parent as! NavigationControllerC).citEsc)
        
        
        ///Jalar del API toda la info necesaria de la cita
        //Esto de aca es chancho
        codigo.text = citaO?.citaId
        estadoC.text = citaO?.estado
        alumnoOtutor.text = citaO?.alumno
        fecha.text = citaO?.fechaI
        hora.text = citaO?.horaI
        tema.text = citaO?.tema
 
        /*
        codigo.text = "u"
        alumnoOtutor.text = "e"
        fecha.text = "r"
        hora.text = "d"
        tema.text = " c"
 */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
