//
//  FeaturedListModel.swift
//  Magellan
//
//  Created by Deepak on 08/12/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class FeaturedListModel: NSObject {
    var count : Int?
    var featuredList = [FeaturedModel]()
    
    init(data : [String: Any]){
        count = data["count"] as? Int ?? -1
        
        if let array = data["responseData"]{
            for dic in array as! [Any]{
                print(dic)
                let featureModel = FeaturedModel.init(data: (dic as? [String : Any])!)
                
                if featureModel.contentList.count > 0{
                    featuredList.append(featureModel)
                }
            }
        }
    }
}

class FeaturedModel: NSObject {
    var featureId : Int = -1
    var title : String?
    var shortDescription = ""
    var uniqueDescription = ""
    var detailImageUrl = ""
    var imageName = ""
    var path = ""
    var contentList = [ContentModel]()
    var exploreId : Int = -1

    init(data : [String : Any]) {
        featureId = data["featureId"] as? Int ?? -1
        exploreId = data["exploreId"] as? Int ?? -1
        title = data["title"] as? String ?? ""
        shortDescription = data["shortDescription"] as? String ?? ""
        uniqueDescription = data["uniqueDescription"] as? String ?? ""
        detailImageUrl = data["detailImageUrl"] as? String ?? ""
        imageName = data["image_name"] as? String ?? ""
        path = data["path"] as? String ?? ""
        
        if let contentArray = data["contentList"] {
            for dic in contentArray as! [Any]{
                contentList.append(ContentModel.init(data: dic as! [String : Any]))
            }
        }
    }
}

class ContentModel : NSObject{
    var id : Int?
    var jwVideoId : String?
    var title : String?
    var shortDescription : String?
    var uniqueDescription : String?
    var videoViewCount : Int?
    var episodesCount : Int?
    var videoName : String?
    var imageUrl : String?
    var order : Int?
    var duration: String?
    var imageName : String?
    var path: String?
    var productType : ProductType?
    //my
    var resizedImage: String?
    var resizedmobileImage: String?
    var imagePath: String?
    
    init(data : [String : Any]) {
        
        if let dataId = data["videoId"]{
            id = dataId as? Int
            productType = ProductType.video
        }
        
        if let dataId = data["seriesId"]{
            id = dataId as? Int
            productType = ProductType.series
        }
        
        jwVideoId  = data["jw_video_id"] as? String ?? ""
        title = data["title"] as? String ?? ""
        shortDescription = data["shortDescription"] as? String ?? ""
        uniqueDescription = data["uniqueDescription"] as? String ?? ""
        videoViewCount = data["videoViewCount"] as? Int ?? -1
        episodesCount = data["episodesCount"] as? Int ?? -1
        videoName = data["videoName"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        order = data["order"] as? Int ?? -1
        duration = data["duration"] as? String ?? ""
        imageName =  data["image_name"] as? String ?? ""
        path = data["path"] as? String ?? ""
        //my
        resizedImage = data["resizedImage"] as? String ?? ""
        resizedmobileImage = data["resizedmobileImage"] as? String ?? ""
        imagePath = data["imagePath"] as? String ?? ""
    }
}
