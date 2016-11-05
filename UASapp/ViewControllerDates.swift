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
    
    var citS: [cita]?
    /*
    
    tutorCode.text=tutorC?.codigo
    tutorName.text=tutorC?.nombre
    tutorEmail.text=tutorC?.correo
    tutorPhoneNumber.text=tutorC?.telefono
    tutorOffice.text=tutorC?.oficina
    tutorAnexo.text=tutorC?.anexo
    
    horaL.text=tutorC?.horarioL
    horaMa.text=tutorC?.horarioMa
    horaMi.text=tutorC?.horarioMi
    horaJ.text=tutorC?.horarioJ
    horaV.text=tutorC?.horarioV
 
    var datesA = ["12/07/2012","12/09/2016"]
    var times = ["12:00 pm","12:10 pm"]
    var themes = ["Academico","Academico"]
    var students = ["Pedro Perez","Juan Perez"]
    var statusA = ["Pendiente","Pendiente"]
    */
    var datesA = [String]()
    var times = [String]()
    var themes = [String]()
    var students = [String]()
    var statusA = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        citS = ((self.parent as! NavigationControllerC).citasOb)
        
        if ( citS != nil){
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
        
        self.Dates.reloadData()
 */

        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
