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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Estos labels serán alimentados por la info del tutor del alumno
        
        tutorCode.text="234"
        tutorName.text="Juan Perez"
        tutorEmail.text="juan.perez@pucp.pe"
        tutorPhoneNumber.text="123456789"
        tutorOffice.text="Oficina V201"
        tutorAnexo.text="56"
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
