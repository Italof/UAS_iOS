//
//  ViewControllerViewEvaluation.swift
//  UASapp
//
//  Created by inf227al on 16/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ViewControllerViewEvaluation: UIViewController {
    
    @IBOutlet weak var codigo: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var vigencia: UILabel!
    @IBOutlet weak var tiempo: UILabel!
    @IBOutlet weak var totalPreg: UILabel!
    @IBOutlet weak var pregCer: UILabel!
    @IBOutlet weak var pregAbi: UILabel!
    @IBOutlet weak var pregArc: UILabel!
    @IBOutlet weak var puntaje: UILabel!
    @IBOutlet weak var descripcion: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let ev = ((self.parent as! NavigationControllerE).evalEsc)
        //let parser = ev?.id//
        codigo.text = String.init((ev?.id).unsafelyUnwrapped)
        nombre.text = ev?.nombre
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd"
        
        vigencia.text = dateformater.string(from: (ev?.vigenciaI)!) + " - " + dateformater.string(from: (ev?.vigenciaF)!)
        tiempo.text = String((ev?.tiempo).unsafelyUnwrapped)
        
        let tp0 = (ev?.numCerr)! + (ev?.numAbie)!
        let tp =  tp0 + (ev?.numArc)!
        totalPreg.text = String(tp)
        pregCer.text = String((ev?.numCerr).unsafelyUnwrapped)
        pregAbi.text = String((ev?.numAbie).unsafelyUnwrapped)
        pregArc.text = String((ev?.numArc).unsafelyUnwrapped)
        puntaje.text = String((ev?.puntajeTotal).unsafelyUnwrapped)
        descripcion.text = ev?.descripcion

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
