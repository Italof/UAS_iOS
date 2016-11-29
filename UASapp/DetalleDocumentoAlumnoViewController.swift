//
//  DetalleDocumentoAlumnoViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 28/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class DetalleDocumentoAlumnoViewController: UIViewController{
        
        var documento:PspDocuments?

        @IBOutlet weak var fase: UILabel!
        @IBOutlet weak var titulo: UILabel!
        @IBOutlet weak var plantilla: UILabel!
        @IBOutlet weak var obligatorio: UILabel!
        
        @IBOutlet weak var fecha: UILabel!
        @IBOutlet weak var estado: UILabel!
        @IBOutlet weak var comentario: UITextView!
        
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
            
            if (documento!.es_obligatorio=="s"){
                obligatorio.text="Sí"
            }
            else
            {
                obligatorio.text="No"
            }
            
            /*
             numero.text =  String(describing: fase!.numero)
             descripcion.text = fase?.descripcion
             fechaInicio.text = fase?.fecha_inicio
             fechaFin.text = fase?.fecha_fin
             */
            
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

