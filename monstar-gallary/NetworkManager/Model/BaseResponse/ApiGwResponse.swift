//
//  ApiGwResponse.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public class ApiGwResponse : Codable {
    public var reason : String?
    public var message : String?
    public var devMessage : String? 
   
    
    
    public init() {
        
    }

}
