//
//  HTTPHelper.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 10/26/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

let baseUrl = "https://private-b851e-uasiosapi.apiary-mock.com"
class HTTPHelper {
  
  class func request (route: String, method: String, body: [String:AnyObject]?, authenticated: Bool, completion: ((_ error: NSError?, _ data: [String:AnyObject]?) -> ())?) {
    let urlRequest = NSMutableURLRequest(url: URL(string: "\(baseUrl)\(route)")!)
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
      var error: NSError? = nil, data: [String:AnyObject]? = nil
      if responseError != nil {
        error = responseError as NSError?
      }
      else {
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode == 200 {
          do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData!, options: .mutableContainers) as? NSDictionary {
              data = (jsonResponse as! [String:AnyObject])
            }
          } catch let err as NSError {
            print(err)
          }
        }
        else {
          let strData = NSString(data: responseData!, encoding: String.Encoding.utf8.rawValue)! as String
          error = NSError(domain: "HTTP", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : "HTTP \(httpResponse.statusCode): \(strData)"])
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
  
  class func get(route:String, authenticated:Bool, completion:((_ error:NSError?, _ data:[String:AnyObject]?) -> ())?) {
    self.request(route: route, method: "GET", body: nil, authenticated:authenticated, completion: completion)
  }
  
  class func post(route:String, authenticated:Bool, body:[String:AnyObject]?, completion:((_ error:NSError?, _ data:[String:AnyObject]?) -> ())?) {
    self.request(route: route, method: "POST", body: body, authenticated:authenticated, completion: completion)
  }
  
  class func put(route:String, authenticated:Bool, body:[String:AnyObject]?, completion:((_ error:NSError?, _ data:[String:AnyObject]?) -> ())?) {
    self.request(route: route, method: "PUT", body: body, authenticated:authenticated, completion: completion)
  }
}
