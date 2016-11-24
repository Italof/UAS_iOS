//
//  PspFichaRegistroTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 10/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspFichaRegistroTableViewController: UITableViewController {
    
    var d1 :UILabel  = UILabel()
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var ele:Int = 0
    var redFlowers: [String] = ["Juan","Diego","Luis"]
    let subtitlesArray: [String] = ["20123136","20123137","20123136"]
    var reunionesSupervisor: [PspReuniones] = []
    var pspStu:[PspStudent] = []
    var pspIn:[PspInscription] = []
    var alumnos:[Alumnos] = []
    
    var sXiarray:[studentxinscriptionfiles] = []
    
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
  // var token: String  = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQwLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDQyMDIsImV4cCI6MTQ4MDI2MDIwMiwibmJmIjoxNDc4OTA0MjAyLCJqdGkiOiI4ZmYzYWMyZGJiZGM5NmE4N2E2YmIzMTE3ZmI3ZTMxMiJ9.oQudox-lUtqOVAXpBzuPeYHAxDtrfaB4PyWPvVbdYkk"
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/sup/getficha"
    
    
    override func viewDidAppear(_ animated: Bool) {
        pspStu = []
        alumnos = []
        sXiarray = []
        pspIn = []
        self.tableView.reloadData()
        
        let routeApi =  getGroups + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if error != nil {
                print(error)
            } else {
                
                var data2: [String:AnyObject]?
                
                if let dictionary = data as? [String:Any] {
                    data2 = dictionary as [String:AnyObject]
                } else {
                    let array = data as? [Any]
                    data2 = array?.first as? [String:AnyObject]
                }
                
                let validDictionary1 = data2?["alumnos"]
                // let validDictionary2 = data?["Supervisor"]
                let validDictionary2 = data2?["pspStudent"]
                let validDictionary3 = data2?["studentXinscription"]
                let validDictionary4 = data2?["inscription"]
                
                var arregloAlu = validDictionary1! as! NSArray
                var arregloPspStudent = validDictionary2! as! NSArray
                var arregloSxI = validDictionary3! as! NSArray
                var arregloI = validDictionary4! as! NSArray
                
                if(arregloSxI.count-1>=0)
                {
                for index in 0...(arregloSxI.count-1){
                    let y = arregloSxI[index]
                    var sXiT:studentxinscriptionfiles? = nil
                    var pspStudentT:PspStudent? = nil
                    var alumT:Alumnos? = nil
                    var fichaInsT:PspInscription? = nil
                    
                    var jsonResult = y as! Dictionary<String, AnyObject>
                    
                    let created_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                    let deleted_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                    let updated_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                    
  
                    let id:Int = self.castDefinidoInt(jsonResult:jsonResult, identificador:"idinscriptionfile")!
                    let idStudent:Int = self.castDefinidoInt(jsonResult:jsonResult, identificador:"idpspstudents")!
                    let nota_final:Int = self.castDefinidoInt(jsonResult:jsonResult, identificador:"nota_final")!
                    let acepta_terminos:Int = self.castDefinidoInt(jsonResult:jsonResult, identificador:"acepta_terminos")!
                    
                    
                   // sXiT = studentxinscriptionfiles(id:jsonResult["idinscriptionfile"]! as! Int,idStudent:jsonResult["idpspstudents"]! as! Int,nota_final:jsonResult["nota_final"]! as! Int,acepta_terminos: jsonResult["acepta_terminos"]! as! Int,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                   
                    sXiT = studentxinscriptionfiles(id:id,idStudent:idStudent,nota_final:nota_final,acepta_terminos:acepta_terminos,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
                   self.sXiarray.append(sXiT!)
                    
                    for index2 in 0...(arregloPspStudent.count-1){
                        let z = arregloPspStudent[index2]
                        let zz = arregloAlu[index2]
                        var alumnoDiccionario = z as! Dictionary<String, AnyObject>
                        var alumnoDiccionario2 = zz as! Dictionary<String, AnyObject>
                        
                        let idpg:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                        //if(sXiT?.idStudent==alumnoDiccionario["id"]! as! Int)
                        if(sXiT?.idStudent==idpg)
                        {
                            
                            var created_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                            var updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                            var deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                            
                            let idtipoestado: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idtipoestado")
                            let idpspgroup: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idpspgroup")
                            let idsupervisor = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idsupervisor")
                            var idpspprocess = self.isNullString(jsonResult:alumnoDiccionario,identificador: "idpspprocess")
                            let idespecialidad = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idespecialidad")
                            
                
                            
                            let iddd:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                            let idalumnooo:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"idalumno")!
                            
                             //pspStudentT=PspStudent(id: alumnoDiccionario["id"]! as! Int,idalumno:alumnoDiccionario["idalumno"]! as! Int,idespecialidad: idespecialidad,idpspgroup:idpspgroup,idpspprocess: idpspprocess,idsupervisor: idsupervisor,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at,idtipoestado:idtipoestado)
                           
                            pspStudentT=PspStudent(id:iddd,idalumno:idalumnooo,idespecialidad: idespecialidad,idpspgroup:idpspgroup,idpspprocess: idpspprocess,idsupervisor: idsupervisor,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at,idtipoestado:idtipoestado)
                            
                            
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
                            self.pspStu.append(pspStudentT!)
                            break;
                        }
                        
                    }
                    
                    for index3 in 0...(arregloI.count-1){
                        let zzz = arregloI[index3]
                        var alumnoDiccionario = zzz as! Dictionary<String, AnyObject>
                        
                        let idapg:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                        
                        //if(sXiT?.id==alumnoDiccionario["id"]! as! Int)
                        if(sXiT?.id==idapg)
                        {
                            
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
                            
                            let created_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                             let updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                            let deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                           
                            
                            
                            let Correo_jefe_directo:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"Correo_jefe_directo")!
                            let activ_formativas:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"activ_formativas")!
                            let actividad_economica:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"actividad_economica")!
                            let cond_seguridad_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"cond_seguridad_area")!
                            let direccion_empresa:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"direccion_empresa")!
                           
                            let distrito_empresa:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"distrito_empresa")!
                            
                            let equi_del_practicante:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"equi_del_practicante")!
                            
                            let equipamiento_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"equipamiento_area")!
                            
                            let fecha_inicio:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"fecha_inicio")!
                            
                            let fecha_recep_convenio:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"fecha_recep_convenio")!
                            let fecha_termino:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"fecha_termino")!
                            
                            let id:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                            
                            let jefe_directo_aux:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"jefe_directo_aux")!
                            
                            let nombre_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"nombre_area")!
                            
                            let personal_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"personal_area")!
                            
                            let puesto:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"puesto")!
                            
                            let razon_social:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"razon_social")!
                            
                            let recomendaciones:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"recomendaciones")!
                         
                            let telef_jefe_directo:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"telef_jefe_directo")!
                            
                            let tiene_convenio:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"tiene_convenio")!
                
                            let ubicacion_area:String = self.castDefinidoString(jsonResult:alumnoDiccionario, identificador:"ubicacion_area")!
                            
                            
                            
                            fichaInsT = PspInscription(Correo_jefe_directo:Correo_jefe_directo,activ_formativas:activ_formativas,actividad_economica:actividad_economica,cond_seguridad_area:cond_seguridad_area,direccion_empresa:direccion_empresa,distrito_empresa:distrito_empresa,equi_del_practicante:equi_del_practicante,equipamiento_area:equipamiento_area,fecha_inicio:fecha_inicio,fecha_recep_convenio:fecha_recep_convenio,fecha_termino:fecha_termino,id:id,jefe_directo_aux:jefe_directo_aux,nombre_area:nombre_area,personal_area:personal_area,puesto:puesto,razon_social:razon_social,recomendaciones:recomendaciones,telef_jefe_directo:telef_jefe_directo,tiene_convenio:tiene_convenio,ubicacion_area:ubicacion_area,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                            
                         self.pspIn.append(fichaInsT!)
                            break;
                        }
                    
                    }
                    
                    
                }
                
                  self.tableView.reloadData()
                }
                
                        
             }
        })
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        return sXiarray.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Fichas de inscripciones"
        //case kRedSection: return "Grupos Disponibles"
        default: return "Unknown"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reuniones")! as UITableViewCell
        
        switch (indexPath.section){
        case kRedSection:
            var nom:String
            var appPat:String
            var codigo:String
            if let c = self.alumnos[indexPath.row].Nombre{
                nom = self.alumnos[indexPath.row].Nombre!
            }
            else{
                nom = ""
            }
            if let c = self.alumnos[indexPath.row].ApellidoPaterno{
                appPat = self.alumnos[indexPath.row].ApellidoPaterno!
            }
            else{
                appPat = ""
            }
            if let c = self.alumnos[indexPath.row].Codigo{
                codigo = self.alumnos[indexPath.row].Codigo!
            }
            else{
                codigo = ""
            }
            
            cell.textLabel!.text=nom+" "+appPat
            cell.detailTextLabel!.text = codigo+"   Nota: "+String(self.sXiarray[indexPath.row].nota_final)
            
        default:
            cell.textLabel!.text="Unknown"
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleFicha" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                if  let destinationVC = (segue.destination) as? PspDetalleFichaViewController
                {
                    destinationVC.detalleFicha = self.pspIn[indexPath.row]
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
