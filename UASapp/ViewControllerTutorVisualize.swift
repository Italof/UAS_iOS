//
//  ViewControllerTutorVisualize.swift
//  UASapp
//
//  Created by inf227al on 22/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerTutorVisualize: UIViewController {
    
    
    @IBOutlet var tutorCode: UILabel!
    
    @IBOutlet var tutorName: UILabel!
    
    @IBOutlet var tutorEmail: UILabel!
    
    @IBOutlet var tutorPhoneNumber: UILabel!
    
    @IBOutlet var tutorOffice: UILabel!
    
    @IBOutlet var tutorAnexo: UILabel!
    
    @IBOutlet weak var horaL: UILabel!
    @IBOutlet weak var horaMa: UILabel!
    @IBOutlet weak var horaMi: UILabel!
    @IBOutlet weak var horaJ: UILabel!
    @IBOutlet weak var horaV: UILabel!
    
    var tutorC: tutor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Estos labels serán alimentados por la info del tutor del alumno
       
        tutorC = ((self.parent as! NavigationControllerC).tutorOb)
        
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
