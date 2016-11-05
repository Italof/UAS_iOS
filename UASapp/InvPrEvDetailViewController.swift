//
//  InvPrEvDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 25/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvPrEvDetailViewController: UIViewController {

    var invPrEv : InvestigationProjectEvent?
    //variables de labels
    @IBOutlet weak var nameInvProEvent: UILabel!
    @IBOutlet weak var dateInvProEvent: UILabel!
    @IBOutlet weak var timeInvProEvent: UILabel!
    @IBOutlet weak var placeInvProEvent: UILabel!
    @IBOutlet weak var imgInvProEvent: UIImageView!
    
    @IBOutlet var invPrEvEditButton: UIBarButtonItem!
    @IBOutlet weak var descriptionInvProEvent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //toma Evento desde controlador de navegador
        invPrEv = (parent as! InvNavViewController).invPrEv
        //inicializa campos
        nameInvProEvent.text = invPrEv?.name?.uppercased()
        descriptionInvProEvent.text = invPrEv?.description
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: (invPrEv?.date)!)
        dateFormater.dateFormat = "dd/MM/yyyy"
        let id = (parent as! InvNavViewController).id
        dateInvProEvent.text = dateFormater.string(from: date!)
        //endDateInvProject.text = dateFormater.string(from: endDate!)
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var time = dateFormater.date(from: (invPrEv?.time)!)
        dateFormater.dateFormat = "HH:mm"
        if (time == nil){
            time = Date.init()
        }
        
        //dateInvProEvent.text = invPrEv?.date
        timeInvProEvent.text = dateFormater.string(from: time!)
        placeInvProEvent.text = invPrEv?.place
        let image = invPrEv?.image.unsafelyUnwrapped
      ///cambiar
        if (invPrEv?.image != nil || image != "")
        {
           let route = "http://52.89.227.55/" + (invPrEv?.image)!
           DownloadHelper.loadFileAsync(route: route, completion:{(path, error) in
              let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
              if isFileFound == true {
                 let url = URL(fileURLWithPath: path!)
                 let imageData = NSData(contentsOf: url)
                 self.imgInvProEvent.image = UIImage(data: imageData as! Data)
              }
           })
        }

      
        //inicializa botones -- PERMISOS
        //profile user
        let profile = (parent as! InvNavViewController).profile
        //profiles permitidos a editar
        invPrEvEditButton.isEnabled = false
        let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        if( profilePermited.index( of: profile) != nil || isConnected != false || id == invPrEv?.idLeader){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invPrEvEditButton.isEnabled = true
        }
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
