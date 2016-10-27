//
//  ViewControllerStudentFilter.swift
//  UASapp
//
//  Created by inf227al on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerStudentFilter: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var statusS = ["Activo", "Inactivo"]
    var tutors = ["Miguel Guano","Aguilera"]

    @IBOutlet var tutorP: UIPickerView!
    @IBOutlet var status: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        status.delegate=self
        status.dataSource=self
        tutorP.delegate=self
        tutorP.dataSource=self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == status){
        return statusS[row]
        }
        else {
            return tutors[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == status){
            return statusS.count
        }
        else {
            return tutors.count
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    /*
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 10.0
    }
    */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
