//
//  ReunionesAlumnoTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ReunionesAlumnoTableViewController: UITableViewController {
    var d1 :UILabel  = UILabel()
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var ele:Int = 0
    let redFlowers: [String] = ["Supervisor - Jefe","Supervisor - Alumno"]
    let subtitlesArray: [String] = ["14/10/2016","13/10/2016"]
    
    var reunionesAlumno: [PspReunionesAlumnos] = []
    var supervisores:[Supervisor] = []
    
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String

    //var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/a/gm"
   
    override func viewDidAppear(_ animated: Bool) {
        reunionesAlumno = []
        supervisores = []
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
                
                let validDictionary1 = data2?["Meeting"]
                // let validDictionary2 = data?["Supervisor"]
                
                let validDictionary2 = data2?["Supervisor"]
                
                
                print("********************* ",validDictionary2)
                
                //x
                var arregloMetting = validDictionary1! as! NSArray
                // yy
                var arregloSupervisores = validDictionary2! as! NSArray
                
           
            
                if(arregloMetting.count-1 > -1){
                    for index in 0...(arregloMetting.count-1){
                        var reunionesAlumnoTemporal: PspReunionesAlumnos
                        var supervisorT:Supervisor? = nil
                        var jsonResult = arregloMetting[index] as! Dictionary<String, AnyObject>
                        var jsonResult2 = arregloSupervisores[index] as! Dictionary<String, AnyObject>

                        let created_at: String? = self.isNullString(jsonResult:jsonResult2,identificador: "created_at")
                        let deleted_at: String? = self.isNullString(jsonResult:jsonResult2,identificador: "deleted_at")
                        let updated_at: String? = self.isNullString(jsonResult:jsonResult2,identificador: "updated_at")
                        let idpspprocess:Int? = self.isNullInt(jsonResult:jsonResult2,identificador: "idpspprocess")
                        
                        
                        supervisorT = Supervisor(apellido_materno:jsonResult2["apellido_materno"]! as! String,apellido_paterno: jsonResult2["apellido_paterno"]! as! String,codigo_trabajador: jsonResult2["codigo_trabajador"]! as! String,correo: jsonResult2["correo"]! as! String,direccion: jsonResult2["direccion"]! as! String,idEspecialidad: jsonResult2["idfaculty"]! as! Int,idSupervisor: jsonResult2["id"]! as! Int,idUsuario: jsonResult2["iduser"]! as! Int,nombres: jsonResult2["nombres"]! as! String,telefono: jsonResult2["telefono"]! as! String,idpspprocess:idpspprocess,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                   
                        let created_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                        let deleted_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                        let updated_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                        let idFreeHour:Int? = self.isNullInt(jsonResult:jsonResult,identificador: "idfreehour")
                        
                            reunionesAlumnoTemporal=PspReunionesAlumnos(asistencia: jsonResult["asistencia"]! as! String,fecha: jsonResult["fecha"]! as! String,hora_fin: jsonResult["hora_fin"]! as! String,hora_inicio: jsonResult["hora_inicio"]! as! String,idFreeHour:idFreeHour, idMeeting: jsonResult["id"]! as! Int, idStudent: jsonResult["idstudent"]! as! Int,idSupervisor: jsonResult["idsupervisor"]! as! Int,idTipoEstado: jsonResult["idtipoestado"]! as! Int,lugar: jsonResult["lugar"]! as! String,observaciones: jsonResult["observaciones"]! as! String,retroalimentacion: jsonResult["retroalimentacion"]! as! String,tipoReunion: jsonResult["tiporeunion"]! as! Int,supervisor: supervisorT!,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                            
                            self.reunionesAlumno.append(reunionesAlumnoTemporal)
                       
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reunionesAlumno.count
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
      
            
            if (self.reunionesAlumno[indexPath.row].tipoReunion == 0) {
            cell.textLabel!.text = "Supervisor - Jefe"
            }
            else{
            cell.textLabel!.text = "Supervisr - Alumno"
            }
            cell.detailTextLabel!.text=self.reunionesAlumno[indexPath.row].fecha
        default:
            cell.textLabel!.text="Unknown"
        }
        
        
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
                if segue.identifier == "detalleReunionesAl" {
                    if let indexPath = self.tableView.indexPathForSelectedRow {
                        
                if  let destinationVC = (segue.destination) as? DetalleReunionesAlumnoViewController
                    // let destinationVC = segue.destination as? DetalleReunionesViewController
                {
                    var myString = String(indexPath.row)
                    destinationVC.cadena = myString
                    print("index::::::::::::::::::::::::::::::::: ",indexPath.row)
                    print("index::::::::::::::::::::::::::::::::: ",self.reunionesAlumno.count)
                    destinationVC.reunion = self.reunionesAlumno[indexPath.row]
                    print("entriiiiii al segueeeee e e   eeeee e ")
                    //var myString = String(indexPath.row)
                    //destinationVC.cadena = "hola mundo " + myString
                    // print("----------------------------------------")
                    // print("debe mostrar: "+myString)
                    // destinationVC.number = indexPath.row
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
