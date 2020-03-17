//
//  RequestManager.swift
//  iosTest
//
//  Created by Vivek Gajbe on 03/16/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import UIKit
import Foundation


class RequestManager: NSObject
{
    let apologiesMessage = "We apologize this service is temporarily unavailable.Please try later."
   
    //MARK: - api call for get- post- put- apis
    /// common method is used for "Get" type of request
    ///
    /// - Parameters:
    ///   - strAPIName: api name (procedure name)
    ///   - strParameterName: param (always be empty)
    ///   - completion: return type
    func requestCommonApiMethodCall(strAPIName :String ,strMethodType:String,strParameterName : [Any] ,strHeaderToken : String  = ""  ,completion:@escaping (_ response:Dictionary<String, Any>,_ completed:Bool,_ errorMessage : String)->Void)  {
        let url : String = strAPIName// "\(MMUrlConstants.CommonUrl)\(strAPIName)"
        
        //let headers = strHeader
        let headers = [
            "Content-Type": "application/json",
            "cache-control": "no-cache",
            ]
        
        do{
            let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 60.0)
            if strMethodType == "GET"
            {
                request.httpMethod = "GET"
            }
            else
            {
                request.httpMethod = (strMethodType == "POST" ? "POST" : "PUT")
            }
            
            request.allHTTPHeaderFields = headers
            
            if strMethodType == "POST" || strMethodType == "PUT" {
                let postData = try JSONSerialization.data(withJSONObject: strParameterName, options: [])
                request.httpBody = postData as Data
            }
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    //completion(["":""],false,error as? String ?? OCCustomAlertString.WebServiceError )
                } else {
                    DispatchQueue.main.async {
                        let httpResponse = response as! HTTPURLResponse
                        let statusCode = httpResponse.statusCode
                        if (statusCode == 202) {
                            completion(["":""],true,error as? String ?? self.apologiesMessage )
                        }
                        else
                        if (statusCode == 200) {
                            completion(["":""],true,error as? String ?? self.apologiesMessage )
                        }
                        else if(statusCode == 400)
                        {
                            completion(["":""],false,error as? String ?? self.apologiesMessage )
                        }
                        else
                        {
                            completion(["":"" as AnyObject],false,error as? String ?? self.apologiesMessage)
                        }
                    }
                }
            })
            dataTask.resume()
        }catch {
            print("Error with Json: \(error)")
            completion(["":"" as AnyObject],false,error as? String ?? self.apologiesMessage)
        }
    }
    //MARK: - api call for get- post- put- apis
    /// common method is used for "Get" type of request
    ///
    /// - Parameters:
    ///   - strAPIName: api name (procedure name)
    ///   - strParameterName: param (always be empty)
    ///   - completion: return type
    func requestCommonApiMethodCall_WithParam(strAPIName :String ,strMethodType:String,strParameterName : [String:Any] ,strHeaderToken : String  = ""  ,completion:@escaping (_ response: [String:Any],_ completed:Bool,_ errorMessage : String)->Void)  {
        let url : String = strAPIName// "\(MMUrlConstants.CommonUrl)\(strAPIName)"
        
        //let headers = strHeader
        let headers = [
            "Content-Type": "application/json",
            "cache-control": "no-cache",
        ]
        
        do{
            let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 60.0)
            if strMethodType == "GET"
            {
                request.httpMethod = "GET"
            }
            else
            {
                request.httpMethod = (strMethodType == "POST" ? "POST" : "PUT")
            }
            
            request.allHTTPHeaderFields = headers
            
            if strMethodType == "POST" || strMethodType == "PUT" {
                let postData = try JSONSerialization.data(withJSONObject: strParameterName, options: [])
                request.httpBody = postData as Data
            }
            let session = URLSession.shared
            
            let base = BaseViewController()
            if base.isConnectedToNetwork() == false
            {
                completion(["":""],false,"Internet connection is not available")
                return
            }
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    completion(["":""],false,error as? String ?? self.apologiesMessage )
                } else {
                    DispatchQueue.main.async {
                        let httpResponse = response as! HTTPURLResponse
                        let statusCode = httpResponse.statusCode
                            if (statusCode == 200) {
                                guard let data = data else { return }
                                do {
                                    let json = try JSONSerialization.jsonObject(with: data, options: []) 
                                    
                                    if let code = json as? Array<Any> //Check for the array
                                    {
                                        let dictata : [String: Any] = ["data" : code]
                                        completion(dictata,true, self.apologiesMessage)
                                    }
                                    else if let jsonData = json as? [String:Any] //Check for the code tag
                                    {
                                        completion(jsonData,true, self.apologiesMessage)
                                    }
                                    else
                                    {
                                        completion(["":""],true, self.apologiesMessage)
                                    }
                                    
                                } catch let jsonErr {
                                    print("Error serializing json:", jsonErr)//No Value in JSON
                                    completion(["":""],true,error as? String ?? self.apologiesMessage )
                                }
                            }
                            else if(statusCode == 400)
                            {
                                completion(["":""],false,error as? String ?? self.apologiesMessage )
                            }
                            else
                            {
                                completion(["":""],false,error as? String ?? self.apologiesMessage)
                        }
                    }
                }
            })
            dataTask.resume()
        }catch {
            print("Error with Json: \(error)")
            completion(["":""],false,error as? String ?? self.apologiesMessage)
        }
    }
    //MARK: - Header response
    func requestCommonApiMethodCall_WithHeaderResponse(strAPIName :String ,strMethodType:String,strParameterName : [String:Any] ,strHeaderToken : String  = ""  ,completion:@escaping (_ response: HTTPURLResponse,_ completed:Bool,_ errorMessage : String)->Void)  {
        let url : String = strAPIName// "\(MMUrlConstants.CommonUrl)\(strAPIName)"
        
        //let headers = strHeader
        let headers = [
            "Content-Type": "application/json",
            "cache-control": "no-cache",
        ]
        
        do{
            let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 60.0)
            if strMethodType == "GET"
            {
                request.httpMethod = "GET"
            }
            else
            {
                request.httpMethod = (strMethodType == "POST" ? "POST" : "PUT")
            }
            
            request.allHTTPHeaderFields = headers
            
            if strMethodType == "POST" || strMethodType == "PUT" {
                let postData = try JSONSerialization.data(withJSONObject: strParameterName, options: [])
                request.httpBody = postData as Data
            }
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    completion(HTTPURLResponse(),false,error as? String ?? self.apologiesMessage )
                } else {
                    DispatchQueue.main.async {
                        let httpResponse = response as! HTTPURLResponse
                        let statusCode = httpResponse.statusCode
                        
                        if (statusCode == 200) {
                            if let httpResponse = response as? HTTPURLResponse {
                                completion(httpResponse,true,error as? String ?? self.apologiesMessage )
                            }
                        }
                        else if(statusCode == 400)
                        {
                            completion(HTTPURLResponse(),false,error as? String ?? self.apologiesMessage )
                        }
                        else
                        {
                            completion(HTTPURLResponse(),false,error as? String ?? self.apologiesMessage)
                        }
                    }
                }
            })
            dataTask.resume()
        }catch {
            print("Error with Json: \(error)")
            completion(HTTPURLResponse(),false,error as? String ?? self.apologiesMessage)
        }
    }
}



