//
//  InvDerDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDerDetailViewController: UIViewController, UIDocumentInteractionControllerDelegate ,UIPickerViewDataSource , UIPickerViewDelegate, UITextViewDelegate {
    var invDer: InvestigationDerivable?
    var invPr: InvestigationProject?
    var invDocData: [InvestigationDocument] = []
    var invInvData: [Responsible] = []
    var versionDer: [String] = []//["1.0","1.1","2.1"]
    var dowloadRoute: String?
    
    @IBOutlet weak var activityAll: UIActivityIndicatorView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
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
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var versionInvDerlbl: UILabel!
    @IBAction func downloadDocument(_ sender: AnyObject) {
        
        
        if (dowloadRoute != nil && dowloadRoute != "" )
        {
            var route = "http://52.89.227.55/" + dowloadRoute!
            route = route.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if(AskConectivity.isInternetAvailable()){
                DispatchQueue.main.async {
                    self.activity.startAnimating()
                }
                DownloadHelper.loadFileAsync(route: route,completion:{(path, error) in
                    let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
                    if isFileFound == true {
                        self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path!) as URL)
                        self.viewer?.delegate = self
                        self.viewer?.presentPreview(animated: true)
                        DispatchQueue.main.async {
                            self.activity.stopAnimating()
                            self.activity.isHidden = true
                        }
                    }
                })
            }
            else{
                let alertSuccess : UIAlertController = UIAlertController.init(title: "Error", message: "No conectado a internet", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                alertSuccess.addAction(action)
                self.present(alertSuccess,animated: false, completion:nil)
            }
            
        }
        else{
            let alertSuccess : UIAlertController = UIAlertController.init(title: "Error", message: "Documento no existe", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alertSuccess.addAction(action)
            self.present(alertSuccess,animated: false, completion:nil)
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    @IBOutlet var versionPicker: UIPickerView!
    var selectedVersion: Int = -1
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(versionDer.count)
        //print(invDocData.count)
        return versionDer[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           // print(versionDer.count)
            return versionDer.count
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedVersion = row
        dowloadRoute = invDocData[row].route
        print(dowloadRoute)
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
            if (id == idUser && (observationInvDoc.text.characters.count == 0)){
                observationInvDoc.isEditable = true
                registerObservation.isHidden = false
                observationInvDoc.backgroundColor = UIColor.white
            }
        }
        else{
            observationInvDoc.isEditable = false
            registerObservation.isHidden = true
            observationInvDoc.backgroundColor = UIColor.init(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
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
        if(parent != nil && selectedVersion == -1){
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
            activityAll.startAnimating()
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
                    self.registerObservation.isHidden = true
                    self.observationInvDoc.isEditable = false
                    //print(self.versionDer)
                    //print(self.invDocData)
                    if (self.invDocData.count == 0){
                        self.versionDer.append("--")
                        self.downloadButton.isHidden = true
                        self.versionPicker.isHidden = true
                        self.versionInvDerlbl.text = "No entregado"
                        self.deliverDateInvDer.text = "No entregado"
                        self.registerObservation.isHidden = true
                        
                    }
                    else{
                        self.dowloadRoute = self.invDocData[0].route
                        let dateFormat = DateFormatter()
                        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let dateDeliver = dateFormat.date(from: self.invDocData[0].dateDeliver!)
                        dateFormat.dateFormat = "dd/MM/yyyy"
                        let dateDeliverString = dateFormat.string(from: dateDeliver!)
                        self.deliverDateInvDer.text = dateDeliverString
                        self.observationInvDoc.text = self.invDocData[0].observation
                        self.versionPicker.dataSource = self
                        self.versionPicker.reloadAllComponents()
                        if (0 == self.invDocData.count-1){
                            //let parser = invPr?.idLeader
                            ///arreglar actualizacion de pantalla -- desaparece boton de registrar observacion y observaciones
                            let id = self.invPr?.idLeader
                            let idUser = (self.parent as! InvNavViewController).id
                            if ( id == idUser && (self.observationInvDoc.text.characters.count == 0)){
                                self.observationInvDoc.isEditable = true
                                self.registerObservation.isHidden = false
                            }
                        }
                        
                    }
                    
                }
                else {
                    //Mostrar error y regresar al menù principal
                    
                }
            })
            let idUser = (parent as! InvNavViewController).id
            let getInv = (parent as! InvNavViewController).getResponsibles
            let routeApiInv = "investigation/" + id + "/" + getInv + "?token=" + token
            HTTPHelper.get(route: routeApiInv, authenticated: true, completion: {(error,data) in
                if(error == nil){
                    //obtener data
                    let dataUnwrapped = data.unsafelyUnwrapped
                    let arrayDocument = dataUnwrapped as? [Any]
                    //self.invDocData = []
                    //self.versionDer = []
                    for doc in arrayDocument!{
                        let document = doc as! [String:AnyObject]
                        
                        //let group : InvestigationGroup =
                        let inv = Responsible( json: document )
                        self.invInvData.append( inv )
                        
                        //print(self.invGrData)
                        //print(pr["id"].unsafelyUnwrapped)
                    }
                    
                    var responsibles : String = ""
                    for inv in self.invInvData{
                        let name = inv.name! + " " + inv.lastNameP! + " " + inv.lastNameM!
                        responsibles = responsibles + "\n" + name
                    }
                    if(self.respInvDer.text.characters.count == 0){
                        self.respInvDer.text = responsibles
                    }
                    DispatchQueue.main.async {
                        self.activityAll.stopAnimating()
                        self.activityAll.isHidden = true
                    }
                }
                else {
                    //Mostrar error y regresar al menù principal
                    
                }
            })
            
            
            
            invDerEditButton.isEnabled = false
            //let profilePermited = (parent as! InvNavViewController).profilePermited
            let isConnected = AskConectivity.isInternetAvailable()
            //print(isConnected)
            //print(id); print("=="); print(invPr?.idLeader)
            
            if(isConnected != false && Int(idUser) == invPr?.idLeader){
                //si no se encuentra el perfil permitido
                //ocultar boton de editar
                invDerEditButton.isEnabled = true
            }
            
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            let lCurrentWidth = self.view.frame.size.width;
            let lCurrentHeight = self.view.frame.size.height;
            scrollView.contentSize=CGSize(width : lCurrentWidth, height : lCurrentHeight)
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InvestigatorEditViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        //observationInvDoc.text = "no hay" + "\n" + "problema"
    }
    var activeField: UITextView?
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextView){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextView){
        activeField = nil
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func invRegisterObservation(_ sender: AnyObject) {
        var errorM : String = "No se guardó correctamente"
        
        if (AskConectivity.isInternetAvailable() == false){
            errorM = "No conectado a internet"
            let alert : UIAlertController = UIAlertController.init(title: "Error", message: errorM, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
            alert.addAction(action)
            self.present(alert,animated: false, completion:nil)
        }
        else{
            if(observationInvDoc.text.characters.count == 0){
                errorM = "No hay observaciones"
                let alert : UIAlertController = UIAlertController.init(title: "Error", message: errorM, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                alert.addAction(action)
                self.present(alert,animated: false, completion:nil)
            }
            else{
                do{
                    let parser = invDocData[invDocData.count-1].id
                    let idDoc = String.init(parser)
                    let registerObs = (parent as! InvNavViewController).registerObs
                    let token = (parent as! InvNavViewController).token
                    let routeApi = "investigation/" + idDoc + "/" + registerObs + "?token=" + token
                    let json = NSMutableDictionary()
                    json.setValue(idDoc, forKey: "id")
                    json.setValue(observationInvDoc.text, forKey: "observacion")
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    let postData = decoded as! [String:AnyObject]
                    print(postData)
                    HTTPHelper.post(route: routeApi, authenticated: true, body : postData, completion: {(error,data) in
                        if(error != nil){
                            //Mostrar error y regresar al menù principal
                             print(error)
                            let alert : UIAlertController = UIAlertController.init(title: "Error", message: errorM, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler:nil)
                            alert.addAction(action)
                            self.present(alert,animated: false, completion:nil)
                        }
                        else {
                            //obtener data
                            ((self.parent as! InvNavViewController).invDer) = self.invDer
                            self.registerObservation.isHidden = true
                            let alertSuccess : UIAlertController = UIAlertController.init(title: "Guardado", message: "Observacion guardada", preferredStyle: .alert)
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
