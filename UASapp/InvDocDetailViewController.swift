//
//  InvDocDetailViewController.swift
//  UASapp
//
//  Created by inf227al on 8/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class InvDocDetailViewController: UIViewController, UIDocumentInteractionControllerDelegate, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate   {
    var invDer: InvestigationDerivable?
    var invDoc: InvestigationDocument?
    @IBOutlet weak var nameInvDoc: UILabel!
    @IBOutlet weak var dateDeliverInvDoc: UILabel!
    @IBOutlet weak var versionInvDoc: UILabel!
    @IBOutlet weak var respInvDoc: UITextView!
    @IBOutlet weak var observationInvdoc: UITextView!
    var viewer: UIDocumentInteractionController?
    var dataTaskD : URLSessionDataTask?
    @IBAction func downloadDocument(_ sender: AnyObject) {
        
        let route = "http://52.89.227.55/" + "download"
        DownloadHelper.loadFileAsync(route: route,completion:{(path, error) in
            let isFileFound:Bool? = FileManager.default.fileExists(atPath: path!)
            if isFileFound == true {
                self.viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path!) as URL)
                self.viewer?.delegate = self
                self.viewer?.presentPreview(animated: true)
            }
        })
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        invDer = (parent as! InvNavViewController).invDer
        invDoc = (parent as! InvNavViewController).invDoc
        nameInvDoc.text = invDer?.name
        versionInvDoc.text = invDoc?.version
        observationInvdoc.text = invDoc?.observation
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let limitDate = dateFormat.date(from: (invDoc?.dateDeliver)!)
        dateFormat.dateFormat = "dd/MM/yyyy"
        dateDeliverInvDoc.text = dateFormat.string(from: limitDate!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFileAsync (route: String, completion: ((_ path: String?, _ error: NSError?) -> ())?) {
        let url = NSURL(string: route)
        let urlRequest = NSMutableURLRequest(url : url as! URL)
        print("REQUESTED URL: \(urlRequest)")
        urlRequest.httpMethod = "GET"
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationUrl = documentsUrl?.appendingPathComponent((url?.lastPathComponent!)!)
        if FileManager().fileExists(atPath: destinationUrl!.path) {
            print("file already exists [\(destinationUrl?.path)]")
            completion!(destinationUrl!.path, nil)
        }
        else
        {
                self.dataTaskD = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: {(responseData, response, responseError) in
                var error: NSError? = nil//, data: Any? = nil
                var path: String?
                if responseError != nil {
                    error = responseError as NSError?
                }
                else {
                    let httpResponse = response as! HTTPURLResponse
                    if httpResponse.statusCode == 200 {
                        do {
                            if (try responseData?.write(to: destinationUrl!) != nil) {
                                print("file saved [\(destinationUrl?.path)]")
                                path = destinationUrl?.path
                                completion!(destinationUrl!.path, error as NSError?)
                            } else {
                                print("error saving file")
                                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                                path = destinationUrl?.path
                                completion!(destinationUrl!.path, error)
                            }
                        } catch let err as NSError {
                            print(err)
                        }
                    }
                    else {
                        let strData = NSString(data: responseData!, encoding: String.Encoding.utf8.rawValue)! as String
                        error = NSError(domain: "HTTP", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : strData])
                    }
                }
                if let completion = completion {
                    DispatchQueue.main.async(execute: { () -> Void in
                        completion(path, nil)
                    })
                }
            })
            self.dataTaskD?.resume()
            //dataTask.resume()
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        var upload :Float = Float(bytesSent)/Float(totalBytesSent)
        
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
