//
//  DownloadHelper.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/5/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class DownloadHelper {
    class func loadFileSync(route: String, completion:((_ path:String, _ error:NSError?) -> ())?) {
        let url = NSURL(string: route)
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationUrl = documentsUrl?.appendingPathComponent((url?.lastPathComponent!)!)
        if FileManager().fileExists(atPath: destinationUrl!.path) {
            print("file already exists [\(destinationUrl?.path)]")
            completion!(destinationUrl!.path, nil)
        } else if let dataFromURL = NSData(contentsOf: url as! URL){
            if dataFromURL.write(to: destinationUrl!, atomically: true) {
                print("file saved [\(destinationUrl?.path)]")
                completion!(destinationUrl!.path, nil)
            } else {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion!(destinationUrl!.path, error)
            }
        } else {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion!(destinationUrl!.path, error)
        }
    }
    
    
    
    class func loadFileAsync (route: String, completion: ((_ path: String?, _ error: NSError?) -> ())?) {
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
            let dataTask = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: {(responseData, response, responseError) in
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
            dataTask.resume()
        }
    }
    
    
    
    
    
/**
 * Funcion a utilizar para en el completion al descargar el archivo
 * Aumentar herencia a la vista UIDocumentInteractionControllerDelegate
 *
 * @param viewer -> se define en la clase de la vista
 *
 
    completion:{(path, error) in
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true {
            viewer = UIDocumentInteractionController(url: NSURL(fileURLWithPath: path) as URL)
            viewer.delegate = self
            viewer.presentPreview(animated: true)
         }
    }
 */

/**
 * Funcion para que funcione el download
 *
 *
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
     
 */
}
