//
//  PspSupervisorDocumentosAlumnosTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PspSupervisorDocumentosAlumnosTableViewController: UITableViewController {
    
    var d1 :UILabel  = UILabel()
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var ele:Int = 0
    var redFlowers: [String] = ["Juan","Diego","Luis"]
    let subtitlesArray: [String] = ["20123136","20123137","20123136"]
    var reunionesSupervisor: [PspReuniones] = []
    var supervisor: Supervisor?
    var alumnos:[Alumnos] = []
    var alumno:Alumnos?
    var alumnosPsp:[PspStudent] = []
    var pspDarray:[PspDocuments] = []
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
     var overlay: UIView?
    // var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/getDBI/"
    
    
    override func viewDidAppear(_ animated: Bool) {
        reunionesSupervisor = []
        alumnos = []
        alumnosPsp = []
        pspDarray = []
        self.tableView.reloadData()
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
        
       // print("Alumnosssssssssssssssssssss: ",(alumno?.Nombre)!+"   ")

        let routeApi = getGroups+""+String(alumno!.idAlumno)+"?token=" + token
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
                
                let validDictionary1 = data2?["Documentos"]

                
                
                
                print("********************* ",validDictionary1)
                
                var arregloDoc = validDictionary1! as! NSArray
                
                if(arregloDoc.count-1>=0){
                    for index in 0...(arregloDoc.count-1){
                        
                        let y = arregloDoc[index]
                        var documentosTemporal: PspDocuments
                        var jsonResult = y as! Dictionary<String, AnyObject>
                        
                        let created_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "created_at")
                        let deleted_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "deleted_at")
                        let updated_at: String? = self.isNullString(jsonResult:jsonResult,identificador: "updated_at")
                        let titulo_plantilla: String? = self.isNullString(jsonResult:jsonResult,identificador: "titulo_plantilla")
                        let ruta_plantilla: String? = self.isNullString(jsonResult:jsonResult,identificador: "ruta_plantilla")
                        let numerofase: String? = self.isNullString(jsonResult:jsonResult,identificador: "numerofase")
                        let es_fisico: String? = self.isNullString(jsonResult:jsonResult,identificador: "es_fisico")
                        
                        let es_obligatorio:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"es_obligatorio")!
                        let fecha_limite:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"fecha_limite")!
                        
                        let id:Int = self.castDefinidoInt(jsonResult:jsonResult, identificador:"id")!
                        
                        let idstudent:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"idstudent")!
                        let idtemplate:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"idtemplate")!
                        let idtipoestado:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"idtipoestado")!
                        let observaciones:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"observaciones")!
                        let ruta:String = self.castDefinidoString(jsonResult:jsonResult, identificador:"ruta")!
                        
                        
                       documentosTemporal = PspDocuments(es_fisico:es_fisico,es_obligatorio:es_obligatorio,fecha_limite:fecha_limite,id:id,idstudent:idstudent,idtemplate:idtemplate,idtipoestado:idtipoestado,numerofase:numerofase,observaciones:observaciones,ruta:ruta,ruta_plantilla:ruta_plantilla,titulo_plantilla:titulo_plantilla,created_at:created_at,deleted_at:deleted_at,updated_at:updated_at)
                        
                       // documentosTemporal = PspDocuments(es_fisico:es_fisico,es_obligatorio:jsonResult["es_obligatorio"]! as! String,fecha_limite:jsonResult["fecha_limite"]! as! String,id:jsonResult["id"]! as! Int,idstudent:jsonResult["idstudent"]! as! String,idtemplate:jsonResult["idtemplate"]! as! String,idtipoestado:jsonResult["idtipoestado"]! as! String,numerofase:numerofase,observaciones:jsonResult["observaciones"]! as! String,ruta:jsonResult["ruta"]! as! String,ruta_plantilla:ruta_plantilla,titulo_plantilla:titulo_plantilla,created_at:created_at,deleted_at:deleted_at,updated_at:updated_at)
                       
                        
                        
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
        return self.pspDarray.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Documentos"
        //case kRedSection: return "Grupos Disponibles"
        default: return "Unknown"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reuniones")! as UITableViewCell
        
        cell.textLabel!.text=self.pspDarray[indexPath.row].titulo_plantilla
        
        var codigo:String
        if let c = self.pspDarray[indexPath.row].ruta_plantilla{
            codigo = self.pspDarray[indexPath.row].ruta_plantilla!
        }
        else{
            codigo = "      "
        }
        var digital:String
        if self.pspDarray[indexPath.row].es_fisico == "1" {
            digital = "Fisico"
        }
        else{
            digital = "Digital"
        }
        
        
          cell.detailTextLabel!.text=codigo+"   "+self.pspDarray[indexPath.row].idtipoestado+"   "+digital
        
       // cell.detailTextLabel!.text=self.pspDarray[indexPath.row].ruta_plantilla!+"   "+self.pspDarray[indexPath.row].idtipoestado
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalle" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if  let destinationVC = (segue.destination) as? DetalleDocumentoViewController
                {
                    
                    destinationVC.documento = self.pspDarray[indexPath.row]
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
