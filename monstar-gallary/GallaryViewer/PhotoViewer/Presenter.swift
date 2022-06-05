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
    
    
}

class PhotoCollectionPresenterImpl:PhotoCollectionPresenter{
    var router: PhotoRouter?
    
    var interaxtor: PhotoCollectionInetractor?
    
    init() {
        self.router = PhotoRouterImpl()
        self.interaxtor = PhotoCollectionInetractorImpl()
    }
    
    
}

  

