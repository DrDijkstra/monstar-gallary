//
//  Presenter.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


protocol PhotoCollectionPresenter{
    var router: PhotoRouter? {get set}
    var interaxtor:PhotoCollectionInetractor? {get set}
    
    func getAllPhotoListAccorddingTo(pageNumber: String)
    
    
}

class PhotoCollectionPresenterImpl:PhotoCollectionPresenter{
    
    
    func getAllPhotoListAccorddingTo(pageNumber: String) {
        
    }
    
    var router: PhotoRouter?
    var interaxtor: PhotoCollectionInetractor?
    
    init() {
        self.router = PhotoRouterImpl()
        self.interaxtor = PhotoCollectionInetractorImpl()
    }
    
    
}

  

