//
//  ScheduleViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var CyclePicker: UIPickerView!
    var codes = ["INF392","INF290","INF291"]
    var courses = ["Proyecto de tesis 2", "Desarrollo de programas 2", "Ingenierìa de software"]
    var schedules = ["H1001","H1002","H0801"]
    var cycles = ["2015-1","2015-2","2016-1","2016-2"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //UserDefaults.standard.object(forKey: "TOKEN") as! String
        /*if AskConectivity.isInternetAvailable(){
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
        HTTPHelper.get(route: "..." + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayPeriods = dataUnwrapped as? [Any]
                self.cycles = []
                for period in arrayPeriods!{
                    let pr = period as! [String:AnyObject]
                    let id = pr["IdPeriodo"] as! Int
                    self.cycles.append(period)
                    self.do_table_refresh()
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCourseCell
        cell.lblCode.text=codes[indexPath.row]
        cell.lblCourse.text=courses[indexPath.row]
        cell.lblSchedule.text=schedules[indexPath.row]
        return cell
        /*let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCourseCell
        let periodo = cycles[indexPath.row] as Period
        
        cell.lblPeriod.text = periodo.cycleStart!+" al "+periodo.cycleEnd!
        return cell*/
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cycles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cycles.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let period = cycles[indexPath.row] as Period
        ((parent as! UASNavViewController).period) = period
    }*/
    
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
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
