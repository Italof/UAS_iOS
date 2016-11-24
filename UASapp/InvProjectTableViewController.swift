//
//  InvProjectTableViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvProjectTableViewController: UITableViewController {
    var invPrData : [InvestigationProject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBOutlet weak var activity: UIActivityIndicatorView!
  override func viewWillAppear(_ animated: Bool) {
    let token = (parent as! InvNavViewController).token
    let get = (parent as! InvNavViewController).getProjects
    let routeApi = "investigation/" + get + "?token=" + token
    DispatchQueue.main.async {
        self.activity.startAnimating()
    }
    HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
        }
        if(error == nil){
        //obtener data
        let dataUnwrapped = data.unsafelyUnwrapped
        let arrayProjects = dataUnwrapped as? [Any]
        self.invPrData = []
        for project in arrayProjects!{
          let pr = project as! [String:AnyObject]
          let project : InvestigationProject = InvestigationProject.init(json : pr)
          self.invPrData.append(project)
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
        return invPrData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
        print(indexPath)
        // Configure the cell...
        let invPr = invPrData[indexPath.row] as InvestigationProject
        print(invPr.name!)
        cell.textLabel?.text = invPr.name
        cell.detailTextLabel?.text = invPr.invGroupName
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let invPr = invPrData[indexPath.row] as InvestigationProject
        //elegido = indexPath.row
        //((parent as! InvNavViewController).elegido) = indexPath.row
        //asigna el Proyecto elegido a variable en controlador de navegaciòn
        ((parent as! InvNavViewController).invPr) = invPr
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.invPrData = []
        do_table_refresh()
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
