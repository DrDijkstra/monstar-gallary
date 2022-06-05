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
    func getPhotosBy(id: Int, callback: @escaping (DbCallResult<ImgUrlData>) -> Void)->Void
    
}

class PhotoCollectionInetractorImpl: PhotoCollectionInetractor{
    func getPhotosBy(id: Int, callback: @escaping (DbCallResult<ImgUrlData>) -> Void) {
        serviceManager.getDatabaseService()?.fetchImageUrlData(id: id, callback: { result in
            switch result{
            case .success(let sc):
                callback(.success(sc: sc))
            case .failure(let error):
                callback(.failure(error: error))
            }
        })
    }
    
    
    weak var presenter: PhotoCollectionPresenter?
    
    var serviceManager:ServiceManger = ServiceManger.getInstance()
    
    

    
    
    func getAllPhotoListAccorddingTo(pageNumber: String, callback: @escaping (ApiCallResult<ImageUrlListEntity>) -> Void) {
        
        serviceManager.getMonstarGalleryService()?.getPhotosBy(page: pageNumber, callback: {result in
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
