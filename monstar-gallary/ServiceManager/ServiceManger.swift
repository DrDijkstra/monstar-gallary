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
    
    private init(){
        let domainModule = DomainModule()
        DomainModule.initModule(domainModule)
        monstarGalleryService = MonstarGallaryServiceImpl()
    }
    
    public static func initManager(sdkConfig : ServiceManagerConfig) -> Void {
     
    }
    
    
    public func getMonstarGalleryService() -> MonstarGallaryService? {
        return monstarGalleryService
    }
}
