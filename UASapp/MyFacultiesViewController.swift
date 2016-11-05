//
//  MyFacultiesViewController.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class MyFacultiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var faculties: [Faculty] = []
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if AskConectivity.isInternetAvailable(){
            print("conectado")
        }
        else{
            print("error de conexion")
        }
        
        //let parser : Int = UserDefaults.standard.object( forKey: "IDUSER") as! Int
        //let idUser = String.init(parser)
        let token: String =  UserDefaults.standard.object( forKey: "TOKEN") as! String
        //print("ID user = " + idUser)
        print("token = " + token)
        HTTPHelper.get(route: "faculties" + "?token=" + token, authenticated: true, completion:{ (error,data) in
            if(error == nil){
                //obtener data
                let dataUnwrapped = data.unsafelyUnwrapped
                let arrayFculties = dataUnwrapped as? [Any]
                self.faculties = []
                for faculty in arrayFculties!{
                    let fa = faculty as! [String:AnyObject]
                    let id = fa["IdEspecialidad"] as! Int
                    let code = fa["Codigo"] as! String
                    let name = fa["Nombre"] as! String
                    let description = fa["Descripcion"] as! String
                    let coord: String?
                    if let coordData = fa["coordinator"] as? [String:AnyObject]{
                        
                        let coordName = coordData["Nombre"] as! String
                        let coordApePat = coordData["ApellidoPaterno"] as! String
                        let coordApeMat = coordData["ApellidoMaterno"] as! String
                        coord = coordName + " "+coordApePat + " "+coordApeMat
                    }
                    else{
                        coord = ""
                    }
                    let faculty : Faculty = Faculty.init(id: id,name:name, code:code,coordinator: coord,description: description)
                    self.faculties.append(faculty)
                    self.do_table_refresh()
                }
            }
            else {
                //Mostrar error y regresar al menù principal
                
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faculties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomMyFacultiesCell
        let faculty = faculties[indexPath.row] as Faculty
        
        cell.lblFaculty.text = faculty.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let faculty = faculties[indexPath.row] as Faculty
        ((parent as! UASNavViewController).faculty) = faculty
        
        userDefault.set(faculty.id, forKey: "SPECIALTY")
    }

    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
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
