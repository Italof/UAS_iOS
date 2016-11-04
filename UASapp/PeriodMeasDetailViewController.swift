//
//  PeriodMeasDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 21/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class PeriodMeasDetailViewController: UIViewController {
    var period : Period?

    @IBOutlet var cycleStart: UILabel!
    @IBOutlet var cycleEnd: UILabel!
    @IBOutlet var levelCriterio: UILabel!
    @IBOutlet var levelAproving: UILabel!
    @IBOutlet var prctgAproving: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        period = (parent as! UASNavViewController).period
        cycleStart.text=period?.cycleStart
        cycleEnd.text = period?.cycleEnd
        levelCriterio.text = period?.nivCriterio
        levelAproving.text = period?.nivEsperado
        prctgAproving.text=(period?.aceptacion)! + "%"
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
