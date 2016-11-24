//
//  DetalleGruposViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class DetalleGruposViewController: UIViewController {
   

    var cadena:String = "ho"
   var grupo:Grupos?
   var getGroups: String = "psp/groups/selectGroup/"
   var token: String = UserDefaults.standard.object(forKey: "TOKEN") as! String
    // var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQxLCJpc3MiOiJodHRwOlwvXC81YzZmMzBmYS5uZ3Jvay5pb1wvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0Nzg5MDM5NTAsImV4cCI6MTQ4MDI1OTk1MCwibmJmIjoxNDc4OTAzOTUwLCJqdGkiOiJkZTM1NjFiZTcxMWFjZDZhYjg2MGExOTFkODA2ZjkxZCJ9.fWuAjw9Xe7Qo-o9F3JTRzs-aR9rjKZk8IjVm2POcQxo"
    
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var numero: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Escogio Grupos:",cadena)
        numero.text = grupo?.numero
        descripcion.text = grupo?.descripcion
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func SeleccionGrupo(_ sender: AnyObject) {
        
        
            }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dismiss(_ sender: AnyObject) {
        
        
        let routeApi = getGroups + grupo!.id.description+"?token=" + token
        
        let json = NSMutableDictionary()
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            print(jsonData)
            
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print(decoded)
            let postData = decoded as! [String:AnyObject]
            
            HTTPHelper.post(route: routeApi, authenticated: true, body: postData, completion:  {(error,data) in
                if error != nil {
                    print(error)
                } else {
                    
                    print("DAtaaaaaaaaaaaaaaaaaaaaaaaa:",data)
                    /*
                     
                     if((arrayGroup?.count)!-1>=0){
                     for index in 0...((arrayGroup?.count)!-1){
                     
                     var gruposTemporal: Grupos
                     
                     let validDictionary1 = arrayGroup?[index] as! [String:Any]
                     var jsonResult = validDictionary1
                     
                     var descripcion:String = jsonResult["descripcion"]! as! String
                     var created_at:String = jsonResult["created_at"]! as! String
                     var deleted_at:String = ""
                     if let link = jsonResult["deleted_at"] as? String
                     {
                     deleted_at = jsonResult["deleted_at"]! as! String
                     
                     }
                     else {
                     deleted_at = ""
                     }
                     
                     
                     var updated_at:String = jsonResult["updated_at"]! as! String
                     var idPspGroups:Int = jsonResult["id"]! as! Int
                     var numero:String = jsonResult["numero"]! as! String
                     
                     
                     gruposTemporal=Grupos(descripcion: descripcion,created_at: created_at,deleted_at: deleted_at,updated_at: updated_at,id:idPspGroups,numero:numero)
                     
                     self.grupos.append(gruposTemporal)
                     
                     
                     }
                     }
                     */
                    
                    
                }
            })
        }
        catch let err as NSError{
            print("JSONObjet ERROR: \(err)")
        }
        
        
        navigationController?.popViewController(animated: true)
        
    }

    

}
