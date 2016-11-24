//
//  ConsolidadoCoursesViewController.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class ConsolidadoCoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate  {
    
    var dowloadRoute: String?
    var viewer: UIDocumentInteractionController?
    @IBOutlet weak var tableView: UITableView!
    var schedule : Schedule?
    var evidences: [Evidence] =  []
    
    @IBOutlet var lblSchedule: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schedule = (parent as! UASNavViewController).schedule
        evidences = (schedule?.evidences)!
        
        let cadena = (schedule?.codeCourse)! + " - " + (schedule?.course)!
        lblSchedule.text = cadena + " Horario: " + (schedule?.code)!
        do_table_refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return evidences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomSpecialtyCell
        let evidence = evidences[indexPath.row] as Evidence
        cell.lblCycle.text=evidence.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Fila " + String(indexPath.row))
        let evidence = evidences[indexPath.row] as Evidence
        //let route = "http://52.89.227.55/" + dowloadRoute!
        let route = evidence.url
        //var route: String?
        //route = "http://www.uruguayeduca.edu.uy/Userfiles/P0001/File/El%20loro%20pelado_.pdf"
        if (route != nil && route != "" )
        {
            DownloadHelper.loadFileAsync(route: route!,completion:{(path, error) in
                if(path != nil){
                    let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
                    if isFileFound == true {
                        self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path!) as URL)
                        self.viewer?.delegate = self
                        self.viewer?.presentPreview(animated: true)
                    }
                }
                else{
                    let errorAlert = UIAlertController(title: "No se puede descargar",
                                                       message: nil,
                                                       preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil)
                    errorAlert.addAction(action)
                    errorAlert.message = "La ruta del archivo no existe en el sistema. Diculpe las molestias."
                    self.present(errorAlert, animated: true, completion: nil)
                }
            })
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    
    func do_table_refresh()
    {
        if(evidences.isEmpty){
            let errorAlert = UIAlertController(title: "Sin resultados",
                                               message: nil,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            errorAlert.addAction(action)
            errorAlert.message = "No se han encontrado evidencias de cursos para este horario"
            self.present(errorAlert, animated: true, completion: nil)
        }
        else{
            self.tableView.reloadData()
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
