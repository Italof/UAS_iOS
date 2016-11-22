//
//  ViewControllerAtenderCita.swift
//  UASapp
//
//  Created by inf227al on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerAtenderCita: UIViewController {

    @IBOutlet var labelCodigo: UILabel!
    @IBOutlet var labelAlumno: UILabel!
    @IBOutlet var labelFecha: UILabel!
    @IBOutlet var labelHoraI: UILabel!
    @IBOutlet var labelLugar: UILabel!
    @IBOutlet var labelTema: UILabel!
    @IBOutlet var labelInfoExtra: UILabel!
    @IBOutlet var DPHoraF: UIDatePicker!
    @IBOutlet var TFObservaciones: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = ((self.parent as! NavigationControllerC).citEsc)
        labelCodigo.text = c?.citaId
        labelAlumno.text = c?.alumno
        labelFecha.text = c?.fechaI
        labelHoraI.text = c?.horaI
        labelLugar.text = c?.lugar
        labelTema.text = c?.tema
        labelInfoExtra.text = c?.infoExtra
        
        
        
        
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func atenderC(_ sender: AnyObject) {
        let c = ((self.parent as! NavigationControllerC).citEsc)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss" //"HH:mm:ss" //"yyyy-MM-dd HH:mm:ss"
        let DiaHoraIS = (c?.fechaI)! + " " + (c?.horaI!)! + ":00"
        let  hI = dateFormater.date(from: DiaHoraIS)
        print(hI)
        print(DPHoraF.date)
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
