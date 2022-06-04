//
//  LinksInfo.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper

class LinksInfo:ApiGwResponse{
    var selfString:String?
    var html:String?
    var download:String?
    var download_location:String?
    var photos:String?
    var likes:String?
    var portpolio:String?
    
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        selfString <- map["self"]
        html <- map["html"]
        download <- map["download"]
        download_location <- map["download_location"]
        photos <- map["photos"]
        download <- map["download"]
        download_location <- map["download_location"]
        photos <- map["photos"]

    }
}
