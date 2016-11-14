//
//  ReunionesTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
// as! NSArray

import UIKit

class ReunionesTableViewController: UITableViewController {
    var d1 :UILabel  = UILabel()
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var ele:Int = 0
    var redFlowers: [String] = ["Juan","Diego","Luis"]
    let subtitlesArray: [String] = ["20123136","20123137","20123136"]
    var reunionesSupervisor: [PspReuniones] = []
    var supervisor: Supervisor?
    var alumnos:[Alumnos] = []
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String

      // var token: String  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQwLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDQyMDIsImV4cCI6MTQ4MDI2MDIwMiwibmJmIjoxNDc4OTA0MjAyLCJqdGkiOiI4ZmYzYWMyZGJiZGM5NmE4N2E2YmIzMTE3ZmI3ZTMxMiJ9.oQudox-lUtqOVAXpBzuPeYHAxDtrfaB4PyWPvVbdYkk"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/sup/getMetting"
    
    
    override func viewDidAppear(_ animated: Bool) {
        reunionesSupervisor = []
        alumnos = []
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
 
                let validDictionary1 = data2?["Metting"]
                // let validDictionary2 = data?["Supervisor"]
                
                let validDictionary2 = data2?["Students"]
                
                
                print("********************* ",validDictionary2)
                
                
                var x = validDictionary1! as! NSArray
                print("indexx: ",x.count-1)
                let alumnoCantidad = validDictionary2! as! NSArray
                if(x.count-1 > -1){
                for index in 0...(x.count-1){
                    let y = x[index]
                    var reunionesSupervisorTemporal: PspReuniones
                    var alumnoT:Alumnos? = nil
                    var reunionValida:Int = 0
                    var jsonResult = y as! Dictionary<String, AnyObject>

                    var idStudent: Int = jsonResult["idstudent"]! as! Int
                 //ver el casos student sin supervisor
                    for indexA in 0...(alumnoCantidad.count-1){

                        let alumnoComparar = alumnoCantidad[indexA]
                        
                        var alumnoDiccionario = alumnoComparar as! Dictionary<String, AnyObject>
                        
                        if(idStudent==alumnoDiccionario["IdAlumno"]! as! Int)
                        {
                            let ApellidoMaterno: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "ApellidoMaterno")
                            let ApellidoPaterno: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "ApellidoPaterno")
                            let Codigo: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "Codigo")
                            let IdUsuario: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "IdUsuario")
                            let Nombre: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "Nombre")
                            
                            let idAlumno: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "IdAlumno")
                            
                            let idHorario: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "IdHorario")
                            
                            let lleva_psp: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "lleva_psp")
                            
                            let created_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                            let deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                            let updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                   
                            
                            
                            alumnoT=Alumnos(ApellidoMaterno:ApellidoMaterno,ApellidoPaterno:ApellidoPaterno,Codigo:Codigo,IdUsuario:IdUsuario,Nombre:Nombre,idAlumno:idAlumno!,idHorario:idHorario,lleva_psp:lleva_psp,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)

                            reunionValida=1
                            break
                        }
                        else{
                            reunionValida=0
                        }
                        
                    }
                    
      

                    let created_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                    let deleted_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                    let updated_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                    let idFreeHour:Int? = self.isNullInt(jsonResult:jsonResult,identificador: "idfreehour")
                    
                    
                    if(reunionValida==1){
                        reunionesSupervisorTemporal=PspReuniones(asistencia: jsonResult["asistencia"]! as! String,fecha: jsonResult["fecha"]! as! String,hora_fin: jsonResult["hora_fin"]! as! String,hora_inicio: jsonResult["hora_inicio"]! as! String,idFreeHour:idFreeHour, idMeeting: jsonResult["id"]! as! Int, idStudent: jsonResult["idstudent"]! as! Int,idSupervisor: jsonResult["idsupervisor"]! as! Int,idTipoEstado: jsonResult["idtipoestado"]! as! Int,lugar: jsonResult["lugar"]! as! String,observaciones: jsonResult["observaciones"]! as! String,retroalimentacion: jsonResult["retroalimentacion"]! as! String,tipoReunion: jsonResult["tiporeunion"]! as! Int,alumno: alumnoT!,created_at:created_at2,updated_at:updated_at2,deleted_at:deleted_at2)
                        
                        self.reunionesSupervisor.append(reunionesSupervisorTemporal)
                    }
                }
                self.tableView.reloadData()
                
                }
            }
        })
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reunionesSupervisor.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Reuniones Activas"
        //case kRedSection: return "Grupos Disponibles"
        default: return "Unknown"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reuniones")! as UITableViewCell
        
        switch (indexPath.section){
        case kRedSection:
            var idf:String
            /*
            if let c = self.reunionesSupervisor[indexPath.row].idFreeHour {
             idf = String(self.reunionesSupervisor[indexPath.row].idFreeHour!)
            }
            else{
                idf=""
            }
            */
            cell.textLabel!.text=String((self.reunionesSupervisor[indexPath.row].alumno?.Nombre)!+" "+(self.reunionesSupervisor[indexPath.row].alumno?.ApellidoPaterno)!)
            
            var codigo:String
            if let c = self.reunionesSupervisor[indexPath.row].alumno!.Codigo{
                codigo = self.reunionesSupervisor[indexPath.row].alumno!.Codigo!
            }
            else{
                 codigo = ""
            }
            
            cell.detailTextLabel!.text=codigo + " - " + self.reunionesSupervisor[indexPath.row].fecha!
            
        default:
            cell.textLabel!.text="Unknown"
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleReunionesS" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                if  let destinationVC = (segue.destination) as? DetalleReunionesViewController
                    // let destinationVC = segue.destination as? DetalleReunionesViewController
                {
                    var myString = String(indexPath.row)
                    destinationVC.cadena = myString
                    destinationVC.reunion = reunionesSupervisor[indexPath.row]
     
                }
                
                
                
            }
        }
        
    }
    
    
    @IBAction func dismiss(_ sender: AnyObject) {
        //  dismissViewControllerAnimated(true,completion:nil)
        navigationController?.popViewController(animated: true)
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
