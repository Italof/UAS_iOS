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
        
       
        
        let routeApi = getGroups + "?token=" + token
        
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if error != nil {
                print(error!)
            } else {
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
                    
                    
                    
                    fasesTemporal=Fases(descripcion: jsonResult["descripcion"]! as? String,fecha_inicio: jsonResult["fecha_inicio"]! as? String,fecha_fin: jsonResult["fecha_fin"]! as? String,idPhase: jsonResult["id"]! as! Int,numero: jsonResult["numero"]! as? String)
            
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
            cell.textLabel!.text=(fases[indexPath.row].descripcion!) + " "+(fases[indexPath.row].numero!)
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
