//
//  ServiceManger.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public class ServiceManger {
    
    static var selfRef : ServiceManger? = nil
    
    
    
    public static func getInstance() -> ServiceManger {
        guard selfRef != nil else {
            selfRef = ServiceManger()
            return selfRef!
            
        }
        return selfRef!
    }
}
