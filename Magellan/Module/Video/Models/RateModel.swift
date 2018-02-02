//
//  RateModel.swift
//  Magellan
//
//  Created by Rahul on 1/27/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class RateModel: NSObject {
    
    var responseCode : Int?
    var responseMessage = ""
    
    init(dict : [String: Any]){
            responseCode = dict["responseCode"] as? Int ?? -1
            responseMessage = dict["responseMessage"] as? String ?? ""
        }
}
 
  

