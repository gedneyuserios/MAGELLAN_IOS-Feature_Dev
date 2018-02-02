//
//  ServiceManager.swift
//  Magellan
//
//  Created by Deepak on 21/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit
import Alamofire

class ServiceManager: NSObject {
    
    /// POST request
    ///
      func postRequest(_ url : String, parameters : [String : AnyObject], responseBlock:@escaping (_ status :Bool,  _ jsonResponse:AnyObject?, _ error:NSError?) -> Void ) {
        
        //My..
        if url.lowercased().range(of:"videorating") != nil {
            print("exists")
            //hideLoader()
        } else {
           showLoader()
        }
         
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            hideLoader()
            switch response.result {
            case .success:
                print(response.response?.statusCode ?? "Response Code")
                responseBlock(true, response.result.value as AnyObject?, nil)
            case .failure:
                responseBlock(false, nil, response.result.error as NSError?)
            }
        }
    }
    
    /// GET request
    ///
    func getRequest(_ url : String, parameters : [String: AnyObject], responseBlock:@escaping (_ status :Bool,  _ jsonResponse:AnyObject?, _ error:NSError?) -> Void ) {
        showLoader()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers:[:]).validate().responseJSON { response in
            hideLoader()
            switch response.result {
            case .success:
                responseBlock(true, response.result.value as AnyObject?, nil)
            case .failure:
                responseBlock(false, nil, response.result.error as NSError?)
            }
        }
    }
    
}
