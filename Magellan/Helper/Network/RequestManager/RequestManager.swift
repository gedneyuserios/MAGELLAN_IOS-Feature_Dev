//
//  RequestManager.swift
//  Magellan
//
//  Created by Deepak on 08/12/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class RequestManager: NSObject {

    var BASE_URL_COMMON = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/featured/"
    
    func fetchHomeScreenData(responseBlock:@escaping (_ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let urlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/featured/"
        ServiceManager().getRequest(urlString, parameters: [:] as [String : AnyObject]) { (status, jsonResponse, error) -> Void in

            if (jsonResponse != nil) {
                let featuredListModel = ResponseDataHandler.getResponseModelForFeaturedList(jsonResponse as! [String : Any])
                responseBlock(true, featuredListModel, nil)
            } else {
                responseBlock(false, nil, error)
            }
        }
    }

    func fetchExploreData(responseBlock:@escaping (_ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let urlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/explorelander/"
        //      let urlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/exploresublander/1/10/10"
        ServiceManager().getRequest(urlString, parameters: [:] as [String : AnyObject]) { (status, jsonResponse, error) -> Void in
            if (jsonResponse != nil) {
                
                let jsonDict = self.getJSONStringFromDictionary(jsonResponse as! [String : AnyObject])
                print (jsonDict)
                
                let exploreListModel = ResponseDataHandler.getResponseModelForExploreList(jsonResponse as! [String : Any])
                responseBlock(true, exploreListModel, nil)
            } else {
                responseBlock(false, nil, error)
            }
        }
    }

    func fetchExploreSubCategoryData(exploreId: Int, index: Int, count: Int, responseBlock:@escaping (_ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let urlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/exploresublander/\(exploreId)/\(index)/\(count)"
        ServiceManager().getRequest(urlString, parameters: [:] as [String : AnyObject]) { (status, jsonResponse, error) -> Void in
            if (jsonResponse != nil) {

                let jsonDict = self.getJSONStringFromDictionary(jsonResponse as! [String : AnyObject])
                print (jsonDict)

                let exploreListModel = ResponseDataHandler.getResponseModelForExploreList(jsonResponse as! [String : Any])
                responseBlock(true, exploreListModel, nil)
            } else {
                responseBlock(false, nil, error)
            }
        }
    }

    func fetchGenresList(responseBlock:@escaping (_ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let urlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/genres/"
        ServiceManager().getRequest(urlString, parameters: [:] as [String : AnyObject]) { (status, jsonResponse, error) -> Void in
            if (jsonResponse != nil) {
                let genreListModel = ResponseDataHandler.getResponseModelForGenresList(jsonResponse as! [String : Any])
                responseBlock(true, genreListModel, nil)
            } else {
                responseBlock(false, nil, error)
            }
        }
    }

    func fetchGenreData(genreId: Int, index: Int, count: Int, responseBlock:@escaping (_ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let urlString = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/genres/\(genreId)/\(index)/\(count)"
        ServiceManager().getRequest(urlString, parameters: [:] as [String : AnyObject]) { (status, jsonResponse, error) -> Void in
            if let dataDict = jsonResponse!["responseData"] as? [String : Any] {
                let genreModel = ResponseDataHandler.getResponseModelForGenre(dataDict)
                responseBlock(true, genreModel, nil)
            } else {
                responseBlock(false, nil, error)
            }
        }
    }
    
    func getJSONStringFromDictionary(_ dic: Dictionary<String, AnyObject>) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
            return jsonString as String
        } catch let error as NSError {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func fetchVideoData(videoId : String, responseBlock:@escaping ( _ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let url = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/\(videoId)/"
        let urlString =  url
        
        ServiceManager().getRequest(urlString, parameters: [:] as [String : AnyObject]) { (status, jsonResponse, error) -> Void in
            
            if (jsonResponse != nil) {
                let json = self.getJSONStringFromDictionary(jsonResponse as! [String : AnyObject])
                print (json)
                let videoModel = ResponseDataHandler.getResponseModelForVideo(jsonResponse as! [String : Any])
                responseBlock(true, videoModel, nil)
            }
            else {
                responseBlock(false, nil, error)
            }

            
        }
    }
    
    //My..
    func fetchRateApi(paramS :[String : AnyObject],responseBlock:@escaping ( _ status :Bool,  _ responseModel:Any?, _ error:NSError?) -> Void ){
        let url = "http://ec2-52-11-60-37.us-west-2.compute.amazonaws.com/api/v4/videorating"
        let urlString =  url
    
        ServiceManager().postRequest(urlString, parameters: paramS ) { (status, jsonResponse, error) -> Void in
            
            if (jsonResponse != nil) {
                let json = self.getJSONStringFromDictionary(jsonResponse as! [String : AnyObject])
                print (json)
                let videoModel = ResponseDataHandler.getResponseModelForRate(jsonResponse as! [String : Any])
                responseBlock(true, videoModel, nil)
            }
            else {
                responseBlock(false, nil, error)
            }
    
            
        }
    }
    
    
    

}
