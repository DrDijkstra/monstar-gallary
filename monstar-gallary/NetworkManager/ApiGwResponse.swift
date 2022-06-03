//
//  ApiGwResponse.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public class ApiGwResponse : Codable {
    public var reason : String? = nil
    public var message : String? = nil
    public var devMessage : String? = nil
   
    
    
    public init() {
        
    }

}
