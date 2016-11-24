//
//  DetalleReunionesViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class DetalleReunionesViewController: UIViewController, UITextViewDelegate {
    var reunion:PspReuniones?

    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var observaciones: UITextView!


    @IBOutlet weak var idAlumno: UILabel!
    @IBOutlet weak var nombreAlumno: UILabel!
   
    @IBOutlet weak var obser: UITextView!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var horaInicio: UILabel!
    @IBOutlet weak var horaFin: UILabel!
    @IBOutlet weak var tipoReunion: UILabel!
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    let screenSize: CGRect = UIScreen.main.bounds
  // var token: String  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQwLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDQyMDIsImV4cCI6MTQ4MDI2MDIwMiwibmJmIjoxNDc4OTA0MjAyLCJqdGkiOiI4ZmYzYWMyZGJiZGM5NmE4N2E2YmIzMTE3ZmI3ZTMxMiJ9.oQudox-lUtqOVAXpBzuPeYHAxDtrfaB4PyWPvVbdYkk"
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/sup/asistio/"
    



  var cadena:String = "ho"
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         observaciones.delegate = self
         obser.delegate = self
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        print("Reunion escogida: ",cadena)
        var codigo:String
        if let c = reunion!.alumno!.Codigo{
            codigo = reunion!.alumno!.Codigo!
        }
        else{
            codigo = ""
        }
        idAlumno.text = String(codigo)
        nombreAlumno.text = (reunion!.alumno?.Nombre)! + " " + (reunion!.alumno?.ApellidoPaterno)!
        
        
        observaciones.text=reunion!.retroalimentacion
        obser.text=reunion!.observaciones
        
        fecha.text = reunion!.fecha
        horaInicio.text = reunion!.hora_inicio
        horaFin.text = reunion!.hora_fin
        //theScroller.contentSize=CGSize(width: 400, height: 1000)
        // Do any additional setup after loading the view.
        estado.text = reunion!.idTipoEstado
        if(reunion!.tipoReunion!==1)
        {
            tipoReunion.text="Supervisor - Alumno"
        }
        else{
            tipoReunion.text="Supervisor - Jefe"
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        //  dismissViewControllerAnimated(true,completion:nil)
        
        reunion!.observaciones = ""+obser.text
        reunion!.retroalimentacion=""+observaciones.text
        
        let routeApi =  getGroups + String(reunion!.idMeeting)+"/sendE?token=" + token
        let validDictionary = ["observaciones": self.reunion!.retroalimentacion,"asistencia": self.reunion!.asistencia,"obser": self.reunion!.observaciones] as [String : Any]
        
            HTTPHelper.post(route: routeApi, authenticated: true, body: validDictionary as [String : AnyObject]?, completion: { (error, responseData) in
                if error != nil {
                    print(error)
                } else {
                    print("REQUESTED RESPONSE: \(responseData)")
                }
                
            })

        navigationController?.popViewController(animated: true)
        
      
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
