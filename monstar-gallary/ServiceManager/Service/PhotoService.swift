//
//  PhotoService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


public protocol PhotoService {
   
    func getPhotosBy(pageNumber:String, callback : @escaping (ApiCallResult<ImageUrlListEntity>) -> Void) -> Void
}

class PhotoServiceImpl: PhotoService {
    
    func getPhotosBy(pageNumber: String, callback: @escaping (ApiCallResult<ImageUrlListEntity>) -> Void) {
        networkService.getPhotosBy(pageNumber: pageNumber, gwCallback: {result  in
            switch result {
            case .success(let apiResponse):
                let urlEntity = ImageUrlListEntity()
                for photoInfo in apiResponse.photos ?? []{
                    let urlInfo = ImageUrlData(res: photoInfo)
                    
                    self.databaseService.saveImageUrlData(urlData: urlInfo, callback: {
                        res in
                        //print(res)
                    })
                    urlEntity.urlList?.append(urlInfo)
                }
                callback(.success(sc: urlEntity))
                
                
                
            case .failure(let error):
                callback(.failure(error: error))
            }
        })
    }
    
    
    
    let networkService:NetworkService
    let databaseService:DatabaseService
    public init() {
        let domainModule = DomainModule.getInstance()
        networkService = domainModule.getNetworkService()
        databaseService = domainModule.getDbService()
    }

    
    
}
