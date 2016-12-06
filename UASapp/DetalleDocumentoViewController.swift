//
//  DetalleDocumentoViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class DetalleDocumentoViewController: UIViewController,UIDocumentInteractionControllerDelegate{
    
    var documento:PspDocuments?
    
    var viewer: UIDocumentInteractionController?
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    @IBOutlet weak var fase: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var plantilla: UILabel!
    @IBOutlet weak var obligatorio: UILabel!
    
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var comentario: UITextView!
    
    @IBOutlet weak var descargar: UIButton!
    @IBOutlet weak var ruta: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var faseN:String
        if let c = documento!.numerofase{
            faseN = String(documento!.numerofase!)
        }
        else{
            faseN = ""
        }
        
        fase.text = faseN
        titulo.text=documento!.titulo_plantilla
        plantilla.text=documento!.ruta_plantilla
        fecha.text=documento!.fecha_limite
        estado.text=documento!.idtipoestado
        comentario.text=documento!.observaciones
        
        
        ruta.text = documento!.ruta
        if (documento!.es_obligatorio=="s"){
            obligatorio.text="Sí"
        }
        else
        {
            obligatorio.text="No"
        }
        if (documento!.es_fisico=="1")
        {
            descargar.isHidden=true
        }
        /*
         numero.text =  String(describing: fase!.numero)
         descripcion.text = fase?.descripcion
         fechaInicio.text = fase?.fecha_inicio
         fechaFin.text = fase?.fecha_fin
         */
        
    }
    
    @IBAction func downloadDocument(_ sender: AnyObject) {
        print("diferennteeeeeeeeeeeee")
        
        if (documento!.ruta != nil && documento!.ruta != "" )
        {
            var route = "http://35.163.64.211/" + documento!.ruta
           
            
            print("route******:",route)
            route = route.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if(AskConectivity.isInternetAvailable()){
                DispatchQueue.main.async {
                    self.activity.startAnimating()
                }
                
                
                DownloadHelper.loadFileAsync(route: route,completion:{(path, error) in
                    let isFileFound:Bool?
                    if (path != nil){
                        isFileFound = FileManager.default.fileExists(atPath: path!)
                        print("true")
                    }
                    else{
                        isFileFound = false
                        print("false")
                    }
                    
                    
                    if isFileFound == true {
                        self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path!) as URL)
                        self.viewer?.delegate = self
                        self.viewer?.presentPreview(animated: true)
                        DispatchQueue.main.async {
                            self.activity.stopAnimating()
                            self.activity.isHidden = true
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.activity.stopAnimating()
                            self.activity.isHidden = true
                        }
                        let alertSuccess : UIAlertController = UIAlertController.init(title: "Error", message: "Documento no existe", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                        alertSuccess.addAction(action)
                        self.present(alertSuccess,animated: false, completion:nil)
                        
                    }
                })
            }
            else{
                let alertSuccess : UIAlertController = UIAlertController.init(title: "Error", message: "No conectado a internet", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                alertSuccess.addAction(action)
                self.present(alertSuccess,animated: false, completion:nil)
            }
            
        }
        else{
            let alertSuccess : UIAlertController = UIAlertController.init(title: "Error", message: "Documento no existe", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alertSuccess.addAction(action)
            self.present(alertSuccess,animated: false, completion:nil)
        }
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

