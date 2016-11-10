//
//  CourseViewController.swift
//  UASapp
//
//  Created by Medical_I on 10/28/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

    
    @IBOutlet weak var lblCycle: UILabel!
    @IBOutlet weak var lblSpecialty: UILabel!
    @IBOutlet weak var lblProfessor: UILabel!
    @IBOutlet weak var lblCourse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let course = (parent as! UASNavViewController).course
        let faculty = (parent as! UASNavViewController).faculty
        lblCycle.text = (course?.nivAcademico)!
        lblSpecialty.text = (faculty?.name)!
        lblCourse.text = (course?.code)! + " - " + (course?.name)!
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
