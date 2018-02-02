//
//  ExploreLanderModel.swift
//  Magellan
//
//  Created by Deepak on 09/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import UIKit

class ExploreListModel: NSObject {
    var count : Int?
    var exploreList = [ExploreLanderModel]()
    
    init(data : [String: Any]){
        count = data["count"] as? Int ?? -1
        
        if let array = data["responseData"]{
            for dic in array as! [Any]{
                print(dic)
                let explore = ExploreLanderModel.init(data: (dic as? [String : Any])!)
                    exploreList.append(explore)
            }
        }
    }
}

class ExploreLanderModel: NSObject {
    var title : String?
    var shortDescription = ""
    var uniqueDescription = ""
    var detailImageUrl = ""
    var imageName = ""
    var path = ""
    var exploreId : Int = -1
    var contentList = [ContentModel]()
    var subLanderList = [ExploreLanderModel]()
    
    init(data : [String : Any]) {
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
