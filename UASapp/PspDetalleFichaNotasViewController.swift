//
//  PspDetalleFichaNotasViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspDetalleFichaNotasViewController: UIViewController {

    var detalleFicha:PspInscription?
    var id:Int?
    @IBOutlet weak var actividadFormativa: UILabel!
    @IBOutlet weak var actividadEconomica: UILabel!
    @IBOutlet weak var condicionesSeguridad: UILabel!
    @IBOutlet weak var correoJefe: UILabel!
    @IBOutlet weak var recomendaciones: UITextView!
    
    @IBOutlet weak var fechaIni: UILabel!
    @IBOutlet weak var fechaFin: UILabel!
    
    
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    //  var token: String  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQwLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDQyMDIsImV4cCI6MTQ4MDI2MDIwMiwibmJmIjoxNDc4OTA0MjAyLCJqdGkiOiI4ZmYzYWMyZGJiZGM5NmE4N2E2YmIzMTE3ZmI3ZTMxMiJ9.oQudox-lUtqOVAXpBzuPeYHAxDtrfaB4PyWPvVbdYkk"
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/getINota/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let routeApi = getGroups+""+String(id!)+"?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if error != nil {
                print(error)
            } else {
                // let question = data!["question"] as? String
                // print("Question: \(question)")
                var data2: [String:AnyObject]?
                
                if let dictionary = data as? [String:Any] {
                    data2 = dictionary as [String:AnyObject]
                } else {
                    let array = data as? [Any]
                    data2 = array?.first as? [String:AnyObject]
                }
                
                let validDictionary1 = data2?["ins"]
                
                
                
                
                print("********************* ",validDictionary1)
                
          
                  
                
                    var alumnoDiccionario = validDictionary1!
                    
        /*
                    var Correo_jefe_directo:String = alumnoDiccionario["Correo_jefe_directo"]! as! String
                    var activ_formativas:String = alumnoDiccionario["activ_formativas"]! as! String
                    var actividad_economica:String = alumnoDiccionario["actividad_economica"]! as! String
                    var cond_seguridad_area:String = alumnoDiccionario["cond_seguridad_area"]! as! String
                    
                    var direccion_empresa:String = alumnoDiccionario["direccion_empresa"]! as! String
                    var distrito_empresa:String = alumnoDiccionario["distrito_empresa"]! as! String
                    var equi_del_practicante:String = alumnoDiccionario["equi_del_practicante"]! as! String
                    var equipamiento_area:String = alumnoDiccionario["equipamiento_area"]! as! String
                    var fecha_inicio:String = alumnoDiccionario["fecha_inicio"]! as! String
                    var fecha_recep_convenio:String = alumnoDiccionario["fecha_recep_convenio"]! as! String
                    var fecha_termino:String = alumnoDiccionario["fecha_termino"]! as! String
                    var id:Int = alumnoDiccionario["id"]! as! Int
                    var jefe_directo_aux:String = alumnoDiccionario["jefe_directo_aux"]! as! String
                    var nombre_area:String = alumnoDiccionario["nombre_area"]! as! String
                    var personal_area:String = alumnoDiccionario["personal_area"]! as! String
                    var puesto:String = alumnoDiccionario["puesto"]! as! String
                    var razon_social:String = alumnoDiccionario["razon_social"]! as! String
                    var recomendaciones:String = alumnoDiccionario["recomendaciones"]! as! String
                    var telef_jefe_directo:String = alumnoDiccionario["telef_jefe_directo"]! as! String
                    var tiene_convenio:Int = alumnoDiccionario["tiene_convenio"]! as! Int
                    var ubicacion_area:String = alumnoDiccionario["ubicacion_area"]! as! String
             */       
                    
                    let created_at: String? = self.isNullString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>,identificador: "created_at")
                    let updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>,identificador: "updated_at")
                    let deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>,identificador: "deleted_at")
                    
                let Correo_jefe_directo:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"Correo_jefe_directo")!
                let activ_formativas:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"activ_formativas")!
                let actividad_economica:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"actividad_economica")!
                let cond_seguridad_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"cond_seguridad_area")!
                let direccion_empresa:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"direccion_empresa")!
                
                let distrito_empresa:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"distrito_empresa")!
                
                let equi_del_practicante:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"equi_del_practicante")!
                
                let equipamiento_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"equipamiento_area")!
                
                let fecha_inicio:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"fecha_inicio")!
                
                let fecha_recep_convenio:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"fecha_recep_convenio")!
                let fecha_termino:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"fecha_termino")!
                
                let id:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"id")!
                
                let jefe_directo_aux:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"jefe_directo_aux")!
                
                let nombre_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"nombre_area")!
                
                let personal_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"personal_area")!
                
                let puesto:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"puesto")!
                
                let razon_social:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"razon_social")!
                
                let recomendaciones:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"recomendaciones")!
                
                let telef_jefe_directo:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"telef_jefe_directo")!
                
                let tiene_convenio:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"tiene_convenio")!
                
                let ubicacion_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario as! Dictionary<String, AnyObject>, identificador:"ubicacion_area")!
                
                
                
                
               self.detalleFicha = PspInscription(Correo_jefe_directo:Correo_jefe_directo,activ_formativas:activ_formativas,actividad_economica:actividad_economica,cond_seguridad_area:cond_seguridad_area,direccion_empresa:direccion_empresa,distrito_empresa:distrito_empresa,equi_del_practicante:equi_del_practicante,equipamiento_area:equipamiento_area,fecha_inicio:fecha_inicio,fecha_recep_convenio:fecha_recep_convenio,fecha_termino:fecha_termino,id:id,jefe_directo_aux:jefe_directo_aux,nombre_area:nombre_area,personal_area:personal_area,puesto:puesto,razon_social:razon_social,recomendaciones:recomendaciones,telef_jefe_directo:telef_jefe_directo,tiene_convenio:tiene_convenio,ubicacion_area:ubicacion_area,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                
                
                   // self.detalleFicha = PspInscription(Correo_jefe_directo:alumnoDiccionario["Correo_jefe_directo"]! as! String,activ_formativas:alumnoDiccionario["activ_formativas"]! as! String,actividad_economica:alumnoDiccionario["actividad_economica"]! as! String,cond_seguridad_area:alumnoDiccionario["cond_seguridad_area"]! as! String,direccion_empresa:alumnoDiccionario["direccion_empresa"]! as! String,distrito_empresa:alumnoDiccionario["distrito_empresa"]! as! String,equi_del_practicante:alumnoDiccionario["equi_del_practicante"]! as! String,equipamiento_area:alumnoDiccionario["equipamiento_area"]! as! String,fecha_inicio:alumnoDiccionario["fecha_inicio"]! as! String,fecha_recep_convenio:alumnoDiccionario["fecha_recep_convenio"]! as! String,fecha_termino:alumnoDiccionario["fecha_termino"]! as! String,id:alumnoDiccionario["id"]! as! Int,jefe_directo_aux:alumnoDiccionario["jefe_directo_aux"]! as! String,nombre_area:alumnoDiccionario["nombre_area"]! as! String,personal_area:alumnoDiccionario["personal_area"]! as! String,puesto:alumnoDiccionario["puesto"]! as! String,razon_social:alumnoDiccionario["razon_social"]! as! String,recomendaciones:alumnoDiccionario["recomendaciones"]! as! String,telef_jefe_directo:alumnoDiccionario["telef_jefe_directo"]! as! String,tiene_convenio:alumnoDiccionario["tiene_convenio"]! as! Int,ubicacion_area:alumnoDiccionario["ubicacion_area"]! as! String,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
                    
                    self.actividadFormativa.text = self.detalleFicha!.activ_formativas
                    self.actividadEconomica.text = self.detalleFicha!.actividad_economica
                    self.condicionesSeguridad.text = self.detalleFicha!.nombre_area
                    self.correoJefe.text = self.detalleFicha!.Correo_jefe_directo
                    self.recomendaciones.text=self.detalleFicha!.recomendaciones
                self.fechaIni.text=self.detalleFicha!.fecha_inicio
                self.fechaFin.text=self.detalleFicha!.fecha_termino
                
            }
        })

        
        
        
        
 
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isNullInt(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> Int?
    {
        var entero: Int?
        if let id = jsonResult[identificador] as? NSNull {
            entero=nil
        }
        else{
            // entero = jsonResult[identificador]! as! Int
            entero = castDefinidoInt(jsonResult: jsonResult, identificador: identificador)
        }
        return entero
    }
    
    func isNullString(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> String?
    {
        print("identidaaaaaaa:::::::::::",identificador)
        var cadena: String?
        if let id = jsonResult[identificador] as? NSNull {
            cadena=nil
        }
        else{
            cadena = castDefinidoString(jsonResult: jsonResult, identificador: identificador)
        }
        return cadena
    }
    
    
    func castDefinidoString(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> String?
    {var cadena: String?
        if let result_number = jsonResult[identificador] as? String //Puede ser un String
        {
            cadena = ((jsonResult[identificador]!) as! String)
        }
        else{ //No puede ser un String
            cadena = String(((jsonResult[identificador]!) as! Int))
        }
        
        return cadena
    }
    
    
    
    func castDefinidoInt(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> Int?
    {var cadena:Int?
        if let result_number = jsonResult[identificador] as? String //Puede ser un String
        {
            cadena = Int(((jsonResult[identificador]!) as! String))
        }
        else{ //No puede ser un String
            cadena = ((jsonResult[identificador]!) as! Int)
        }
        
        return cadena
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
