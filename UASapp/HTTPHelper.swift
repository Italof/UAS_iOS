//
//  HTTPHelper.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 10/26/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

let baseUrl = "http://52.89.227.55/api/"
class HTTPHelper {
  
  class func request (route: String, method: String, body: [String:AnyObject]?, authenticated: Bool, completion: ((_ error: NSError?, _ data: Any?) -> ())?) {
    let urlRequest = NSMutableURLRequest(url: URL(string: "\(baseUrl)\(route)")!)
    print("REQUESTED URL: \(urlRequest)")
    urlRequest.httpMethod = method
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if authenticated {
      let userDefaults = UserDefaults.standard
      urlRequest.setValue(userDefaults.string(forKey: "userKey"), forHTTPHeaderField: "Authorization")
    }
    
    if let requestBody = body {
      do {
        try urlRequest.httpBody = JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
      } catch let err as NSError {
        print(err)
      }
    }
    
    let dataTask = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: {(responseData, response, responseError) in
      var error: NSError? = nil, data: Any? = nil
      if responseError != nil {
        error = responseError as NSError?
      }
      else {
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode == 200 {
          do {
            print("RESPONSE DATA: \(responseData)")
            let jsonResponse = try JSONSerialization.jsonObject(with: responseData!, options: [])
            print(jsonResponse)
            /*
            if let dictionary = jsonResponse as? [String:Any] {
                data = dictionary as [String:AnyObject]
                print("single")
            } else {
                print("array")
                let array = jsonResponse as? [Any]
                data = array?.first as? [String:AnyObject]
            }
            */
            data = jsonResponse
            print(data)
            
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
          completion(error, data)
        })
      }
    })
    
    dataTask.resume()
  }
  
  class func get(route:String, authenticated:Bool, completion:((_ error:NSError?, _ data:Any?) -> ())?) {
    self.request(route: route, method: "GET", body: nil, authenticated:authenticated, completion: completion)
  }
  
  class func post(route:String, authenticated:Bool, body:[String:AnyObject]?, completion:((_ error:NSError?, _ data:Any?) -> ())?) {
    self.request(route: route, method: "POST", body: body, authenticated:authenticated, completion: completion)
  }
  
  class func put(route:String, authenticated:Bool, body:[String:AnyObject]?, completion:((_ error:NSError?, _ data:Any?) -> ())?) {
    self.request(route: route, method: "PUT", body: body, authenticated:authenticated, completion: completion)
  }
}
