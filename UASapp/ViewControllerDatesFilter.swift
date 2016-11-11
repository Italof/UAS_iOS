//
//  ViewControllerDatesFilter.swift
//  UASapp
//
//  Created by inf227al on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerDatesFilter: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

      
    @IBOutlet var labelAlumno: UILabel!
    
    @IBOutlet var textoAlumno: UITextField!
    var estadosCitasTemp: [String] = []
    
    @IBOutlet weak var pickerViewEstados: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if ( rol == "A"){
            labelAlumno.isHidden = true
            textoAlumno.isHidden = true
        }
        
        
        //SE ELABORA EL LISTADO DE LOS ESTADOS DE LAS CITAS
        
        for d in ((self.parent as! NavigationControllerC).citasOb)! {
            if ( estadosCitasTemp.contains(d.estado!) == false){
                estadosCitasTemp.append(d.estado!)
            }
        }
        
        
        pickerViewEstados.delegate = self
        pickerViewEstados.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return estadosCitasTemp[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estadosCitasTemp.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
