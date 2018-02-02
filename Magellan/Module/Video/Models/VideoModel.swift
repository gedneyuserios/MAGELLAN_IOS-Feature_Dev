//
//  VideoModel.swift
//  Magellan
//
//  Created by Deepak on 14/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
    var uniqueDescription = ""
    var title = ""
    var jwpVideoId = "jwp_video_id"
    var duration = ""
    var playerId = ""
    var imageName = ""
    var ratingCount : Int?
    var ratePercentage : Double?
    var videoViewCount : Int?
    var videoName = ""
    var  path = ""
    var imageUrl = ""
    var jwpVideoUrl = ""
    var jwp_ad_url = ""
    var id : Int?
    var relatedContentArray = [RelatedModel]()
    var episodesCount = -1
    var episodeModelArray = [EpisodeListModel]()
    var rating = -1
    var productType : ProductType?
    
    init(data : [String: Any]){
        if let dict = data["responseData"] as? [String: Any] {
            uniqueDescription = dict["uniqueDescription"] as? String ?? ""
            title = dict["title"] as? String ?? ""
            jwpVideoId = dict["jwpVideoId"] as? String ?? ""
            duration = dict["duration"] as? String ?? ""
            playerId = dict["playerId"] as? String ?? ""
            imageName = dict["image_name"] as? String ?? ""
            ratingCount = dict["ratingCount"] as? Int ?? 0
            ratePercentage = dict["ratePercentage"] as? Double ?? 0.0
            videoViewCount = dict["videoViewCount"] as? Int ?? -1
            path = dict["path"] as? String ?? ""
            imageUrl = dict["imageUrl"] as? String ?? ""
            jwpVideoUrl = dict["jwp_video_url"] as? String ?? ""
            jwp_ad_url = dict["jwp_ad_url"] as? String ?? ""
            rating = dict["dictId"] as? Int ?? -1
            episodesCount = dict["episodesCount"] as? Int ?? -1
            
            
            if let dictId = dict["videoId"]{
                productType = ProductType.series
                id = dictId as? Int
            }
            
            if let dictId = dict["seriesId"]{
                id = dictId as? Int
                productType = ProductType.series
            }
            
            if let array = dict["relatedContent"] as? [[String : Any]]{
                for dic in array{
                    relatedContentArray.append(RelatedModel.init(data: dic))
                }
            }
            
            if let array = dict["episodeList"] as? [[String : Any]]{
                for dic in array{
                    episodeModelArray.append(EpisodeListModel.init(data: dic))
                }
            }

        }
    }
}

class RelatedModel : NSObject{
    var shortDescription = ""
    var title = ""
    var imageUrl = ""
    var path = ""
    var id : Int?
    var relatedOrder : Int?
    var imageName = ""
    var productType : ProductType?
    var episodesCount  =  -1
    var seriesCount = -1
    
    init(data : [String: Any]){
        
        shortDescription = data["short_description"] as? String ?? ""
        title = data["title"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        path = data["path"] as? String ?? ""
        imageName = data["image_name"] as? String ?? ""
        relatedOrder = data["relatedOrder"] as? Int ?? -1
        episodesCount = data["episodesCount"] as? Int ?? -1
        seriesCount = data["seriesCount"] as? Int ?? -1
        
        if let dictId = data["videoId"]{
            productType = ProductType.video
            id = dictId as? Int
        }
        
        if let dictId = data["seriesId"]{
            id = dictId as? Int
            productType = ProductType.series
        }
        
        if let dictId = data["exploreId"]{
            id = dictId as? Int
            productType = ProductType.explore
        }
        
        if let dictId = data["collectionId"]{
            id = dictId as? Int
            productType = ProductType.collection
        }
    }
}

class EpisodeListModel : NSObject{
    
    var shortDescription = ""
    var order : Int?
    var id : Int?
    var title = ""
    var jwVideoId = ""
    var imageUrl = ""
    var videoName = ""
    var duration = ""
    var path = ""
    var imageName = ""
    var productType : ProductType?

        
    init(data : [String: Any]){
    
        shortDescription = data["shortDescription"] as? String ?? ""
        order = data["order"] as? Int ?? -1
        title = data["title"] as? String ?? ""
        jwVideoId = data["jw_video_id"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        videoName = data["videoName"] as? String ?? ""
        duration = data["duration"] as? String ?? ""
        path = data["path"] as? String ?? ""
        imageName = data["image_name"] as? String ?? ""
        
        if let dictId = data["videoId"]{
            productType = ProductType.video
            id = dictId as? Int
        }
        
        if let dictId = data["seriesId"]{
            id = dictId as? Int
            productType = ProductType.series
        }
    }
}
