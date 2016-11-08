//
//  FilesTableViewController.swift
//  UASapp
//
//  Created by inf227al on 7/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class FilesTableViewController: UITableViewController , UIDocumentInteractionControllerDelegate{
    var filesArray : [String] = []
    var viewer : UIDocumentInteractionController?
    //let url = NSURL(string:"archivo")
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    //let destinationUrl = documentsUrl?.appendingPathComponent((url?.lastPathComponent!)!)
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let filesIndirectory = try FileManager.default.contentsOfDirectory(atPath: (documentsUrl?.path)!)
            filesArray = []
            for fileName in filesIndirectory {
                filesArray.append(fileName)
            }
            print (filesIndirectory)
        }
        catch let err as NSError{
            print(err)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell", for: indexPath)
        print(indexPath)
        // Configure the cell...
        let file = filesArray[indexPath.row] as String
        cell.textLabel?.text = file
        let path = (self.documentsUrl?.path)! + "/" + self.filesArray[indexPath.row]
        do{
            let details = try FileManager.default.attributesOfItem(atPath: path)
            print(details)
            
            let size = details[FileAttributeKey.size] as! NSNumber
            var sizeInt: Int  = 0
            var tipo : String = "Bytes"
            if (size.intValue > 1024){
                sizeInt = size.intValue / 1024
                tipo="KB"
            }
            if (sizeInt > 1024){
                sizeInt = sizeInt/1024
                tipo="MB"
            }
            let sizeStr = String(sizeInt) + " " + tipo
            cell.detailTextLabel?.text = sizeStr
        }
        catch let err as NSError{
            print(err)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let uiAlert = UIAlertController(title: "Aviso", message: "¿Que acción desea realizar?", preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        uiAlert.addAction(UIAlertAction(title: "Abrir", style: .default, handler: { action in
            let path = (self.documentsUrl?.path)! + "/" + self.filesArray[indexPath.row]
            self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path) as URL)
            self.viewer?.delegate = self
            self.viewer?.presentPreview(animated: true)
        }))
        uiAlert.addAction(UIAlertAction(title: "Volver", style: .default, handler: nil))
        uiAlert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { action in
            print("archivo eliminado")
            let path = (self.documentsUrl?.path)! + "/" + self.filesArray[indexPath.row]
            do{
                try FileManager.default.removeItem(atPath: path)
                self.filesArray.remove(at: indexPath.row)
                //self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.do_table_refresh()
            }
            catch let err as NSError{
                print(err)
            }
        }))
        
        
        //let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
        //prueba
        //((parent as! InvNavViewController).elegido) = indexPath.row
        //asigna el Grupo de investigacion elegido a variable en controlador de navegaciòn
        //((parent as! InvNavViewController).invDer) = invDer
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filesArray.count
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
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
     overridecell.detailTextLabel?.text
 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
