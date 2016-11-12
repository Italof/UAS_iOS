//
//  AportesByCourseController.swift
//  UASapp
//
//  Created by inf227al on 9/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class AportesByCourseController: UIViewController {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        let facultyId: Int = UserDefaults.standard.object(forKey: "SPECIALTY") as! Int
        let semesterId: Int = UserDefaults.standard.object(forKey: "SEMESTER") as! Int
        let courseId: Int = UserDefaults.standard.object(forKey: "COURSE") as! Int
        print("http://52.89.227.55/api/faculties/"+String(facultyId)+"/evaluated_courses/"+String(courseId)+"/semesters/" + String(semesterId) + "?token=" + token)
        let url = NSURL (string: "http://52.89.227.55/api/faculties/"+String(facultyId)+"/evaluated_courses/"+String(courseId)+"/semesters/" + /*String(semesterId)*/"1" + "?token=" + token);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        // Do any additional setup after loading the view.
        /*if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        HTTPHelper.get(route: "faculties/1/evaluated_courses/38/semesters/1" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                
            }
            else {
                //Mostrar error y regresar al men˘ principal
                
            }
        })*/

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
