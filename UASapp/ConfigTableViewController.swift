//
//  ConfigTableViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/3/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ConfigTableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    var isLoggedIn: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            logout()
        }
    }
    
    func logout(){
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do{
            let filesIndirectory = try FileManager.default.contentsOfDirectory(atPath: (documentsUrl?.path)!)
            
            for fileName in filesIndirectory {
                let path = (documentsUrl?.path)! + "/" + fileName
                try FileManager.default.removeItem(atPath: path)
            }
            print (filesIndirectory)
        }
        catch let err as NSError{
            print(err)
        }

        //self.performSegue(withIdentifier: "logoutSegue", sender: self)
        //let storyboard =
        let Login = (storyboard?.instantiateViewController(withIdentifier: "login"))! as UIViewController
        self.present(Login, animated: true, completion: nil)
//        userDefaults.set(isLoggedIn, forKey: "ISLOGGEDIN")
//        userDefaults.removeObject(forKey: "USER")
//        userDefaults.removeObject(forKey: "TOKEN")
//        userDefaults.removeObject(forKey: "USER_ID")
//        userDefaults.removeObject(forKey: "ROLE")
//        
//        isLoggedIn = userDefaults.integer(forKey: "ISLOGGEDIN")
//        print(isLoggedIn)
//        
//        
//        self.performSegue(withIdentifier: "logoutSegue", sender: self)
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
