//
//  ViewControllerDates.swift
//  UASapp
//
//  Created by inf227al on 24/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerDates: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var Dates: UITableView!
    
    @IBOutlet var botonAtenderSinCita: UIButton!
    
    @IBOutlet weak var botonNuevaCitaM: UIButton!
    
    var citS: [cita]?
    
    var elegido: Int = -1
    
    var datesA = [String]()
    var times = [String]()
    var themes = [String]()
    var students = [String]()
    var statusA = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rol : String = UserDefaults.standard.object( forKey: "ROLTUTORIA") as! String
        
        if ( rol == "A"){
            botonAtenderSinCita.isHidden = true
        }
        
        let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        print("ID user = " + idUser)
        print("token = " + token)
        HTTPHelper.get(route: "getTutorInfo/" + idUser + "?token=" + token, authenticated: true, completion:{ (error,data) in
            
            if(error == nil){
                //obtener data
                self.botonNuevaCitaM.isHidden = false
            }
            else {
                print(error)
                //Se oculta el boton para realizar citas
                self.botonNuevaCitaM.isHidden = true
            }
        })
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //super.viewDidAppear()
        citS = ((self.parent as! NavigationControllerC).citasOb)
        
        if ( citS?.count != 0){
            for c in citS!{
                datesA.append(c.fechaI!)
                times.append(c.horaI!)
                themes.append(c.tema!)
                students.append(c.alumno!)
                statusA.append(c.estado!)
            }
        } else {
            //Mostrar error y regresar al menù principal
            let alert : UIAlertController = UIAlertController.init(title: "No tiene citas", message: "Usted no ha realizado citas", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion:nil)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = self.Dates.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellDate
        
        cell.date.text = datesA[indexPath.row]
        cell.time.text = times[indexPath.row]
        cell.theme.text = themes[indexPath.row]
        cell.student.text = students[indexPath.row]
        cell.status.text = statusA[indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Id de cita escogida")
        
        print(indexPath.row)
        
        /*
        let citEsc = (citS?[indexPath.row])! as cita
        elegido = indexPath.row
        
        ((self.parent as! NavigationControllerC).citEsc) = citEsc
        */
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
