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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
