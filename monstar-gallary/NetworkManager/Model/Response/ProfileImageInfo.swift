//
//  ProfileImageInfo.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper

class ProfileImageInfo:ApiGwResponse{
    var small:String?
    var medium:String?
    var large:String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        small <- map["small"]
        medium <- map["medium"]
        large <- map["large"]
    }
}
