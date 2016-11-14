//
//  GruposTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class GruposTableViewController: UITableViewController {
    let kSectionCount: Int = 1
    let kRedSection: Int = 0
    

    var grupos: [Grupos] = []
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
   // var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/groups/all/"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let routeApi = getGroups + "?token=" + token
        
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if error != nil {
                print(error)
            } else {
   
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayGroup = dataUnwrapped as? [Any]
                
                
                
                     if((arrayGroup?.count)!-1>=0){
                for index in 0...((arrayGroup?.count)!-1){
                  
                    var gruposTemporal: Grupos
          
                    let validDictionary1 = arrayGroup?[index] as! [String:Any]
                    var jsonResult = validDictionary1
  
                    var descripcion:String = jsonResult["descripcion"]! as! String
                 
                    var idPspGroups:Int = jsonResult["id"]! as! Int
                    var numero:String = jsonResult["numero"]! as! String
                    
                    let created_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "created_at")
                    let deleted_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "deleted_at")
                    let updated_at: String? = self.isNullString(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "updated_at")
                    let idpspprocess:Int? = self.isNullInt(jsonResult:jsonResult as Dictionary<String, AnyObject>,identificador: "idpspprocess")
                    
                    
                    gruposTemporal=Grupos(descripcion: descripcion,id:idPspGroups,numero:numero,idpspprocess:idpspprocess,created_at:created_at,updated_at:updated_at,deleted_at:deleted_at)
                    
                    self.grupos.append(gruposTemporal)
                
                    
                }
                }
                
                self.tableView.reloadData()
         
                
            }
        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return kSectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grupos.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case kRedSection: return "Grupos Disponibles"
        default: return "Unknown"
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Grupos")! as UITableViewCell
        
        switch (indexPath.section){
        case kRedSection:
            cell.textLabel!.text="Grupo "+self.grupos[indexPath.row].numero!
            cell.detailTextLabel!.text=self.grupos[indexPath.row].descripcion

            
        default:
            cell.textLabel!.text="Unknown"
        }
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleGrupo" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
               
                    //let viewController:ViewController = segue!.destinationViewController as ViewController
                 if  let destinationVC = (segue.destination) as? DetalleGruposViewController
   
                {
                    
                    destinationVC.grupo = grupos[indexPath.row]
     
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
