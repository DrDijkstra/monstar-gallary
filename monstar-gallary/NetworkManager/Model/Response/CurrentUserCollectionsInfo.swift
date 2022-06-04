//
//  CurrentUserCollectionsInfo.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper

class CurrentUserCollectionsInfo:ApiGwResponse{
    var id:String?
    var tittle:String?
    var published_at:String?
    var last_collected_at:String?
    var updated_at:String?
    var cover_photo:String?
    var user:String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        tittle <- map["tittle"]
        published_at <- map["published_at"]
        updated_at <- map["updated_at"]
        last_collected_at <- map["last_collected_at"]
        cover_photo <- map["cover_photo"]
        user <- map["user"]
    }
}
