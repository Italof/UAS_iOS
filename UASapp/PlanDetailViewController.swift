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

    @IBAction func showActionSheet(_ sender: UIBarButtonItem) {
        
        // UIAlertController with the ActionSheet style is created
        let optionMenu = UIAlertController(title: nil, message: "Seleccionar", preferredStyle: .actionSheet)
        
        // Two actions are created which can be added to the Alert Controller. Note the use of a closure inside the brackets of the handler parameter
        let showActions = UIAlertAction(title: "Acciones", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "actionsSegue", sender: self)
        })
        let writeSuggestion = UIAlertAction(title: "Sugerencia", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "suggestionSegue", sender: self)
        })
        
        // Another action is created, this time with the Cancel style
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        // The actions are added to the Alert Controller
        optionMenu.addAction(showActions)
        optionMenu.addAction(writeSuggestion)
        optionMenu.addAction(cancelAction)
        
        // The Alert Controller is presented.
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actionsSegue" {
            let controller = segue.destination as! ActionsTableViewController
            controller.impPlan = self.impPlan
            print(self.impPlan.id)
        } else if segue.identifier == "suggestionSegue" {
            let controller = segue.destination as! SuggestionViewController
            controller.impPlan = self.impPlan
        }
    }
}
