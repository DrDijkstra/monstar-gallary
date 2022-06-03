//
//  MonstarGallaryServiceImpl.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


class MonstarGallaryServiceImpl: MonstarGallaryService {
    var photoService: PhotoService 
    
    init() {
        let domainModule = DomainModule.getInstance()
        photoService = domainModule.getPhotoService()
        
    }
    
    func getPhotosBy(page: String, callback: @escaping (ApiCallResult<String>) -> Void) {
        photoService.getPhotosBy(pageNumber: page, callback: callback)
        
    }
    
    
    
    
    
    
}
