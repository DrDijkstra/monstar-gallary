//
//  PhotoService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

protocol PhotoService {
    func checkUserStatus(_ mobileNumber:String, callback : @escaping (ApiCallResult<String>) -> Void) -> Void
}

class PhotoServiceImpl: PhotoService {
    func checkUserStatus(_ mobileNumber: String, callback: @escaping (ApiCallResult<String>) -> Void) {
        
    }
    
    let apiGwService:NetworkService
    init() {
//        let domainModule = DomainModule.getInstance()
//        apiGwService = domainModule.getApiGwService()
        
    }

    
    
}
