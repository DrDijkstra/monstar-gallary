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
        monstarGalleryService = MonstarGallaryServiceImpl()
    }
    
    public static func initManager() -> Void {
       
        let domainModule = DomainModule()
        DomainModule.initModule(domainModule)
       
        
    }
    
    
    public func getMonstarGalleryService() -> MonstarGallaryService? {
        return monstarGalleryService
    }
    
     func getDatabaseService() -> DatabaseService? {
        return DomainModule.getInstance().getDbService()
    }
}
