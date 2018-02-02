//
//  GenreListModel.swift
//  Magellan
//
//  Created by Ashish Jain on 07/01/18.
//  Copyright © 2018 Intelligrape. All rights reserved.
//

import Foundation

class GenreListModel: NSObject {
    var count : Int?
    var genreList = [GenreModel]()

    init(data : [String: Any]){
        count = data["count"] as? Int ?? -1

        if let array = data["responseData"]{
            for dic in array as! [Any]{
                print(dic)
                genreList.append(GenreModel.init(data: (dic as? [String : Any])!))
            }
        }
    }
}

class GenreModel: NSObject {
    var genresId : Int = -1
    var title : String?
    var shortDescription = ""
    var detailImageUrl = ""
    var imageName = ""
    var path = ""
    var contentList = [ContentModel]()

    init(data : [String : Any]) {
        genresId = data["genresId"] as? Int ?? -1
        title = data["title"] as? String ?? ""
        shortDescription = data["shortDescription"] as? String ?? ""
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
