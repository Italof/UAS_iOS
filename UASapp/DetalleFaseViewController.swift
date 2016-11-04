//
//  DetalleFaseViewController.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class DetalleFaseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var cadena:String = "ho"
    var fase:Fases?
    
    @IBOutlet weak var fechaInicio: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var numero: UILabel!
    
    @IBOutlet weak var fechaFin: UILabel!
    var arrayF = ["Viernes 28/10/2016","Sabado 29/10/2016","Domingo 30/10/2016","Lunes 31/10/2016","Martes 01/11/2016"]
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
          return arrayF[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

          return arrayF.count
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numero.text =  fase?.numero
        descripcion.text = fase?.descripcion
        fechaInicio.text = fase?.fecha_inicio
        fechaFin.text = fase?.fecha_fin
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
