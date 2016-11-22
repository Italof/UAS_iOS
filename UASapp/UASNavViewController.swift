//
//  UASNavViewController.swift
//  UASapp
//
//  Created by inf227al on 2/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class UASNavViewController: UINavigationController {
    
    //Periodo de medición escogido
    var period: Period?
    //Curso de la especialidad escogido
    var course: Course?
    //Especialidad
    var faculty: Faculty?
    //Semestre
    var semester: Semester?
    //Horario
    var schedule: Schedule?
    //Alumno
    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
