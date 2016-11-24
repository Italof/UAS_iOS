//
//  PeriodMeasurementViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PeriodMeasurementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userDefault = UserDefaults.standard
    
    
    @IBOutlet weak var tableView: UITableView!
    //var cycles = ["2015-1 al 2015-2", "2016-1 al 2016-2"]
    var periods: [Period] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //UserDefaults.standard.object(forKey: "TOKEN") as! String
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        let facultyId: Int = UserDefaults.standard.object(forKey: "SPECIALTY") as! Int
        print("token = " + token)
        HTTPHelper.get(route: "periods/"+String(facultyId)+"/list" + "?token=" + token, authenticated: true, completion:{ (error,data) in
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
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
            self.do_table_refresh()
        })
        
        
    }

    /*func loadData() {
        if(self.periods.count==0){
            let errorAlert = UIAlertController(title: "Error al filtrar citas!",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "Rango de fechas seleccionado no es válido"
            self.present(errorAlert, animated: true, completion: nil)
            
        }
        
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomPeriodCell
        let periodo = periods[indexPath.row] as Period
        
        cell.lblPeriod.text = periodo.cycleStart!+" al "+periodo.cycleEnd!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let period = periods[indexPath.row] as Period
        ((parent as! UASNavViewController).period) = period
        userDefault.set(period.id, forKey: "PERIOD")
    }

    func do_table_refresh()
    {
        if(periods.isEmpty){
            let errorAlert = UIAlertController(title: "Sin resultados",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "No se han encontrado periodos registrados para la especialidad"
            self.present(errorAlert, animated: true, completion: nil)
        }
        else{
            self.tableView.reloadData()
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
