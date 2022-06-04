//
//  ApiPhotosResponse.swift
//  monstar-gallary
//
//  Created by Sanjay on 4/6/22.
//

import Foundation
import ObjectMapper

class ApiPhotosResponse: ApiGwResponse{
    var photos:[PhotoInfo]?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        photos <- map["photos"]
    }
}
