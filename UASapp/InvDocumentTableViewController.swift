//
//  InvestigationGroupTableViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDocumentTableViewController: UITableViewController {
    var invDocData: [InvestigationDocument] = []
    var elegido :   Int = 9
    var invPr:      InvestigationProject?
    var invDer:     InvestigationDerivable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        invPr = (parent as! InvNavViewController).invPr!
        invDer = (parent as! InvNavViewController).invDer!
        let parser = invDer?.id
        let id = String.init(parser.unsafelyUnwrapped)
        let token = (parent as! InvNavViewController).token
        let get = (parent as! InvNavViewController).getDerivables
        let routeApi = "investigation/" + id + "/" + get + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayDocument = dataUnwrapped as? [Any]
                self.invDocData = []
                for doc in arrayDocument!{
                    let document = doc as! [String:AnyObject]
                    
                    //let group : InvestigationGroup =
                    self.invDocData.append( InvestigationDocument( json: document ) )
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
        return invDocData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        // Configure the cell...
        let invDoc = invDocData[indexPath.row] as InvestigationDocument
        //print(invDoc.name)
        cell.textLabel?.text = "hola"
        cell.detailTextLabel?.text = "Versión :" + invDoc.version!
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let invDoc = invDocData[indexPath.row] as InvestigationDocument
        elegido = indexPath.row
        //prueba
        //((parent as! InvNavViewController).elegido) = indexPath.row
        //asigna el Grupo de investigacion elegido a variable en controlador de navegaciòn
        ((parent as! InvNavViewController).invDoc) = invDoc
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
