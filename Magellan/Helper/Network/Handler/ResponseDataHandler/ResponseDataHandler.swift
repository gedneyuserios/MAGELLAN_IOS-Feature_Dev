//
//  ResponseDataHandler.swift
//  Magellan
//
//  Created by Deepak on 21/11/17.
//  Copyright © 2017 Intelligrape. All rights reserved.
//

import UIKit

class ResponseDataHandler: NSObject {

    // for creating models from Dictionary

    class func getResponseModelForFeaturedList(_ dic : [String : Any])->FeaturedListModel{
        return FeaturedListModel.init(data: dic)
    }
    class func getResponseModelForExploreList(_ dic : [String : Any])->ExploreListModel{
        return ExploreListModel.init(data: dic)
    }

    class func getResponseModelForExplore(_ dic : [String : Any])->ExploreLanderModel{
        return ExploreLanderModel.init(data: dic)
    }

    class func getResponseModelForGenresList(_ dic : [String : Any])->GenreListModel{
        return GenreListModel.init(data: dic)
    }
    class func getResponseModelForGenre(_ dic : [String : Any])->GenreModel{
        return GenreModel.init(data: dic)
    }
    
    class func getResponseModelForVideo(_ dic : [String : Any])-> VideoModel{
        return VideoModel.init(data: dic)
    }
    
    ///My
    class func getResponseModelForRate(_ dic : [String : Any])-> RateModel{
        return RateModel.init(dict: dic)
    }
      
}
