//
//  ServiceManger.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public class ServiceManger {
    
    static var selfRef : ServiceManger? = nil
    
    var monstarGalleryService : MonstarGallaryService? = nil

    
    public static func getInstance() -> ServiceManger {
        guard selfRef != nil else {
            selfRef = ServiceManger()
            return selfRef!
            
        }
        return selfRef!
    }
    
    public func initManager(sdkConfig : ServiceManagerConfig) -> Void {
        monstarGalleryService = MonstarGallaryServiceImpl()
    }
    
    
    public func getMonstarGalleryService() -> MonstarGallaryService? {
        return monstarGalleryService
    }
}
