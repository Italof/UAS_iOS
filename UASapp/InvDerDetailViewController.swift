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
    var invDocData: [InvestigationDocument] = []
    var versionDer: [String] = ["1.0","1.1","2.1"]
    var dowloadRoute: String?
    @IBOutlet weak var nameInvDer: UILabel!
    @IBOutlet weak var respInvDer: UITextView!
    @IBOutlet weak var limitDateInvDer: UILabel!
    //@IBOutlet weak var deliverDateInvDer: UILabel!
    @IBOutlet weak var percentageInvDer: UILabel!
    @IBOutlet var startDateInvDer: UILabel!
    var dataTaskD : URLSessionDataTask?
    @IBOutlet var versionInvDer: UIPickerView!
    @IBOutlet weak var observationInvDoc: UITextView!
    var viewer: UIDocumentInteractionController?
    
    @IBOutlet var downloadButton: UIButton!
    
    @IBOutlet var versionInvDerlbl: UILabel!
    @IBAction func downloadDocument(_ sender: AnyObject) {
        
        let route = "http://52.89.227.55/" + dowloadRoute!
        //let route = "http://www.uruguayeduca.edu.uy/Userfiles/P0001/File/El%20loro%20pelado_.pdf"
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
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        invDer = (parent as! InvNavViewController).invDer
        nameInvDer.text = invDer?.name?.uppercased()
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
        let get = (parent as! InvNavViewController).getDerivables
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
        if (invDocData.count == 0){
            versionDer.append("--")
            downloadButton.isHidden = true
            versionPicker.isHidden = true
            versionInvDerlbl.text = "No entregado"
            
        }
        
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
