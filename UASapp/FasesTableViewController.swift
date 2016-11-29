//
//  FasesTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class FasesTableViewController: UITableViewController {

    var d1 :UILabel  = UILabel()
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    var ele:Int = 0
    var redFlowers: [String] = ["","",""]
    //let subtitlesArray: [String] = ["06/10/2016","12/10/2016","18/10/2016"]
    var subtitlesArray: [String] = ["","",""]
    var fases: [Fases] = []
    var pf:[Int] = [Int]()
    var getGroups: String = "psp/phases/all/"
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
     var overlay: UIView?
    
    //var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6XC9cLzVjNmYzMGZhLm5ncm9rLmlvXC9hcGlcL2F1dGhlbnRpY2F0ZSIsImlhdCI6MTQ3ODkwMzY2MywiZXhwIjoxNDgwMjU5NjYzLCJuYmYiOjE0Nzg5MDM2NjMsImp0aSI6ImI1MTk2NDQ5Nzg5N2ViYTJmYjI1NmViY2Y3MjIyNTdlIn0.5tlXtcbsH6prNtu9G5LHktPjWkSxw_ypqkkBv44uKV4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        */
        
       
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        
        LoadingOverlay.shared.showOverlay(view: overlay!)
        
        let routeApi = getGroups + "?token=" + token
        
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
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayGroup = dataUnwrapped as? [Any]
                
            
               
             
                //  self.redFlowers[0] = ((validDictionary1!["descripcion"])!)! as! String
                //let validDictionary1 = data?["phases"]
             //   let x = validDictionary1  as! NSArray
        
            
                if((arrayGroup?.count)!-1>=0){
                for index in 0...((arrayGroup?.count)!-1){
                    
                    var fasesTemporal: Fases
            
                
                   let validDictionary1 = arrayGroup?[index] as! [String:Any]
                    var jsonResult = validDictionary1
                    
                    let created_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "created_at")
                    let deleted_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "deleted_at")
                    let updated_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "updated_at")
                    let idpspprocess:String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "idpspprocess")
                  /*
                    var a:String = jsonResult["descripcion"]! as! String
                    var b:String = jsonResult["fecha_inicio"]! as! String
                    var c:String = jsonResult["fecha_fin"]! as! String
                    var d:Int = jsonResult["id"]! as! Int
                    var e:Int = jsonResult["numero"]! as! Int
                    //var f:String = idpspprocess!
                    //var g:String = created_at!
                    //var h:String = deleted_at!
                   */
                
                    
                    let descripcion:String = self.castDefinidoString(jsonResult:jsonResult as Dictionary<String, AnyObject>, identificador:"descripcion")!
                   
                    let fecha_inicio:String = self.castDefinidoString(jsonResult:jsonResult as Dictionary<String, AnyObject>, identificador:"fecha_inicio")!
                    
                    let fecha_fin:String = self.castDefinidoString(jsonResult:jsonResult as Dictionary<String, AnyObject>, identificador:"fecha_fin")!
                    
                    let idPhase:Int = self.castDefinidoInt(jsonResult:jsonResult as Dictionary<String, AnyObject>, identificador:"id")!
                    let numero:String = self.castDefinidoString(jsonResult:jsonResult as Dictionary<String, AnyObject>, identificador:"numero")!
                    
                    fasesTemporal=Fases(descripcion: descripcion,fecha_inicio: fecha_inicio,fecha_fin: fecha_fin,idPhase: idPhase,numero: numero,idpspprocess:idpspprocess,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
            
        self.fases.append(fasesTemporal)

                
                    }
                }
          
                self.tableView.reloadData()
                
            }
        })
        

        
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
            // entero = jsonResult[identificador]! as! Int
            entero = castDefinidoInt(jsonResult: jsonResult, identificador: identificador)
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
            cadena = castDefinidoString(jsonResult: jsonResult, identificador: identificador)
        }
        return cadena
    }
    
    
    func castDefinidoString(jsonResult:Dictionary<String, AnyObject>,identificador:String) -> String?
    {var cadena: String?
        print("identidaaaaaaa:::::::::::",identificador)
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
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fases.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Fases Actuales"
        //case kRedSection: return "Grupos Disponibles"
        default: return "Unknown"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Fases")! as UITableViewCell
        
        switch (indexPath.section){
        case kRedSection:
            cell.textLabel!.text=(fases[indexPath.row].descripcion!) + " "+String(fases[indexPath.row].numero!)
            cell.detailTextLabel!.text=fases[indexPath.row].fecha_inicio!+" - "+fases[indexPath.row].fecha_fin!
            
        default:
            cell.textLabel!.text="Unknown"
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleFase" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                
                
            if  let destinationVC = (segue.destination) as? DetalleFaseViewController
                {
                    destinationVC.fase = fases[indexPath.row]
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
