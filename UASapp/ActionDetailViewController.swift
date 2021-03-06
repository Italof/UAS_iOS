//
//  ActionDetailViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/21/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ActionDetailViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    var action : Action!
    
    @IBOutlet weak var lblCicle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblProf: UILabel!
    @IBOutlet weak var lblComent: UILabel!
    @IBOutlet weak var lblAvance: UILabel!
    
    var viewer: UIDocumentInteractionController?
    var overlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCicle.text = action.cicle
        lblDesc.text = action.description
        lblProf.text = action.professor
        lblComent.text = action.coment
        lblAvance.text = action.percent! + " %"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downloadFile() {
        
        if (action.fileName != nil && action.fileName != "") {
            let route = "http://35.163.64.211/uploads/" + action.fileName!
            overlay = UIView(frame: view.frame)
            overlay!.backgroundColor = UIColor.black
            overlay!.alpha = 0.8
            
            view.addSubview(overlay!)
            
            LoadingOverlay.shared.showOverlay(view: overlay!)
            
            DownloadHelper.loadFileAsync(route: route, completion:{(path, error) in
                let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
                if isFileFound == true {
                    self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path!) as URL)
                    self.viewer?.delegate = self
                    self.viewer?.presentPreview(animated: true)
                }
            })
            
            LoadingOverlay.shared.hideOverlayView()
            self.overlay?.removeFromSuperview()
            
        } else {
            let alert = UIAlertController(title: "Lo sentimos",
                                          message: "No se encontro ningún documento",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
}
