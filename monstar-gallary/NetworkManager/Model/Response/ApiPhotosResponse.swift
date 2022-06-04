//
//  ApiPhotosResponse.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper

class ApiPhotosResponse : ApiGwResponse{
    var id : String?
    var created_at : String?
    var updated_at : String?
    var width : String?
    var height : String?
    var color : String?
    var blur_hash : String?
    var likes : String?
    var liked_by_user : String?
    var description : String?
    var user:UserInfo?
    var currentUserCollections:[CurrentUserCollectionsInfo]?
    var url:UrlInfo?
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
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        width <- map["width"]
        height <- map["height"]
        color <- map["color"]
        blur_hash <- map["blur_hash"]
        description <- map["description"]
        user <- map["user"]
        currentUserCollections <- map["currentUserCollections"]
        blur_hash <- map["blur_hash"]
        url <- map["url"]
        links <- map["links"]
    }
    
    
    
    
    
    
}
