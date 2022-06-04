//
//  PhotoService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


public protocol PhotoService {
   
    func getPhotosBy(pageNumber:String, callback : @escaping (ApiCallResult<ImageUrlsEntity>) -> Void) -> Void
}

class PhotoServiceImpl: PhotoService {
    
    func getPhotosBy(pageNumber: String, callback: @escaping (ApiCallResult<ImageUrlsEntity>) -> Void) {
        networkService.getPhotosBy(pageNumber: pageNumber, gwCallback: {result  in
            switch result {
            case .success(let apiResponse):
                let urlEntity = ImageUrlsEntity()
                for photoInfo in apiResponse.photos ?? []{
                    let urlInfo = ImageUrlData(url: photoInfo.urls ?? UrlInfo())
                    urlEntity.urls?.append(urlInfo)
                }
                callback(.success(sc: urlEntity))
                
                
                
            case .failure(let error):
                callback(.failure(error: error))
            }
        })
    }
    
    
    
    let networkService:NetworkService
    public init() {
        let domainModule = DomainModule.getInstance()
        networkService = domainModule.getNetworkService()
        
    }

    
    
}
