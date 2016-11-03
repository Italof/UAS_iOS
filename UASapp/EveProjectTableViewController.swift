//
//  EveProjectTableViewController.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class EveProjectTableViewController: UITableViewController {
    //Arreglo de eventos de un proyecto -- Se llena con el api
    var invPrEvData : [InvestigationProjectEvent] = []//[InvestigationProjectEvent.init(id: 1, name: "Evento de iniciación", date: "12/05/2016", time: "12:12 p.m.", place: "No-where")]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        let invGr = ((parent as! InvNavViewController).invGr)
        let token = (parent as! InvNavViewController).token
        let get = (parent as! InvNavViewController).getEvents
        let parser = invGr?.id
        let id = String(parser.unsafelyUnwrapped)
        let routeApi = "investigation/" + id + "/" + get + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let events = dataUnwrapped as! [String:Any]
                let arrayEvents = events["events"] as? [Any]
                self.invPrEvData = []
                for event in arrayEvents!{
                    let ev = event as! [String:AnyObject]
                    let newEvent : InvestigationProjectEvent = InvestigationProjectEvent.init(json : ev)
                    self.invPrEvData.append(newEvent)
                    //print(self.invPrData)
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
        return invPrEvData.count
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        print(indexPath)
        // Configure the cell...
        let invPrEv = invPrEvData[indexPath.row] as InvestigationProjectEvent
        print(invPrEv.name)
        cell.textLabel?.text = invPrEv.name
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: (invPrEv.date)!)
        dateFormater.dateFormat = "dd/MM/yyyy"
        cell.detailTextLabel?.text = dateFormater.string(from: date!)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let invPrEv = invPrEvData[indexPath.row] as InvestigationProjectEvent
        //elegido = indexPath.row
        //((parent as! InvNavViewController).elegido) = indexPath.row
        //asigna el Evento elegido a variable en controlador de navegaciòn
        ((parent as! InvNavViewController).invPrEv) = invPrEv
    }
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
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
