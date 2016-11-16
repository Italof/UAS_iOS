//
//  NavigationControllerC.swift
//  UASapp
//
//  Created by inf227al on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class NavigationControllerC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var tutorOb: tutor?
    var citasOb: [cita]?
    var alumnosOb: [alumno]?
    var citEsc: cita?
    var filtroCitas: String = "N"
    
    var citaCanRec: String = ""
    
    //Horario del tutor
    
    var horasL: [Int] = []
    var horasMa: [Int] = []
    var horasMi: [Int] = []
    var horasJ: [Int] = []
    var horasV: [Int] = []
    var horasS: [Int] = []
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
