//
//  WatchListCell.swift
//  Magellan
//
//  Created by Abide on 1/25/18.
//  Copyright © 2018 Abide. All rights reserved.
//

import Foundation

//1 WatchListModel...

struct WatchListModel : Decodable {
	var apiName : String?
	var version : String?
	var responseCode : Int?
	var responseMessage : String?
	var responseData : ResponseData?

	enum CodingKeys: String, CodingKey {

		case apiName = "apiName"
		case version = "version"
		case responseCode = "responseCode"
		case responseMessage = "responseMessage"
		case responseData
	}
    
}


//2 ResponseData Inherited By WatchListModel...

struct ResponseData : Decodable {
    var userAccount : UserAccount?
    var watchLater : [WatchLater]?
    var aboutUs : String?
    var privacyPolicy : String?
    var termsConditions : String?
    
    enum CodingKeys: String, CodingKey {
        
        case userAccount
        case watchLater = "watchLater"
        case aboutUs = "aboutUs"
        case privacyPolicy = "privacyPolicy"
        case termsConditions = "termsConditions"
    }
    
}

//3 UserAccount Inherited By ResponseData...

struct UserAccount : Decodable {
    var email : String?
    var fname : String?
    var lname : String?
    var userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case fname = "fname"
        case lname = "lname"
        case userId = "userId"
    }
    
}

//4 WatchLater Inherited By UserAccount...

struct WatchLater : Decodable {
    let videoId : Int?
    let title : String?
    let imageUrl : String?
    let rokuImageUrl : String?
    let duration : String?
    let shortDescription : String?
    let seriesId : Int?
    let playlistId : Int?
    let episodesCount :Int?
    let playlistCount : Int?
    enum CodingKeys: String, CodingKey {
        
        case videoId = "videoId"
        case title = "title"
        case imageUrl = "imageUrl"
        case rokuImageUrl = "rokuImageUrl"
        case duration = "duration"
        case shortDescription = "shortDescription"
        case seriesId = "seriesId"
        case episodesCount = "episodesCount"
        case playlistId = "playlistId"
        case playlistCount = "playlistCount" 
    }
    
}
