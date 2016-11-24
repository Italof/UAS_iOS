//
//  PspAlumnosSupervisorTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspAlumnosSupervisorTableViewController: UITableViewController {
        
        var d1 :UILabel  = UILabel()
        let kSectionCount: Int = 1
        let kRedSection: Int = 0
        var ele:Int = 0
        var redFlowers: [String] = ["Juan","Diego","Luis"]
        let subtitlesArray: [String] = ["20123136","20123137","20123136"]
        var reunionesSupervisor: [PspReuniones] = []
        var supervisor: Supervisor?
        var alumnos:[Alumnos] = []
        var alumnosPsp:[PspStudent] = []
        var pspDarray:[PspDocuments] = []
        var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
        // var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
        
        var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
        var getGroups: String = "psp/getSS"
        
        
        override func viewDidAppear(_ animated: Bool) {
            reunionesSupervisor = []
            alumnos = []
            alumnosPsp = []
            pspDarray = []
            self.tableView.reloadData()
            
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
                    
                    let validDictionary1 = data2?["alumpsp"]
                    let validDictionary2 = data2?["alum"]
                    
                    
                    
                    print("********************* ",validDictionary1)
                    
                    var arregloDoc = validDictionary1! as! NSArray
                    var arregloDoc2 = validDictionary2! as! NSArray
                    
                    if(arregloDoc.count-1>=0){
                        for index in 0...(arregloDoc.count-1){
                            let y = arregloDoc[index]
                            let y2 = arregloDoc2[index]
                            var pspStudentT:PspStudent? = nil
                            var alumT:Alumnos? = nil
                            var alumnoDiccionario = y as! Dictionary<String, AnyObject>
                            var alumnoDiccionario2 = y2 as! Dictionary<String, AnyObject>
                           
                            
                            var created_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                            var updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                            var deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                            
                            let idtipoestado: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idtipoestado")
                            let idpspgroup: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idpspgroup")
                            let idsupervisor = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idsupervisor")
                            var idpspprocess = self.isNullString(jsonResult:alumnoDiccionario,identificador: "idpspprocess")
                            let idespecialidad = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idespecialidad")
                            
                          
                            
                            let id:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                            let idalumno:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"idalumno")!
                            
                            pspStudentT=PspStudent(id:id,idalumno:idalumno,idespecialidad: idespecialidad,idpspgroup:idpspgroup,idpspprocess: idpspprocess,idsupervisor: idsupervisor,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at,idtipoestado:idtipoestado)
                            
                          //  pspStudentT=PspStudent(id: alumnoDiccionario["id"]! as! Int,idalumno:alumnoDiccionario["idalumno"]! as! Int,idespecialidad: idespecialidad,idpspgroup:idpspgroup,idpspprocess: idpspprocess,idsupervisor: idsupervisor,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at,idtipoestado:idtipoestado)
                            
                            
                            let ApellidoMaterno: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "ApellidoMaterno")
                            let ApellidoPaterno: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "ApellidoPaterno")
                            let Codigo: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "Codigo")
                            let IdUsuario: Int? = self.isNullInt(jsonResult:alumnoDiccionario2,identificador: "IdUsuario")
                            let Nombre: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "Nombre")
                            
                            let idAlumno: Int? = self.isNullInt(jsonResult:alumnoDiccionario2,identificador: "IdAlumno")
                            
                            let idHorario: Int? = self.isNullInt(jsonResult:alumnoDiccionario2,identificador: "IdHorario")
                            
                            let lleva_psp: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "lleva_psp")
                            
                            created_at = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "created_at")
                            deleted_at = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "deleted_at")
                            updated_at = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "updated_at")
                            
                            
                            
                            alumT=Alumnos(ApellidoMaterno:ApellidoMaterno,ApellidoPaterno:ApellidoPaterno,Codigo:Codigo,IdUsuario:IdUsuario,Nombre:Nombre,idAlumno:idAlumno!,idHorario:idHorario,lleva_psp:lleva_psp,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                            
                            
                            self.alumnos.append(alumT!)
                            self.alumnosPsp.append(pspStudentT!)
                            
                        }
                        self.tableView.reloadData()
                    }
                }
            })
            
            
        }
        override func viewDidLoad() {
            super.viewDidLoad()
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
        
        // MARK: - Table view data source
        
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return kSectionCount
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return alumnos.count
        }
        
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section{
            case kRedSection: return "Alumnos ha cargo"
            //case kRedSection: return "Grupos Disponibles"
            default: return "Unknown"
            }
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reuniones")! as UITableViewCell
                cell.textLabel!.text=self.alumnos[indexPath.row].Nombre
                cell.detailTextLabel!.text=self.alumnos[indexPath.row].Codigo
            return cell
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "det" {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    if  let destinationVC = (segue.destination) as? PspSupervisorDocumentosAlumnosTableViewController
                    {
                        
                        destinationVC.alumno = self.alumnos[indexPath.row]
                    }
                }
            }
            
        }
        
        
        /*
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
         
         // Configure the cell...
         
         return cell
         }
         */
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
