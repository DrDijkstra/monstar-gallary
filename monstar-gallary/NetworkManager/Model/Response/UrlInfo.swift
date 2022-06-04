//
//  UrlInfo.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper


class UrlInfo:ApiGwResponse{
    var raw:String?
    var full:String?
    var regular:String?
    var small:String?
    var thumb:String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        raw <- map["raw"]
        full <- map["full"]
        regular <- map["regular"]
        small <- map["small"]
        thumb <- map["thumb"]

    }
}
