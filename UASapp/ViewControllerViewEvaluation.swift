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

    @IBOutlet weak var labelTotalPreguntas: UILabel!
    @IBOutlet weak var labelCerr: UILabel!
    @IBOutlet weak var labelAbi: UILabel!
    @IBOutlet weak var labelArc: UILabel!
    @IBOutlet var labelPuntTot: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        labelTotalPreguntas.isHidden = true
        totalPreg.isHidden = true
        labelCerr.isHidden = true
        labelAbi.isHidden = true
        labelArc.isHidden = true
        pregAbi.isHidden = true
        pregArc.isHidden = true
        pregCer.isHidden = true
        puntaje.isHidden = true
        labelPuntTot.isHidden = true
        */
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
        
        totalPreg.text = "-"
        pregCer.text = "-"
        pregAbi.text = "-"
        pregArc.text = "-"
        puntaje.text = "-"
        descripcion.text = ev?.descripcion

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
