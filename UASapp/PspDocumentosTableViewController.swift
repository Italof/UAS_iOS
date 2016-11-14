//
//  PspDocumentosTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 11/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspDocumentosTableViewController: UITableViewController {
    
    var d1 :UILabel  = UILabel()
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var ele:Int = 0
    var redFlowers: [String] = ["Juan","Diego","Luis"]
    let subtitlesArray: [String] = ["20123136","20123137","20123136"]
    var reunionesSupervisor: [PspReuniones] = []
    var supervisor: Supervisor?
    var alumnos:[Alumnos] = []
    var pspDarray:[PspDocuments] = []
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    // var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/al/getD"
    
    
    override func viewDidAppear(_ animated: Bool) {
        reunionesSupervisor = []
        alumnos = []
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
                
                let validDictionary1 = data2?["Documentos"]
                let validDictionary2 = data2?["Estados"]
        
                
                
                print("********************* ",validDictionary1)
                
                var arregloDoc = validDictionary1! as! NSArray
  
                if(arregloDoc.count-1>=0){
                    for index in 0...(arregloDoc.count-1){
                        let y = arregloDoc[index]
                        var documentosTemporal: PspDocuments
                        var jsonResult = y as! Dictionary<String, AnyObject>
                        
                        //var idStudent: Int = jsonResult["idstudent"]! as! Int
                      
                        /*
                        es_fisico:jsonResult["es_fisico"]! as! Int,es_obligatorio:jsonResult["es_obligatorio"]! as! String,fecha_limite:jsonResult["fecha_limite"]! as! String,id:jsonResult["id"]! as! Int,idstudent:jsonResult["idstudent"]! as! Int,idtemplate:jsonResult["idtemplate"]! as! Int,idtipoestado:jsonResult["idtipoestado"]! as! Int,numerofase:jsonResult["numerofase"]! as! Int,observaciones:jsonResult["observaciones"]! as! String,ruta:jsonResult["ruta"]! as! String,ruta_plantilla:jsonResult["ruta_plantilla"]! as! String,titulo_plantilla:jsonResult["titulo_plantilla"]! as! String)
                   */
                        
                        let created_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                        let deleted_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                        let updated_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                        let titulo_plantilla: String? = self.isNullString(jsonResult:jsonResult,identificador: "titulo_plantilla")
                        let ruta_plantilla: String? = self.isNullString(jsonResult:jsonResult,identificador: "ruta_plantilla")
                        let numerofase: Int? = self.isNullInt(jsonResult:jsonResult,identificador: "numerofase")
                        let es_fisico: Int? = self.isNullInt(jsonResult:jsonResult,identificador: "es_fisico")
                        
                        
                        documentosTemporal = PspDocuments(es_fisico:es_fisico,es_obligatorio:jsonResult["es_obligatorio"]! as! String,fecha_limite:jsonResult["fecha_limite"]! as! String,id:jsonResult["id"]! as! Int,idstudent:jsonResult["idstudent"]! as! Int,idtemplate:jsonResult["idtemplate"]! as! Int,idtipoestado:jsonResult["idtipoestado"]! as! Int,numerofase:numerofase,observaciones:jsonResult["observaciones"]! as! String,ruta:jsonResult["ruta"]! as! String,ruta_plantilla:ruta_plantilla,titulo_plantilla:titulo_plantilla,created_at:created_at,deleted_at:deleted_at,updated_at:updated_at)
                            self.pspDarray.append(documentosTemporal)
                
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
        return pspDarray.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Documentos actuales"
        //case kRedSection: return "Grupos Disponibles"
        default: return "Unknown"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reuniones")! as UITableViewCell
        
        switch (indexPath.section){
        case kRedSection:
            cell.textLabel!.text=self.pspDarray[indexPath.row].titulo_plantilla
            if (self.pspDarray[indexPath.row].idtipoestado==4)
            {
                cell.detailTextLabel!.text="Suspendido"
            }
            else if (self.pspDarray[indexPath.row].idtipoestado==5)
            {
                 cell.detailTextLabel!.text="Pendiente"
            }
            else{
                cell.detailTextLabel!.text="Subido"
            }
            
            
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
