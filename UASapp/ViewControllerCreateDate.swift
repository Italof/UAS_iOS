//
//  ViewControllerCreateDate.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerCreateDate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var DateThemesList: UIPickerView!
    
    
    //Este array será alimentado por el contenido de la tabla de temas de reunion
    
    var Array = ["Rendimiento académico","económico","familiar","otros"]
    /*
    var PlacementAnswer =0
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateThemesList.delegate=self
        DateThemesList.dataSource=self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     
    Ejemplo de utilizar la opcion escogida del pickerview
    @IBAction func Submit(sender: AnyObject){
        if (PlacementAnswer == 0){
            Label.text = "Prueba"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PlacementAnswer = row
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
