//
//  InvestigationGroupTableViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvestigatorTableViewController: UITableViewController {
    var invData: [Investigator] = []
    var elegido : Int = 9
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let token = (parent as! InvNavViewController).token
        let get = (parent as! InvNavViewController).getInvestigators
        let routeApi = "investigation/" + get + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayInv = dataUnwrapped as? [Any]
                self.invData = []
                for investigator in arrayInv!{
                    let inv = investigator as! [String:AnyObject]
                    
                    //let group : InvestigationGroup =
                    self.invData.append( Investigator( json: inv ) )
                    //print(self.invGrData)
                    //print(pr["id"].unsafelyUnwrapped)
                }
                self.do_table_refresh()
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(1)
        return invData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvestigatorCell", for: indexPath)

        // Configure the cell...
        let inv = invData[indexPath.row] as Investigator
        print(inv.name)
        cell.textLabel?.text = inv.name! + " " + inv.lastNameP! + " " + inv.lastNameM!
        cell.detailTextLabel?.text = inv.email 
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let inv = invData[indexPath.row] as Investigator
        elegido = indexPath.row
        //prueba
        //((parent as! InvNavViewController).elegido) = indexPath.row
        //asigna el Grupo de investigacion elegido a variable en controlador de navegaciòn
        ((parent as! InvNavViewController).inv) = inv
    }
    func do_table_refresh()
    {
        self.tableView.reloadData()
    }
    
 /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath){
        
    }
    
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
