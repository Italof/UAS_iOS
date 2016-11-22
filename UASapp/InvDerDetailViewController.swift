//
//  InvDerDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDerDetailViewController: UIViewController, UIDocumentInteractionControllerDelegate ,UIPickerViewDataSource , UIPickerViewDelegate {
    var invDer: InvestigationDerivable?
    var invPr: InvestigationProject?
    var invDocData: [InvestigationDocument] = []
    var invInvData: [Investigator] = []
    var versionDer: [String] = ["1.0","1.1","2.1"]
    var dowloadRoute: String?
    
    @IBOutlet weak var nameInvDer: UILabel!
    @IBOutlet weak var respInvDer: UITextView!
    @IBOutlet weak var limitDateInvDer: UILabel!
    @IBOutlet weak var deliverDateInvDer: UILabel!
    @IBOutlet weak var percentageInvDer: UILabel!
    @IBOutlet var startDateInvDer: UILabel!
    var dataTaskD : URLSessionDataTask?
    @IBOutlet var versionInvDer: UIPickerView!
    @IBOutlet weak var observationInvDoc: UITextView!
    var viewer: UIDocumentInteractionController?
    
    @IBOutlet weak var registerObservation: UIButton!
    @IBOutlet var downloadButton: UIButton!
    
    @IBOutlet var versionInvDerlbl: UILabel!
    @IBAction func downloadDocument(_ sender: AnyObject) {
        
        let route = "http://52.89.227.55/" + dowloadRoute!
        if (dowloadRoute != nil && dowloadRoute != "" )
        {
        DownloadHelper.loadFileAsync(route: route,completion:{(path, error) in
            let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
            if isFileFound == true {
                self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path!) as URL)
                self.viewer?.delegate = self
                self.viewer?.presentPreview(animated: true)
            }
        })
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    @IBOutlet var versionPicker: UIPickerView!
    var selectedVersion: Int = -1
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return versionDer[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return versionDer.count
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedVersion = row
        print(row)
        dowloadRoute = invDocData[row].route
        
        observationInvDoc.text = invDocData[row].observation
        //cambia fecha de entrrega
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateDeliver = dateFormat.date(from: invDocData[row].dateDeliver!)
        dateFormat.dateFormat = "dd/MM/yyyy"
        let dateDeliverString = dateFormat.string(from: dateDeliver!)
        deliverDateInvDer.text = dateDeliverString
        let idUser = (parent as! InvNavViewController).id
        //actualizar responsables
        if (row == invDocData.count-1){
            //let parser = invPr?.idLeader
            let id = invPr?.idLeader
            if (id == idUser && (observationInvDoc.text != "")){
                registerObservation.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var invDerEditButton: UIBarButtonItem!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        invDer = (parent as! InvNavViewController).invDer
        invPr = (parent as! InvNavViewController).invPr
        nameInvDer.text = (invDer?.name?.uppercased())!
        //versionInvDer.text = "Ultima Versión"
        percentageInvDer.text = String((invDer?.percentage)!) + "%"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let limitDate = dateFormat.date(from: (invDer?.dateLimit)!)
        let startDate = dateFormat.date(from: (invDer?.dateStart)!)
        dateFormat.dateFormat = "dd/MM/yyyy"
        let parser = invDer?.id
        let id = String.init(parser.unsafelyUnwrapped)
        let token = (parent as! InvNavViewController).token
        limitDateInvDer.text = dateFormat.string(from: limitDate!)
        startDateInvDer.text = dateFormat.string(from: startDate!)
        //deliverDateInvDer.text = "asdasdasd"
        let get = (parent as! InvNavViewController).getDocuments
        let routeApi = "investigation/" + id + "/" + get + "?token=" + token
        HTTPHelper.get(route: routeApi, authenticated: true, completion: {(error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayDocument = dataUnwrapped as? [Any]
                self.invDocData = []
                self.versionDer = []
                for doc in arrayDocument!{
                    let document = doc as! [String:AnyObject]
                    
                    //let group : InvestigationGroup =
                    let doc = InvestigationDocument( json: document )
                    self.invDocData.append( doc )
                    
                    self.versionDer.append(doc.version!)
                    //print(self.invGrData)
                    //print(pr["id"].unsafelyUnwrapped)
                }
                self.versionPicker.dataSource = self
                self.versionPicker.reloadAllComponents()
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })
        let idUser = (parent as! InvNavViewController).id
        let getInv = (parent as! InvNavViewController).getResponsibles
        let routeApiInv = "investigation/" + id + getInv + "?token=" + token
        HTTPHelper.get(route: routeApiInv, authenticated: true, completion: {(error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayDocument = dataUnwrapped as? [Any]
                self.invDocData = []
                self.versionDer = []
                for doc in arrayDocument!{
                    let document = doc as! [String:AnyObject]
                    
                    //let group : InvestigationGroup =
                    let inv = Investigator( json: document )
                    self.invInvData.append( inv )
                    
                    //print(self.invGrData)
                    //print(pr["id"].unsafelyUnwrapped)
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })
        var responsibles : String = ""
        for inv in invInvData{
            let name = inv.name
            responsibles = responsibles + "\n" + name!
        }
        respInvDer.text = responsibles
        if (invDocData.count == 0){
            versionDer.append("--")
            downloadButton.isHidden = true
            versionPicker.isHidden = true
            versionInvDerlbl.text = "No entregado"
            deliverDateInvDer.text = "No entregado"
            registerObservation.isHidden = true
        }
        invDerEditButton.isEnabled = false
        //let profilePermited = (parent as! InvNavViewController).profilePermited
        let isConnected = AskConectivity.isInternetAvailable()
        print(isConnected)
        print(id); print("=="); print(invPr?.idLeader)
        
        if(isConnected != false && Int(idUser) == invPr?.idLeader){
            //si no se encuentra el perfil permitido
            //ocultar boton de editar
            invDerEditButton.isEnabled = true
        }
        //observationInvDoc.text = "no hay" + "\n" + "problema"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func invRegisterObservation(_ sender: AnyObject) {
        var errorM : String = "No se guardó correctamente"
        
        if (AskConectivity.isInternetAvailable() == false){
            errorM = "No conectado a internet"
            let alert : UIAlertController = UIAlertController.init(title: errorM, message: "Error", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alert.addAction(action)
            self.present(alert,animated: false, completion:nil)
        }
        else{
            if(observationInvDoc.text == ""){
                errorM = "No hay observaciones"
                let alert : UIAlertController = UIAlertController.init(title: errorM, message: "Error", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                alert.addAction(action)
                self.present(alert,animated: false, completion:nil)
            }
            else{
                do{
                    let parser = invDocData[invDocData.count-1].id
                    let id = String.init(parser)
                    let registerObs = (parent as! InvNavViewController).registerObs
                    let token = (parent as! InvNavViewController).token
                    let routeApi = "investigation/" + id + registerObs + "?token=" + token
                    let json = NSMutableDictionary()
                    json.setValue(id, forKey: "id")
                    json.setValue(observationInvDoc.text, forKey: "observacion")
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    let postData = decoded as! [String:AnyObject]
                    HTTPHelper.post(route: routeApi, authenticated: true, body : postData, completion: {(error,data) in
                        if(error != nil){
                            //Mostrar error y regresar al menù principal
                            print(error)
                            let alert : UIAlertController = UIAlertController.init(title: errorM, message: "Error", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                            alert.addAction(action)
                            self.present(alert,animated: false, completion:nil)
                        }
                        else {
                            //obtener data
                            ((self.parent as! InvNavViewController).invDer) = self.invDer
                            let alertSuccess : UIAlertController = UIAlertController.init(title: "Observacion guardada", message: "Guardado", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                            alertSuccess.addAction(action)
                            self.present(alertSuccess,animated: false, completion:nil)
                        }
                        
                    })
                }
                catch let err as NSError{
                    print("JSON OBJECT ERROR: \(err)")
                }
            }
        }
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
