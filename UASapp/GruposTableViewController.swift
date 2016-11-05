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
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    var getGroups: String = "psp/groups/all/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let routeApi = getGroups + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if error != nil {
                print(error!)
            } else {
   
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayGroup = dataUnwrapped as? [Any]
                
                
                
                     if((arrayGroup?.count)!-1>=0){
                for index in 0...((arrayGroup?.count)!-1){
                  
                    var gruposTemporal: Grupos
          
                    let validDictionary1 = arrayGroup?[index] as! [String:Any]
                    var jsonResult = validDictionary1
  
                    let descripcion:String = jsonResult["descripcion"]! as! String
                    let created_at:String = jsonResult["created_at"]! as! String
                    var deleted_at:String = ""
                    if (jsonResult["deleted_at"] as? String) != nil
                    {
                        deleted_at = jsonResult["deleted_at"]! as! String
                        
                    }
                    else {
                        deleted_at = ""
                    }
                    
              
                    let updated_at:String = jsonResult["updated_at"]! as! String
                    let idPspGroups:Int = jsonResult["id"]! as! Int
                    let numero:String = jsonResult["numero"]! as! String
                    
                    
                    gruposTemporal=Grupos(descripcion: descripcion,created_at: created_at,deleted_at: deleted_at,updated_at: updated_at,id:idPspGroups,numero:numero)
        
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
        dismiss(animated: true,completion:nil)
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