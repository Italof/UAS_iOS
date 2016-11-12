//
//  InvGrDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvGrDetailViewController: UIViewController {
    //Controlador de la pantalla de vista de detalle de Grupo de investigacion
    
    //variable de GRupo de investigacion
    var invGr : InvestigationGroup?
    //VARIABLE DE labels
    
    @IBOutlet weak var nameInvGroup: UILabel!
    @IBOutlet weak var descriptionInvGroup: UITextView!
    @IBOutlet weak var specialityInvGroup: UILabel!
    @IBOutlet weak var leaderInvGroup: UILabel!
    @IBOutlet weak var imageInvGroup: UIImageView!
    //Boton de editar grupo, desactivar si no es lider de especialidad
    @IBOutlet weak var editInvGroup: UIBarButtonItem!
    
    @IBOutlet weak var imgInvGroup: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //Toma grupo de controlado de navegacion
        invGr = (parent as! InvNavViewController).invGr

        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        let profilePermited = (parent as! InvNavViewController).profilePermited

        //se inicializan los campos importantes
        nameInvGroup.text = invGr?.name?.uppercased()
        descriptionInvGroup.text = invGr?.description
        specialityInvGroup.text = invGr?.speciality
        leaderInvGroup.text = invGr?.leaderName
        
        //se maneja la imagen del grupo
        
        let isConnected = AskConectivity.isInternetAvailable()
        print(isConnected)
        // inicializa botones  -- PERMISOS

        if(profilePermited.index( of: profile) == nil || isConnected == false){
            //si no se encuentra el perfil permitido
            editInvGroup.isEnabled = false
        }
        print (invGr)
       */
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      invGr = (parent as! InvNavViewController).invGr
      
      //profile user
      //let profile = (parent as! InvNavViewController).profile
      //profiles permitidos a editar
      //let profilePermited = (parent as! InvNavViewController).profilePermited
      let id = (parent as! InvNavViewController).id
      //se inicializan los campos importantes
      nameInvGroup.text = invGr?.name?.uppercased()
      descriptionInvGroup.text = invGr?.description
      specialityInvGroup.text = invGr?.speciality
      leaderInvGroup.text = invGr?.leaderName
      
      //se maneja la imagen del grupo
    
      let isConnected = AskConectivity.isInternetAvailable()
      if (invGr?.imageInvGr != nil)
      {
         let route = "http://52.89.227.55/" + (invGr?.imageInvGr)!
         DownloadHelper.loadFileSync(route: route, completion:{(path, error) in
            let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
            if isFileFound == true {
               let url = URL(fileURLWithPath: path)
               let imageData = NSData(contentsOf: url)
               self.imgInvGroup.image = UIImage(data: imageData as! Data)
            }
         })
      }
      
      print(isConnected)
      // inicializa botones  -- PERMISOS
      editInvGroup.isEnabled = false
        
      if(isConnected != false && invGr?.idLeader == id){
        
        //si no se encuentra el perfil permitido
        editInvGroup.isEnabled = true
      }
      print (invGr)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
