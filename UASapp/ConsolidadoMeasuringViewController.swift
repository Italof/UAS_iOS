//
//  ConsolidadoMeasuringViewController.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ConsolidadoMeasuringViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var PeriodPicker: UIPickerView!
    var periods: [Period] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        //UserDefaults.standard.object(forKey: "TOKEN") as! String
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        //let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        //let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        //print("ID user = " + idUser)
        print("token = " + token)
        HTTPHelper.get(route: "periods/1/list" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayPeriods = dataUnwrapped as? [Any]
                self.periods = []
                for period in arrayPeriods!{
                    let pr = period as! [String:AnyObject]
                    let id = pr["IdPeriodo"] as! Int
                    let idEsp = pr["IdEspecialidad"] as! String
                    let vigente = pr["Vigente"] as! String
                    let config = pr["configuration"] as! [String:AnyObject]
                    let cycleStart = config["cycle_academic_start"] as! [String:AnyObject]
                    let cycleStartName = cycleStart["Descripcion"] as! String
                    
                    let cycleEnd = config["cycle_academic_end"] as! [String:AnyObject]
                    let cycleEndName = cycleEnd["Descripcion"] as! String
                    let aceptacion = config["UmbralAceptacion"] as! String
                    let nivEsperado = config["NivelEsperado"] as! String
                    let nivCriterio = config["CantNivelCriterio"] as! String
                    let period : Period = Period.init(id: id,idEspecialidad:idEsp, vigente: vigente,cycleStart:cycleStartName,cycleEnd: cycleEndName,aceptacion:aceptacion, nivEsperado:nivEsperado, nivCriterio:nivCriterio)
                    self.periods.append(period)
                    self.do_picker_refresh()
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return periods[row].cycleStart! + " al " + periods[row].cycleEnd!
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periods.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func do_picker_refresh()
    {
        self.PeriodPicker.reloadAllComponents()
        
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
