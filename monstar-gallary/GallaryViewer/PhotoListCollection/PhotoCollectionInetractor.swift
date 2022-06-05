//
//  Interactor.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


protocol PhotoCollectionInetractor:AnyObject {
    var presenter:PhotoCollectionPresenter? {get set}
    func getAllPhotoListAccorddingTo(pageNumber: String, callback: @escaping (ApiCallResult<ImageUrlListEntity>) -> Void)->Void
    
}

class PhotoCollectionInetractorImpl: PhotoCollectionInetractor{
    
    weak var presenter: PhotoCollectionPresenter?
    
    var serviceManager:ServiceManger?
    
    
    
    func getAllPhotoListAccorddingTo(pageNumber: String, callback: @escaping (ApiCallResult<ImageUrlListEntity>) -> Void) {
        serviceManager = ServiceManger.getInstance()
        serviceManager?.getMonstarGalleryService()?.getPhotosBy(page: pageNumber, callback: {result in
            switch result{
            case .success(let response):
                callback(.success(sc: response))
                break
            case .failure(let erorr):
                callback(.failure(error: erorr))
                break
            }
            
        })
    }
    
    init(presenter: PhotoCollectionPresenter){
        self.presenter = presenter
    }
    
    
    
    
    
  
    
    
    
}
