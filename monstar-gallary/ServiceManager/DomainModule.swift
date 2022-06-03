//
//  DomainModule.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

class DomainModule {
    
    var networkService : NetworkService? = nil
    
    static var selfRef : DomainModule? = nil
    
    init() {
        networkService = NetworkServiceImpl()
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
}
