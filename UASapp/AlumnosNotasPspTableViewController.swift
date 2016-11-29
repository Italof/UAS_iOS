
//
//  AlumnosNotasPspTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 4/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class AlumnosNotasPspTableViewController: UITableViewController {

    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var inscriptionFile:[studentxinscriptionfiles] = []
    var alumnos:[PspStudent] = []
    var alum:[Alumnos] = []
     var overlay: UIView?
    
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String

      //  var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6XC9cLzVjNmYzMGZhLm5ncm9rLmlvXC9hcGlcL2F1dGhlbnRpY2F0ZSIsImlhdCI6MTQ3ODkwMzY2MywiZXhwIjoxNDgwMjU5NjYzLCJuYmYiOjE0Nzg5MDM2NjMsImp0aSI6ImI1MTk2NDQ5Nzg5N2ViYTJmYjI1NmViY2Y3MjIyNTdlIn0.5tlXtcbsH6prNtu9G5LHktPjWkSxw_ypqkkBv44uKV4"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/pr/getN"
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let routeApi =  getGroups + "?token=" + token
        
        inscriptionFile = []
        alum = []
        self.tableView.reloadData()
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
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
                
                let validDictionary1 = data2?["AlumnosPsp"]
                // let validDictionary2 = data?["Supervisor"]
                
                let validDictionary2 = data2?["Notas"]
                
                let validDictionary3 = data2?["Alumnos"]
                
                print("********************* ",validDictionary2)
                
                //x
                var arregloAlumnos = validDictionary1! as! NSArray
                // yy
                var arregloNotas = validDictionary2! as! NSArray
                
           var arregloAlum = validDictionary3! as! NSArray
                
                if(arregloNotas.count-1>=0){
                for index1 in 0...(arregloNotas.count-1){
                  var alumnosT:PspStudent? = nil
                  var alumnoT:Alumnos? = nil
                  
                    var inscriptionNotas:studentxinscriptionfiles? = nil
                  
                  var jsonResult = arregloNotas[index1] as! Dictionary<String, AnyObject>
                    
                    let created_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                    let deleted_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                    let updated_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                    
           
                    let id:Int = self.castDefinidoInt(jsonResult: jsonResult, identificador:"idinscriptionfile" )!
                    let idStudent:Int = self.castDefinidoInt(jsonResult: jsonResult, identificador:"idpspstudents" )!
                    let nota_final:Int = self.castDefinidoInt(jsonResult: jsonResult, identificador: "nota_final")!
                    let acepta_terminos:Int = self.castDefinidoInt(jsonResult: jsonResult, identificador:"acepta_terminos" )!
                    
                    inscriptionNotas = studentxinscriptionfiles(id:id,idStudent:idStudent,nota_final:nota_final,acepta_terminos:acepta_terminos,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
    
               //     inscriptionNotas = studentxinscriptionfiles(id:jsonResult["idinscriptionfile"]! as! Int,idStudent:jsonResult["idpspstudents"]! as! Int,nota_final: jsonResult["nota_final"]! as! Int,acepta_terminos: jsonResult["acepta_terminos"]! as! Int,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
                 
                    
                    self.inscriptionFile.append(inscriptionNotas!)
                    
                    for index2 in 0...(arregloAlumnos.count-1){
                        
                        var alumnoDiccionario = arregloAlumnos[index2] as! Dictionary<String, AnyObject>
                        var alumnoDiccionario2 = arregloAlum[index2] as! Dictionary<String, AnyObject>
                        
                        let idPreg:Int = self.castDefinidoInt(jsonResult:alumnoDiccionario, identificador:"id")!
                        
                       // if(inscriptionNotas?.idStudent==alumnoDiccionario["id"]! as! Int){
                        if(inscriptionNotas?.idStudent==idPreg){
                            
                            
                        let created_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "created_at")
                        let deleted_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "deleted_at")
                        let updated_at: String? = self.isNullString(jsonResult:alumnoDiccionario,identificador: "updated_at")
                        let idtipoestado: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idtipoestado")
                        let idpspgroup: Int? = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idpspgroup")
                        let idsupervisor = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idsupervisor")
                        let idpspprocess = self.isNullString(jsonResult:alumnoDiccionario,identificador: "idpspprocess")
                        let idespecialidad = self.isNullInt(jsonResult:alumnoDiccionario,identificador: "idespecialidad")
                            
                        let idaid:Int = self.castDefinidoInt(jsonResult: alumnoDiccionario, identificador:"id")!
                        let idalumno:Int = self.castDefinidoInt(jsonResult: alumnoDiccionario, identificador:"idalumno")!
                      
                        alumnosT=PspStudent(id:idaid,idalumno:idalumno,idespecialidad: idespecialidad,idpspgroup:idpspgroup,idpspprocess: idpspprocess,idsupervisor: idsupervisor,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at,idtipoestado:idtipoestado)
    
                            
                            let ApellidoMaterno: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "ApellidoMaterno")
                            let ApellidoPaterno: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "ApellidoPaterno")
                            let Codigo: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "Codigo")
                             let IdUsuario: Int? = self.isNullInt(jsonResult:alumnoDiccionario2,identificador: "IdUsuario")
                            let Nombre: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "Nombre")
                            
                            let idAlumno: Int? = self.isNullInt(jsonResult:alumnoDiccionario2,identificador: "IdAlumno")
                            
                            let idHorario: Int? = self.isNullInt(jsonResult:alumnoDiccionario2,identificador: "IdHorario")
                            
                            let lleva_psp: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "lleva_psp")
                            
                            let created_at2: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "created_at")
                            let deleted_at2: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "deleted_at")
                            let updated_at2: String? = self.isNullString(jsonResult:alumnoDiccionario2,identificador: "updated_at")
                    
                            
                            alumnoT=Alumnos(ApellidoMaterno:ApellidoMaterno,ApellidoPaterno:ApellidoPaterno,Codigo:Codigo,IdUsuario:IdUsuario,Nombre:Nombre,idAlumno:idAlumno!,idHorario:idHorario,lleva_psp:lleva_psp,created_at:created_at2,updated_at:updated_at2,deleted_at:deleted_at2)
                            
                            
                            
                       
                        }
                    
                    
                    }
                    
                    self.alumnos.append(alumnosT!)
                    self.alum.append(alumnoT!)
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
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inscriptionFile.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Inscriptions Files, nota"
        default: return "Unknown"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Gruposs")! as UITableViewCell
        
        switch (indexPath.section){
        case kRedSection:
           
            var nom:String
            var appPat:String
            var codigo:String
            if let c = self.alum[indexPath.row].Nombre{
                nom = self.alum[indexPath.row].Nombre!
            }
            else{
                nom = ""
            }
            if let c = self.alum[indexPath.row].ApellidoPaterno{
                appPat = self.alum[indexPath.row].ApellidoPaterno!
            }
            else{
                appPat = ""
            }
            if let c = self.alum[indexPath.row].Codigo{
                codigo = self.alum[indexPath.row].Codigo!
            }
            else{
                codigo = ""
            }
        
            
            cell.textLabel!.text=nom+" "+appPat+"     "+codigo
            cell.detailTextLabel!.text="Nota: "+String(self.inscriptionFile[indexPath.row].nota_final)
      
            
        default:
            cell.textLabel!.text="Unknown"
        }
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "detalle" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                //let viewController:ViewController = segue!.destinationViewController as ViewController
                if  let destinationVC = (segue.destination) as? PspDetalleFichaNotasViewController
                    
                {
                    
                    destinationVC.id = inscriptionFile[indexPath.row].id
                    
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
