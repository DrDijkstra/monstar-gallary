//
//  PhotoService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


public protocol PhotoService {
   
    func getPhotosBy(pageNumber:String, callback : @escaping (ApiCallResult<String>) -> Void) -> Void
}

class PhotoServiceImpl: PhotoService {
    
    func getPhotosBy(pageNumber: String, callback: @escaping (ApiCallResult<String>) -> Void) {
        networkService.getPhotosBy(pageNumber: pageNumber, gwCallback: {_ in 
            
        })
    }
    
    
    
    let networkService:NetworkService
    public init() {
        let domainModule = DomainModule.getInstance()
        networkService = domainModule.getNetworkService()
        
    }

    
    
}
