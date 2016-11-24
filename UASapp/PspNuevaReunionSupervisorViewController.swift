//
//  PspNuevaReunionSupervisorViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 20/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspNuevaReunionSupervisorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    @IBOutlet weak var fecha: UIDatePicker!
        
    @IBOutlet weak var tipo: UIPickerView!
    @IBOutlet weak var alumnos: UIPickerView!

        @IBOutlet weak var horaI: UIPickerView!
        

        
        //var arrayF = ["Viernes 28/10/2016","Sabado 29/10/2016"]
        var arrayStudent:[Alumnos] = []
        var arrayPspSudent:[PspStudent] = []
        var arrayTipo:[String] = ["Spervisor-Alumno","Supervisor-Jefe"]
        var arrayF:[String] = []
        var arrayFreeHour:[PspFreeHour] = []
        var arrayHi:[String] = ["8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00",
                                "16:00","17:00","18:00","19:00","20:00","21:00",]
        var supervisorA: Supervisor? = nil
    
        var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
        
        var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
        //var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
        var getGroups: String = "psp/sup/getStude"
    
        var getGroups2: String = "psp/sup/newMet"
        
        var indexFree:Int = 0
        var indexHoraI:Int = 0
        var indexAlum:Int = 0
        var indexTipo:Int = 0
    
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            if (pickerView .isEqual(alumnos)){
                return arrayStudent[row].Nombre!+" "+arrayStudent[row].ApellidoPaterno!+" "+arrayStudent[row].Codigo!
            }
            else  if (pickerView .isEqual(tipo)){
                return arrayTipo[row]
            }
            return arrayHi[row]
            
            
        }
        
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if (pickerView .isEqual(alumnos)){
                return arrayStudent.count
            }
            else if(pickerView .isEqual(tipo)){
                return arrayTipo.count
            }

            return arrayHi.count
            
            
            
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if (pickerView .isEqual(alumnos)){
                print("selected ",row)
                self.indexAlum = row
            }
            else if (pickerView .isEqual(tipo)){
                print("selected ",row)
                self.indexTipo = row
            }
            else{
                self.indexHoraI = row
            }
            
            
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
           // DateThemesList.delegate=self
          //  DateThemesList.dataSource=self
            horaI.delegate=self
            horaI.dataSource=self
            
            alumnos.delegate=self
            alumnos.dataSource=self
            
            tipo.dataSource=self
            tipo.delegate=self
            
            
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
                    
                    let validDictionary1 = data2?["PspStudents"]
                    let validDictionary2 = data2?["Students"]
                    var xp = validDictionary1! as! NSArray
                    var x = validDictionary2! as! NSArray
                    
                    for index in 0...(x.count-1){
                    var alumnoT:Alumnos? = nil
                    var pspStudentT:PspStudent? = nil
                    let alumnoComparar = x[index]
                    var alumnoDiccionario = alumnoComparar as! Dictionary<String, AnyObject>
                    
                    
                    let ApellidoMaterno: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "ApellidoMaterno")
                    let ApellidoPaterno: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "ApellidoPaterno")
                    let Codigo: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "Codigo")
                    let IdUsuario: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "IdUsuario")
                    let Nombre: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "Nombre")
                    
                    let idAlumno: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "IdAlumno")
                    
                    let idHorario: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "IdHorario")
                    
                    let lleva_psp: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "lleva_psp")
                    
                    var created_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                    var deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                    var updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                    
    
                        
                    alumnoT=Alumnos(ApellidoMaterno:ApellidoMaterno,ApellidoPaterno:ApellidoPaterno,Codigo:Codigo,IdUsuario:IdUsuario,Nombre:Nombre,idAlumno:idAlumno!,idHorario:idHorario,lleva_psp:lleva_psp,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
                        
                        let alumnoComparar2 = xp[index]
                        
                        
                        alumnoDiccionario = alumnoComparar2 as! Dictionary<String, AnyObject>
                        created_at = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                        updated_at = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                        deleted_at = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                        
                        let idtipoestado: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idtipoestado")
                        let idpspgroup: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idpspgroup")
                        let idsupervisor = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idsupervisor")
                        var idpspprocess = self.isNullString(jsonResult:alumnoDiccionario,identificador: "idpspprocess")
                        let idespecialidad = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idespecialidad")
                        
                        let idd:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                        let idalumno:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"idalumno")!
                        
                        pspStudentT=PspStudent(id:idd,idalumno:idalumno,idespecialidad: idespecialidad,idpspgroup:idpspgroup,idpspprocess: idpspprocess,idsupervisor: idsupervisor,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at,idtipoestado:idtipoestado)
                        
                        
                        self.arrayStudent.append(alumnoT!)
                        self.arrayPspSudent.append(pspStudentT!)
                    }
                    
                    //   self.DateThemesList.reloadAllComponents()
                     self.alumnos.reloadAllComponents()
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
    
    
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
        @IBAction func dismiss(_ sender: AnyObject) {
            
            
            
            let routeApi =  getGroups2 + "/?token=" + token
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var selectedDate = dateFormatter.string(from: fecha.date)
            
            dateFormatter.dateFormat = "dd MMM yyyy"
  
            /*    let json = NSMutableDictionary()
             json.setValue( self.reunion!.observaciones = ""+self.observaciones.text, forKey: "observaciones")
             json.setValue(self.reunion!.asistencia, forKey: "asistencia")
             */
            var idTipo: Int=0
            if(indexTipo==0)
            {
                idTipo=1
            }
            else{
                idTipo=2
            }
            
            var horaFin: String = ""
            
            if(self.arrayHi[indexHoraI]=="21:00")
            {
                horaFin="22:00"
            }
            else{
                horaFin=self.arrayHi[indexHoraI+1]
            }
            
            let validDictionary = ["hora_inicio": self.arrayHi[indexHoraI],"hora_fin": horaFin,"fecha":selectedDate,"lugar":"","IdUsuario":self.arrayPspSudent[indexAlum].id,"Tipo":idTipo] as [String : Any]
            
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

