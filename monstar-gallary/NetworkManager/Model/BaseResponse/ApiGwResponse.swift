//
//  ApiGwResponse.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import ObjectMapper

public class ApiGwResponse : Mappable {
    public var reason : String? = nil
    public var message : String? = nil
    public var devMessage : String? = nil
    required public init?(map: Map) {
        
    }
    public func mapping(map: Map) {
        reason    <- map["reason"]
        message         <- map["message"]
        devMessage      <- map["devMessage"]
    }
    
    public init() {}

}
