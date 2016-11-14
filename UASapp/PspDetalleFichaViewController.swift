//
//  PspDetalleFichaViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 11/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspDetalleFichaViewController: UIViewController {
    var detalleFicha:PspInscription?
    
    @IBOutlet weak var actividadFormativa: UILabel!
    @IBOutlet weak var actividadEconomica: UILabel!
    @IBOutlet weak var condicionesSeguridad: UILabel!
    @IBOutlet weak var correoJefe: UILabel!
    @IBOutlet weak var recomendaciones: UITextView!
   var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
     //  var token: String  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQwLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDQyMDIsImV4cCI6MTQ4MDI2MDIwMiwibmJmIjoxNDc4OTA0MjAyLCJqdGkiOiI4ZmYzYWMyZGJiZGM5NmE4N2E2YmIzMTE3ZmI3ZTMxMiJ9.oQudox-lUtqOVAXpBzuPeYHAxDtrfaB4PyWPvVbdYkk"
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/sup/detf/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
actividadEconomica.text = detalleFicha!.activ_formativas
actividadEconomica.text = detalleFicha!.actividad_economica
        condicionesSeguridad.text = detalleFicha!.cond_seguridad_area
        correoJefe.text = detalleFicha!.Correo_jefe_directo
        recomendaciones.text=detalleFicha!.recomendaciones
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func dismiss(_ sender: AnyObject) {
        //  dismissViewControllerAnimated(true,completion:nil)
        
    
        let routeApi =  getGroups + String(detalleFicha!.id)+"?token=" + token
        detalleFicha!.recomendaciones=""+recomendaciones.text
          let validDictionary = ["recomendaciones": self.detalleFicha!.recomendaciones] as [String : Any]
        
        
        HTTPHelper.post(route: routeApi, authenticated: true, body: validDictionary as [String : AnyObject]?, completion: { (error, responseData) in
            if error != nil {
                print(error)
            } else {
                print("REQUESTED RESPONSE: \(responseData)")

            }
            
        })
        

     
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    

}
