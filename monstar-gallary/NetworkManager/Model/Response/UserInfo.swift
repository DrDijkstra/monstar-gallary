//
//  UserInfo.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper


class UserInfo : ApiGwResponse{
    var id:String?
    var username:String?
    var name:String?
    var portfolio_url:String?
    var bio:String?
    var location:String?
    var total_likes:String?
    var total_photos:String?
    var total_collections:String?
    var instagram_username:String?
    var twitter_username:String?
    var profile_image:ProfileImageInfo?
    var links:LinksInfo?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        username <- map["username"]
        name <- map["name"]
        portfolio_url <- map["portfolio_url"]
        bio <- map["bio"]
        location <- map["location"]
        total_likes <- map["total_likes"]
        total_photos <- map["total_photos"]
        total_collections <- map["total_collections"]
        instagram_username <- map["instagram_username"]
        twitter_username <- map["twitter_username"]
        profile_image <- map["profile_image"]
        //links <- map["links"]
    }
    
    
    
    
    
}
