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
     var overlay: UIView?
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
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
        
        let routeApi =  getGroups + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if error != nil {
                LoadingOverlay.shared.hideOverlayView()
                self.overlay?.removeFromSuperview()
                print(error)
            } else {
                LoadingOverlay.shared.hideOverlayView()
                self.overlay?.removeFromSuperview()
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
                       
                        //var jsonResult2 = arregloSupervisores[index] as! Dictionary<String, AnyObject>
                        var jsonResult2:Dictionary<String, AnyObject>
                        
                        if(arregloSupervisores[index] as? Dictionary<String, AnyObject> != nil){
                            // var jsonResult2 = arregloSupervisores[index] as! Dictionary<String, AnyObject>
                            jsonResult2 = arregloSupervisores[index] as! Dictionary<String, AnyObject>
                            
                        let created_at: String? = self.isNullString(jsonResult:jsonResult2,identificador: "created_at")
                        let deleted_at: String? = self.isNullString(jsonResult:jsonResult2,identificador: "deleted_at")
                        let updated_at: String? = self.isNullString(jsonResult:jsonResult2,identificador: "updated_at")
                        let idpspprocess:String? = self.isNullString(jsonResult:jsonResult2,identificador: "idpspprocess")
                        
                        /*
                        var aa:String = jsonResult2["apellido_materno"]! as! String
                        print(aa)
                        var bb:String = jsonResult2["apellido_paterno"]! as! String
                        print(bb)
                        var cc:String = jsonResult2["codigo_trabajador"]! as! String
                        print(cc)
                        var dd:String = jsonResult2["correo"]! as! String
                        print(dd)
                        var cccc:String = jsonResult2["direccion"]! as! String
                        print(cccc)
                        var dddd:String = jsonResult2["idfaculty"]! as! String
                        print(dddd)
                        var ee:Int = jsonResult2["id"]! as! Int
                        print(ee)
                        var ff:String = jsonResult2["iduser"]! as! String
                        print(ff)
                        var gg:String = jsonResult2["nombres"]! as! String
                        print(gg)
                        var hh:String =  jsonResult2["telefono"]! as! String
                        print(hh)
                        */
                        
                        //idpspprocess
                        //created_at:created_at,updated_at:updated_at
                        //deleted_at:deleted_at
                        
                        
                        
                        let apellido_materno:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"apellido_materno")!
                     
                        let apellido_paterno:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"apellido_paterno")!
                        let codigo_trabajador:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"codigo_trabajador")!
                        let correo:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"correo")!
                        let direccion:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"direccion")!
                        let idEspecialidad:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"idfaculty")!
                        let idSupervisor:Int = self.castDefinidoInt(jsonResult:jsonResult2, identificador:"id")!
                        let idUsuario:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"iduser")!
                        let nombres:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"nombres")!
                        let telefono:String = self.castDefinidoString(jsonResult:jsonResult2, identificador:"telefono")!
                    
                        
                        
                        
                        supervisorT = Supervisor(apellido_materno:apellido_materno,apellido_paterno: apellido_paterno,codigo_trabajador: codigo_trabajador,correo: correo,direccion: direccion,idEspecialidad: idEspecialidad,idSupervisor:idSupervisor,idUsuario: idUsuario,nombres: nombres,telefono:telefono,idpspprocess:String(describing: idpspprocess),created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                   
                        let created_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                        let deleted_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                        let updated_at2: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                        let idFreeHour:String? = self.isNullString(jsonResult:jsonResult,identificador: "idfreehour")
           
                     //   supervisor: supervisorT!,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at

                        
                        let asistencia:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"asistencia")!
                        let fecha:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"fecha")!
                        let hora_fin:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"hora_fin")!
                        let hora_inicio:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"hora_inicio")!
                        let idMeeting:Int = self.castDefinidoInt(jsonResult:jsonResult, identificador:"id")!
                        let idStudent:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"idstudent")!
                        let idSupervisorrr:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"idsupervisor")!
                        let idTipoEstado:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"idtipoestado")!
                        let lugar:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"lugar")!
                        let observaciones:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"observaciones")!
                        let retroalimentacionnn:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"retroalimentacion")!
                        let tipoReunionnn:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"tiporeunion")!
                        
                        reunionesAlumnoTemporal=PspReunionesAlumnos(asistencia: asistencia,fecha: fecha,hora_fin: hora_fin,hora_inicio: hora_inicio,idFreeHour:idFreeHour, idMeeting: idMeeting, idStudent: idStudent,idSupervisor: idSupervisorrr,idTipoEstado: idTipoEstado,lugar: lugar,observaciones: observaciones,retroalimentacion:retroalimentacionnn,tipoReunion:tipoReunionnn,supervisor: supervisorT!,created_at:created_at2,updated_at:updated_at2,deleted_at:deleted_at2)
                        
                        //reunionesAlumnoTemporal=PspReunionesAlumnos(asistencia: jsonResult["asistencia"]! as! String,fecha: jsonResult["fecha"]! as! String,hora_fin: jsonResult["hora_fin"]! as! String,hora_inicio: jsonResult["hora_inicio"]! as! String,idFreeHour:idFreeHour, idMeeting: jsonResult["id"]! as! Int, idStudent: jsonResult["idstudent"]! as! String,idSupervisor: jsonResult["idsupervisor"]! as! String,idTipoEstado: jsonResult["idtipoestado"]! as! String,lugar: jsonResult["lugar"]! as! String,observaciones: jsonResult["observaciones"]! as! String,retroalimentacion: jsonResult["retroalimentacion"]! as! String,tipoReunion: jsonResult["tiporeunion"]! as! String,supervisor: supervisorT!,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                            
                            self.reunionesAlumno.append(reunionesAlumnoTemporal)
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
    
    /*
    func isNullString(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> String?
    {
        print("identidaaaaaaa:::::::::::",identificador)
        var cadena: String?
        if let id = jsonResult[identificador] as? NSNull {
            cadena=nil
        }
        else{
            
            
            if let result_number = jsonResult[identificador] as? String
            {
                    let result_string = "\(result_number)"
                     cadena = try ((jsonResult[identificador]!) as! String)
            }
            else{
                    print("sinosisnsonsonsionsoinsoisnsoinsionsoisnsionsoinso")
                   cadena = try String(((jsonResult[identificador]!) as! Int))
                    
                print("vemovevemveovmoemvomvoemvoemvoem:",cadena)
                }
     
            }
        return cadena
    }
*/
  
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
      
            
            if (self.reunionesAlumno[indexPath.row].tipoReunion == "1") {
            cell.textLabel!.text = "Supervisr - Alumno"
            }
            else{
            cell.textLabel!.text = "Supervisor - Jefe"
            }
            cell.detailTextLabel!.text=self.reunionesAlumno[indexPath.row].fecha!+"    "+self.reunionesAlumno[indexPath.row].hora_inicio!
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
