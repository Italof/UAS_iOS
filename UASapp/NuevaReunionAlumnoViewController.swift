//
//  NuevaReunionAlumnoViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class NuevaReunionAlumnoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
 
    @IBOutlet weak var nombreSupervisor: UILabel!
    @IBOutlet weak var DateThemesList: UIPickerView!
    
    @IBOutlet weak var horaI: UIPickerView!
    
    @IBOutlet weak var lugar: UITextField!

    //var arrayF = ["Viernes 28/10/2016","Sabado 29/10/2016"]
    var arrayF:[String] = []
    var arrayFreeHour:[PspFreeHour] = []
    var arrayHi:[String] = []
    var supervisorA: Supervisor? = nil
   var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String

    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
     //var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    var getGroups: String = "psp/al/getfh"
    var getGroups2: String = "psp/al/setM/"
    
    var indexFree:Int = 0
    var indexHoraI:Int = 0
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView .isEqual(DateThemesList)){
        return arrayF[row]
        }
            return arrayHi[row]
        
    
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView .isEqual(DateThemesList)){
            return arrayF.count
        }
            return arrayHi.count
        
    
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView .isEqual(DateThemesList)){
            print("selected ",row)
            

            var count:Int = 0
            arrayHi = []
             if(arrayFreeHour.count-1>=0){
            for index in 0...(arrayFreeHour[row].cantidad-1){
                
                if(index==0){
                arrayHi.append(String(arrayFreeHour[row].hora_ini)+":00:00")
                count=arrayFreeHour[row].hora_ini+1
                }
                else{
                arrayHi.append(String(count)+":00:00")
                count = count+1
                }
    
            }
            self.indexFree = row
            self.horaI.reloadAllComponents()
            }
            
        }
        else{
            self.indexHoraI = row
        }

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DateThemesList.delegate=self
        DateThemesList.dataSource=self
        horaI.delegate=self
        horaI.dataSource=self
 
        
        let routeApi =  getGroups + "?token=" + token
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
                
                let validDictionary1 = data2?["Supervisor"]
                let validDictionary2 = data2?["FreeHour"]
               
                let created_at: String? = self.isNullString(jsonResult:validDictionary1 as! Dictionary<String, AnyObject>,identificador: "created_at")
                let deleted_at: String? = self.isNullString(jsonResult:validDictionary1 as! Dictionary<String, AnyObject>,identificador: "deleted_at")
                let updated_at: String? = self.isNullString(jsonResult:validDictionary1 as! Dictionary<String, AnyObject>,identificador: "updated_at")
                let idpspprocess:Int? = self.isNullInt(jsonResult:validDictionary1 as! Dictionary<String, AnyObject>,identificador: "idpspprocess")
                
                
                self.supervisorA = Supervisor(apellido_materno:validDictionary1!["apellido_materno"]! as! String,apellido_paterno: validDictionary1!["apellido_paterno"]! as! String,codigo_trabajador: validDictionary1!["codigo_trabajador"]! as! String,correo: validDictionary1!["correo"]! as! String,direccion: validDictionary1!["direccion"]! as! String,idEspecialidad: validDictionary1!["idfaculty"]! as! Int,idSupervisor: validDictionary1!["id"]! as! Int,idUsuario: validDictionary1!["iduser"]! as! Int,nombres: validDictionary1!["nombres"]! as! String,telefono:validDictionary1!["telefono"]! as! String,idpspprocess:idpspprocess,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                
                self.nombreSupervisor.text=self.supervisorA!.nombres+" "+self.supervisorA!.apellido_paterno
                
                var arregloFreeHour = validDictionary2! as! NSArray
                // yy
               
                if(arregloFreeHour.count-1>=0){
                for index in 0...(arregloFreeHour.count-1){
                    var pspFreeHourT:PspFreeHour? = nil
                    var jsonResult = arregloFreeHour[index] as! Dictionary<String, AnyObject>
                  
                    let created_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "created_at")
                    let deleted_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "deleted_at")
                    let updated_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "updated_at")
                    let idpspprocess:Int? = self.isNullInt(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "idpspprocess")
                    
                    pspFreeHourT = PspFreeHour(cantidad:jsonResult["cantidad"]! as! Int,fecha:jsonResult["fecha"]! as! String,hora_ini:jsonResult["hora_ini"]! as! Int,id:jsonResult["idsupervisor"]! as! Int,idsupervisor:jsonResult["id"]! as! Int,idpspprocess:idpspprocess,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
                   
                    self.arrayFreeHour.append(pspFreeHourT!)
                    self.arrayF.append(pspFreeHourT!.fecha)

                }
                
                self.DateThemesList.reloadAllComponents()
                
                var count:Int = 0
                self.arrayHi = []
                for index in 0...(self.arrayFreeHour[0].cantidad-1){
                    
                    if(index==0){
                        self.arrayHi.append(String(self.arrayFreeHour[0].hora_ini)+":00:00")
                        count=self.arrayFreeHour[0].hora_ini+1
                    }
                    else{
                        self.arrayHi.append(String(count)+":00:00")
                        count = count+1
                    }
                    
                }
                self.horaI.reloadAllComponents()
                }
                
            }
 
        })
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func isNullInt(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> Int?
    {
        var entero: Int?
        if let id = jsonResult[identificador] as? NSNull {
            entero=nil
        }
        else{
            entero = jsonResult[identificador]! as! Int
        }
        return entero
    }
    
    func isNullString(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> String?
    {
        var cadena: String?
        if let id = jsonResult[identificador] as? NSNull {
            cadena=nil
        }
        else{
            cadena = jsonResult[identificador]! as! String
        }
        return cadena
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        DateThemesList.delegate=self
        DateThemesList.dataSource=self
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
    
        
        
        let routeApi =  getGroups2 + String(self.arrayFreeHour[self.indexFree].id)+"/sendNr?token=" + token
        
        
        /*    let json = NSMutableDictionary()
         json.setValue( self.reunion!.observaciones = ""+self.observaciones.text, forKey: "observaciones")
         json.setValue(self.reunion!.asistencia, forKey: "asistencia")
         */
        let validDictionary = ["hora_inicio": self.arrayHi[indexHoraI],"hora_fin": self.arrayHi[indexHoraI],"fecha":arrayFreeHour[self.indexFree].fecha,"lugar":self.lugar!.text] as [String : Any]
        print("Dicnionary ...... ..... ****** ****** +***** ++++++  ..",validDictionary)

        
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
