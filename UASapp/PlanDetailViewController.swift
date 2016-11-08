//
//  PlanDetailViewController.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/7/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PlanDetailViewController: UIViewController {
    var impPlan : ImprovementPlan!

    @IBOutlet weak var lblTypeId: UILabel!
    @IBOutlet weak var lblTypeTopic: UILabel!
    @IBOutlet weak var lblTypeDesc: UILabel!
    
    @IBOutlet weak var lblFind: UILabel!
    @IBOutlet weak var lblCause: UILabel!
    @IBOutlet weak var lblProfessor: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblCreateAt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        
        lblTypeId.text = impPlan.typeCode
        lblTypeTopic.text = impPlan.typeTopic
        lblTypeDesc.text = impPlan.typeDesc
        
        lblFind.text = impPlan.find!
        lblCause.text = impPlan.cause!
        lblProfessor.text = impPlan.professor!
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        lblStartDate.text = dateFormatter.string(from: impPlan.startDate!)
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        lblCreateAt.text = dateFormatter.string(from: impPlan.createdAt!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
