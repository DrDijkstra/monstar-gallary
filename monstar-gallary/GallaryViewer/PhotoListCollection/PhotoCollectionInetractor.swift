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
    func getPhotosBy(id: Int) ->ImgUrlData?
    func getPhotoListBy(idList: [Int])->[ImgUrlData]
    
    
}

class PhotoCollectionInetractorImpl: PhotoCollectionInetractor{
    func getPhotoListBy(idList: [Int])->[ImgUrlData]{
        return serviceManager.getDatabaseService()?.fetchImageUrlDataList(idList: idList) ?? []
    }
    func getPhotosBy(id: Int) -> ImgUrlData? {
        return serviceManager.getDatabaseService()?.fetchImageUrlData(id: id)
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
