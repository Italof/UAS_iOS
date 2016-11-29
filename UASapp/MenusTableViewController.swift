//
//  MenusTableViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 20/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class MenusTableViewController: UITableViewController
{
    
    var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
     var overlay: UIView?
    // var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    
    var user: String = (UserDefaults.standard.object(forKey: "USER")  as! String)
    //var profile:Int = 2
    //var profile:Int = UserDefaults.standard.object(forKey: "ROLE") as! Int
    var profile: Int = Int(UserDefaults.standard.object(forKey: "ROLE") as! String)!
    
    var permitido:Int=0
    //    set(user["IdPerfil"], forKey: "ROLE")
    
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
        if (profile==2||profile==1) //Profesor
        {
            
            var getGroups: String = "psp/autTea/"
            
            overlay = UIView(frame: view.frame)
            overlay!.backgroundColor = UIColor.black
            overlay!.alpha = 0.8
            
            view.addSubview(overlay!)
            
            LoadingOverlay.shared.showOverlay(view: overlay!)
            
            let routeApi =  getGroups + "?token=" + token
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
                    var data2: [String:AnyObject]?
                    
                    if let dictionary = data as? [String:Any] {
                        data2 = dictionary as [String:AnyObject]
                    } else {
                        let array = data as? [Any]
                        data2 = array?.first as? [String:AnyObject]
                    }
                    
                    let validDictionary1 = data2?["mensaje"]
                    //  var Correo_jefe_directo:String = alumnoDiccionario["mensaje"]! as! String
                    
                    if(validDictionary1! as! String=="Si")
                    {
                        self.permitido=1
                    }else
                    {
                        self.permitido=0
                    }
                    
                }
                self.tableView.reloadData()
            })
            
            
            
        }
        else if (profile==6) //Supervisor
        {
            
            var getGroups: String = "psp/autSup/"
            /*
             let routeApi =  getGroups + "?token=" + token
             HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
             if error != nil {
             print(error)
             } else {
             // let question = data!["question"] as? String
             // print("Question: \(question)")
             var data2: [String:AnyObject]?
             
             if let dictionary = data as? [String:Any] {
             data2 = dictionary as [String:AnyObject]
             } else {
             let array = data as? [Any]
             data2 = array?.first as? [String:AnyObject]
             }
             
             let validDictionary1 = data2?["mensaje"]
             //  var Correo_jefe_directo:String = alumnoDiccionario["mensaje"]! as! String
             
             if(validDictionary1! as! String=="Si")
             {
             self.permitido=1
             }else
             {
             self.permitido=0
             }
             
             }
             self.tableView.reloadData()
             })
             */
            self.permitido=1
            
        }
        else if (profile==0) //Alumno
        {
            var getGroups: String = "psp/autStud/"
            
            overlay = UIView(frame: view.frame)
            overlay!.backgroundColor = UIColor.black
            overlay!.alpha = 0.8
            
            view.addSubview(overlay!)
            
            LoadingOverlay.shared.showOverlay(view: overlay!)
            
            let routeApi =  getGroups + "?token=" + token
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
                    var data2: [String:AnyObject]?
                    
                    if let dictionary = data as? [String:Any] {
                        data2 = dictionary as [String:AnyObject]
                    } else {
                        let array = data as? [Any]
                        data2 = array?.first as? [String:AnyObject]
                    }
                    
                    let validDictionary1 = data2?["mensaje"]
                    //  var Correo_jefe_directo:String = alumnoDiccionario["mensaje"]! as! String
                    
                    if(validDictionary1! as! String=="Si")
                    {
                        self.permitido=1
                    }else
                    {
                        self.permitido=0
                    }
                    
                }
                self.tableView.reloadData()
            })
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (profile==2||profile==1) //Profesor
        {
            if(permitido==1){
                return 2
            }
            else{
                return 0
            }
        }
        else if (profile==6) //Supervisor
        {
            if(permitido==1){
                return 3
            }
            else{
                return 0
            }
            
        }
        else if (profile==0) //Alumno
        {
            if(permitido==1){
                return 4}
            else{
                return 0
            }
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*   switch section{
         case kRedSection: return "Opciones"
         default: return "Unknown"
         }
         */
        if (profile==2||profile==1) //Profesor
        {
            return "Profesor"
        }
        else if (profile==6) //Supervisor
        {
            return "Supervisor"
        }
        else if (profile==0) //Alumno
        {
            return "Alumno"
        }
        
        return "Opciones"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Notas Finales")! as UITableViewCell
        let cell2: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Fases")! as UITableViewCell
        let cell3: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Ficha Registro")! as UITableViewCell
        let cell4: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Reuniones")! as UITableViewCell
        let cell5: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Ver Alumnos")! as UITableViewCell
        let cell6: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Grupos")! as UITableViewCell
        let cell7: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReunionesA")! as UITableViewCell
        let cell8: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Ver Documentos")! as UITableViewCell
        let cell9: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecomendacionesIF")! as UITableViewCell
        
        if (profile==2||profile==1) //Profesor
        {
            if(indexPath.row==0){
                cell1.textLabel!.text="Notas Finales"
                return cell1
            }else{
                cell2.textLabel!.text="Fases"
                return cell2
            }
        }
        else if (profile==6) //Supervisor
        {
            if(indexPath.row==0){
                cell3.textLabel!.text="Ficha Registro"
                return cell3
            }else if(indexPath.row==1){
                cell4.textLabel!.text="Reuniones"
                return cell4
            }else{
                cell5.textLabel!.text="Documentos Alumnos"
                return cell5
            }
            
        }
        else if (profile==0) //Alumno
        {
            if(indexPath.row==0){
                cell6.textLabel!.text="Grupos"
                return cell6
            }else if(indexPath.row==1){
                cell7.textLabel!.text="Reuniones"
                return cell7
            }else if(indexPath.row==2){
                cell8.textLabel!.text="Ver Documentos"
                return cell8
            }
            else{
                cell9.textLabel!.text="Información de Empresa"
                return cell9
            }
        }
        
        return cell1
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleGrupo" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                //let viewController:ViewController = segue!.destinationViewController as ViewController
                if  let destinationVC = (segue.destination) as? DetalleGruposViewController
                    
                {
                    
                    
                    
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
