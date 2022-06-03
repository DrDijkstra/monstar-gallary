//
//  DomainModule.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

class DomainModule {
    
    var networkService : NetworkService? = nil
    var photoService : PhotoService? = nil
    
    static var selfRef : DomainModule? = nil
    
    let requestInterceptor : Interceptor
    
    init() {
       
        requestInterceptor = Interceptor()
        networkService = NetworkServiceImpl(interceptor: requestInterceptor)
    }
    
    static func initModule(_ domainModule : DomainModule) {
        selfRef = domainModule
        
    }

    
    static func getInstance() -> DomainModule {
        return selfRef!
    }
    
    func getNetworkService() -> NetworkService {
        return networkService!
    }
    
    func getPhotoService() -> PhotoService {
        if (photoService == nil) {
            photoService = PhotoServiceImpl()
        }
        return photoService!
    }
}
